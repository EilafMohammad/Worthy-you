// File: screens/onboarding_screen.dart

import 'dart:convert';

import 'package:audio_session/audio_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http_parser/http_parser.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:worthy_you/screens/Splash_screen.dart';
import 'package:worthy_you/utils/colors.dart';
import 'package:worthy_you/utils/constants.dart';
import 'package:worthy_you/utils/pref_utils.dart';
import 'package:worthy_you/utils/styles.dart';
import 'package:http/http.dart' as http;

import '../../utils/DimLoadingDialog.dart';
import '../onbaording/fourth_onboard.dart';
import '../widget/btn_primary.dart';

import 'package:flutter_sound/flutter_sound.dart';
import 'dart:async';

typedef _Fn = void Function();

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static String tag = "/profile_screen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name = "N/A";
  bool isHaveVoice = false;
  String voice = "";

  // voice Clone Work
  Codec _codec = Codec.aacMP4;
  String _mPath = 'tau_file.mp4';
  String _mPathToSend = '';

  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  String existVoice = "";
  String email = "";
  bool isRecording = false;
  bool isRecorded = false;

  @override
  void initState() {
    _loadUserData();
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
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
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

  void _loadUserData() async {
    String? userName = await MyPrefUtils.getString(MyPrefUtils.userName);
    existVoice = await MyPrefUtils.getString(MyPrefUtils.voiceTemplate);
    if (existVoice.isNotEmpty) {
      isHaveVoice = true;
    }

    setState(() {
      name = userName ?? ''; // Update the state with the retrieved name
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    if (height < width) {
      width = height;
      height = width;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      Get.back();
                    },
                    icon: const ImageIcon(
                      AssetImage(
                        "images/icon_back.png",
                      ),
                      size: 30.0,
                    )),
                SizedBox(
                  height: 70,
                  child: Image.asset(
                    "images/profile_image.png",
                  ),
                ),
                const SizedBox(
                  width: 60,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "${name}",
                textAlign: TextAlign.start,
                style: Styles.boldHeading.copyWith(color: MyColors.darkBlue),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 25,
                      child: Image.asset("images/profile_icon.png")),
                  Text(
                    Constants.labelAccountSecurity,
                    textAlign: TextAlign.start,
                    style: Styles.textStyleBold.copyWith(color: Colors.grey),
                  ),
                  Container(
                      height: 20,
                      child: Image.asset("images/arrow_towards_right.png")),
                ],
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () async {
                  if (await MyPrefUtils.getBool(MyPrefUtils.isGoogleLoggedIn)) {
                    _signOut();
                    await MyPrefUtils.clearCaches();
                    Get.offAllNamed(SplashScreen.tag);
                  } else {
                    await MyPrefUtils.clearCaches();
                    Get.offAllNamed(SplashScreen.tag);
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 25,
                        child: Image.asset("images/logout_icon.png")),
                    Text(
                      Constants.labelLogout,
                      textAlign: TextAlign.start,
                      style: Styles.textStyleBold.copyWith(color: Colors.grey),
                    ),
                    Container(
                        height: 20,
                        child: Image.asset("images/arrow_towards_right.png")),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 25,
                      child: Image.asset("images/language_icon.png")),
                  Text(
                    Constants.labelLanguage,
                    textAlign: TextAlign.start,
                    style: Styles.textStyleBold.copyWith(color: Colors.grey),
                  ),
                  Container(
                      height: 20,
                      child: Image.asset("images/arrow_towards_right.png")),
                ],
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        height: 15, child: Image.asset("images/crown.png")),
                    Text(
                      Constants.labelVoiceClone,
                      textAlign: TextAlign.start,
                      style:
                          Styles.boldHeading.copyWith(color: MyColors.darkBlue),
                    ),
                  ],
                ),
              ),
            ),
            (isHaveVoice)
                ? Container(
                    height: height * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: PrimaryButton(
                            title: Constants.labelDeleteVoiceClone,
                            backgroundColor: Colors.red,
                            onPressed: () {
                              deleteClonedVoice();
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          Constants.labelVoiceCloneInfo,
                          textAlign: TextAlign.start,
                          style: Styles.textStyleBold
                              .copyWith(color: Colors.grey, height: 1.5),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: GestureDetector(
                          onTapDown: (_) {
                            setState(() {
                              isRecording = true;
                              isRecorded = false;
                            });
                            final recorderFn = getRecorderFn();
                            if (recorderFn != null) {
                              recorderFn(); // Start recording
                            }
                          },
                          onTapUp: (_) {
                            setState(() {
                              isRecording = false;
                              isRecorded = true;
                            });

                            final recorderFn = getRecorderFn();
                            if (recorderFn != null) {
                              recorderFn(); // Start recording
                            }
                          },
                          child: Image.asset(
                            "images/icon_mic.png",
                            width: height * 0.15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      (!isRecording && isRecorded)
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: PrimaryButton(
                                title: Constants.labelSubmit,
                                backgroundColor: MyColors.btnColorSecondaryDark,
                                onPressed: () {
                                  if (_mPathToSend.isNotEmpty == true) {
                                    uploadFile(_mPathToSend ?? "");
                                  } else {}
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
                            )
                    ],
                  )
          ],
        ),
      ),
    );
  }

  Future<void> deleteClonedVoice() async {
    var email = await MyPrefUtils.getString(MyPrefUtils.userEmail);

    var dialog = DimLoadingDialog(context,
        blur: 3,
        dismissable: false,
        backgroundColor: const Color(0x30000000),
        animationDuration: const Duration(milliseconds: 100));
    dialog.show();
    final url = Uri.parse('https://api.play.ht/api/v2/cloned-voices/');
    final headers = {
      'AUTHORIZATION': 'b274ada64cf546cd81d2d3d1cc06b9d1',
      'X-USER-ID': 'wPl2qGTQd6MEFzz7oE3Maqc0wvd2',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'voice_id': existVoice,
    });

    try {
      final response = await http.delete(url, headers: headers, body: body);
      dialog.dismiss();
      if (response.statusCode == 200) {
        setState(() {
          isHaveVoice = false;
          MyPrefUtils.putString(MyPrefUtils.voiceTemplate, "");
          deleteUserVoiceByEmail(email, "").then((value) {
            if (value) {
              setState(() {
                isHaveVoice = false;
                isRecording=false;
                isRecorded=false;
              });
            }
          });
        });
      } else {
        dialog.dismiss();
        print(
            'Failed to delete. Status code: ${response.statusCode}, Response: ${response.body}');
      }
    } catch (e) {
      dialog.dismiss();

      print('Error: $e');
    }
  }

  Future<void> _signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    print('User signed out');
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
      dialog.dismiss();
      if (response.statusCode == 201) {
        print("File uploaded successfully");
        var responseBody = await response.stream.bytesToString();

        var jsonResponse = json.decode(responseBody);
        var id = jsonResponse['id'];
        await MyPrefUtils.putString(MyPrefUtils.voiceTemplate, id);

        updateUserVoiceByEmail(email, id).then((value) {
          if (value) {
            setState(() {
              isHaveVoice = true;
              existVoice = id;
            });
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

  Future<bool> deleteUserVoiceByEmail(String email, String newVoice) async {
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

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          style: Styles.normalText.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.green));
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
