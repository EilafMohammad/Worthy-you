import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worthy_you/screens/home/home_screen.dart';

import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/styles.dart';
import 'package:flutter_sound/flutter_sound.dart';
import '../../utils/DimLoadingDialog.dart';
import '../../utils/pref_utils.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http_parser/http_parser.dart';

import '../widget/btn_primary.dart';

typedef _Fn = void Function();

const theSource = AudioSource.microphone;

class FourthOnboard extends StatefulWidget {
  const FourthOnboard({super.key});

  @override
  _FourthOnboardState createState() => _FourthOnboardState();
}

class _FourthOnboardState extends State<FourthOnboard> {
  Codec _codec = Codec.aacMP4;
  String _mPath = 'tau_file.mp4';
  String _mPathToSend = '';

  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  String voice = "";
  String email = "";
  bool isRecording = false;
  bool isRecorded = false;

  @override
  void initState() {
    _mPlayer!.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
    getUserVoiceByEmail();
    super.initState();
  }

  Future<String?> getUserVoiceByEmail() async {
    email = await MyPrefUtils.getString(MyPrefUtils.userEmail);
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot emailQuery =
          await users.where('email', isEqualTo: email).get();

      if (emailQuery.docs.isNotEmpty) {
        voice = emailQuery.docs.first['voice'];
        return emailQuery.docs.first['voice'];
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      print('Error retrieving user voice: $e');
      return null; // Return null or handle the error as needed
    }
  }

  @override
  void dispose() {
    _mPlayer!.closePlayer();
    _mPlayer = null;

    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    // if (!kIsWeb) {
      // var status = await Permission.microphone.request();
      // if (status != PermissionStatus.granted) {
      //   throw RecordingPermissionException('Microphone permission not granted');
      // }
    // }
    await _mRecorder!.openRecorder();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = 'tau_file.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    _mRecorderIsInited = true;
  }

  // ----------------------  Here is the code for recording and playback -------

  void record() {
    _mRecorder!
        .startRecorder(
      toFile: _mPath,
      codec: _codec,
      audioSource: theSource,
    )
        .then((value) {
      setState(() {});
    });
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      setState(() {
        _mPathToSend = value ?? "";
        _mplaybackReady = true;
      });
    });
  }

  void play() {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder!.isStopped &&
        _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
            fromURI: _mPath,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {
              setState(() {});
            })
        .then((value) {
      setState(() {});
    });
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
      setState(() {});
    });
  }

// ----------------------------- UI --------------------------------------------

  _Fn? getRecorderFn() {
    if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
      return null;
    }
    return _mRecorder!.isStopped ? record : stopRecorder;
  }

  _Fn? getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder!.isStopped) {
      return null;
    }
    return _mPlayer!.isStopped ? play : stopPlayer;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            Constants.lblSubmitVocieSample,
            style: Styles.titleStyle,
          ),
          Expanded(child: Container()),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Text(
                  Constants.lblSubmitYouSelfTalking,
                  style:
                      Styles.headingStyle.copyWith(color: MyColors.colorBlack),
                ),
                SizedBox(height: height * 0.05),
                Center(
                  child: GestureDetector(
                    onTapDown: (_) async {
                      if (voice.isEmpty) {
                        setState(() {
                          isRecording = true;
                          isRecorded = false;
                        });
                        final recorderFn = getRecorderFn();
                        if (recorderFn != null) {
                          recorderFn(); // Start recording
                        }
                      } else {
                        await MyPrefUtils.putString(MyPrefUtils.voiceTemplate, voice);
                        Get.offAllNamed(HomeScreen.tag);
                      }
                    },
                    onTapUp: (_) async {
                      if (voice.isEmpty) {
                        setState(() {
                          isRecording = false;
                          isRecorded = true;
                        });
                        final recorderFn = getRecorderFn();
                        if (recorderFn != null) {
                          recorderFn(); // Start recording
                        }
                      } else {
                        setState(() {
                          isRecording = false;
                          isRecorded = true;
                        });

                        Get.offAllNamed(HomeScreen.tag);
                      }
                    },
                    child: Image.asset(
                      "images/icon_mic.png",
                      width: height * 0.15,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  Constants.lblPressAndHold,
                  textAlign: TextAlign.center,
                  style: Styles.textSmallStyleBold.copyWith(color: Colors.grey),
                ),
                SizedBox(height: height * 0.05),

                (!isRecording && isRecorded)
                    ? Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40),
                  child: PrimaryButton(
                    title: Constants.labelSubmit,
                    backgroundColor: MyColors.btnColorSecondaryDark,
                    onPressed: () {
                      if (voice.isEmpty) {
                        if (_mPathToSend.isNotEmpty == true) {
                          uploadFile(_mPathToSend ?? "");
                        }
                      } else {
                        Get.offAllNamed(HomeScreen.tag);
                      }
                    },
                  ),
                )
                    : Center(
                  child: (!isRecording)
                      ? Container()
                      : Text(
                    Constants.lblRecording,
                    textAlign: TextAlign.start,
                    style: Styles.textStyleBold.copyWith(
                        color: Colors.grey, height: 1.5),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> uploadFile(String path) async {
    var dialog = DimLoadingDialog(context,
        blur: 3,
        dismissable: false,
        backgroundColor: const Color(0x30000000),
        animationDuration: const Duration(milliseconds: 100));
    dialog.show();
    var email = await MyPrefUtils.getString(MyPrefUtils.userEmail);

    final url = Uri.parse('https://api.play.ht/api/v2/cloned-voices/instant');
    final headers = {
      'AUTHORIZATION': 'b274ada64cf546cd81d2d3d1cc06b9d1',
      'X-USER-ID': 'wPl2qGTQd6MEFzz7oE3Maqc0wvd2',
      'accept': 'application/json',
    };
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['voice_name'] = 'sales-voice';

    var filePath = path;
    request.files.add(await http.MultipartFile.fromPath(
      'sample_file',
      filePath,
      contentType: MediaType('audio', 'mp4'),
    ));
    try {
      var response = await request.send();

      if (response.statusCode == 201) {
        print("File uploaded successfully");
        var responseBody = await response.stream.bytesToString();

        var jsonResponse = json.decode(responseBody);
        var id = jsonResponse['id'];
        await MyPrefUtils.putString(MyPrefUtils.voiceTemplate, id);

        updateUserVoiceByEmail(email, id).then((val){
          if(val){
            Get.offAllNamed(HomeScreen.tag);
          }
        });
        dialog.dismiss();
      } else {
        dialog.dismiss();
        print("File upload failed: ${response.statusCode}");
        var responseBody = await response.stream.bytesToString();

        var jsonResponse = json.decode(responseBody);
        var errorMessage = jsonResponse['error_message'];

        print("Error message: $errorMessage");
        _errorMessage(errorMessage);
      }
    } catch (e) {
      dialog.dismiss();
      print("Error: $e");
      _errorMessage("Error: $e");
    }
  }

  Future<bool> updateUserVoiceByEmail(String email, String newVoice) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot emailQuery =
          await users.where('email', isEqualTo: email).get();

      if (emailQuery.docs.isNotEmpty) {
        String docId = emailQuery.docs.first.id;

        await users.doc(docId).update({'voice': newVoice});
        await MyPrefUtils.putString(MyPrefUtils.voiceTemplate, newVoice);

        return true;
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      print('Error updating user voice: $e');
      return false;
    }
  }
  void _errorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          style: Styles.normalText.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.red));
  }
}
