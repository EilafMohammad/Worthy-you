import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerWidget({Key? key, required this.audioUrl}) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget>
    with SingleTickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  late AnimationController _controller;
  late Timer _timer;
  Duration _duration = const Duration(minutes: 1, seconds: 30);
  Duration _position = Duration.zero;
  bool isPlaying = false;
  bool isRecording=false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3));

    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });

    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        _position = const Duration(seconds: 0);
        _controller.stop();
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _playPause() {
    if (isPlaying) {
      _audioPlayer.pause();
      _controller.stop();
      _timer.cancel();
    } else {
      _audioPlayer.play(UrlSource(widget.audioUrl));
      _controller.repeat(reverse: true);
      _startTimer();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _position += const Duration(seconds: 1);
        if (_position >= _duration) {
          _timer.cancel();
          _controller.stop();
          isPlaying = false;
        }
      });
    });
  }

  void _seekForward() {
    final newPosition = _position.inSeconds + 10;
    _audioPlayer.seek(Duration(seconds: newPosition));
  }

  void _seekBackward() {
    final newPosition = _position.inSeconds - 10;
    _audioPlayer.seek(Duration(seconds: newPosition < 0 ? 0 : newPosition));
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 60.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(_formatDuration(_position)),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: CustomPaint(
                    painter: AudioWaveformPainter(
                      animation: _controller,
                      playedDuration: _position,
                      totalDuration: _duration,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(_formatDuration(_duration)),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Material(
                child: InkWell(
                  splashColor: Colors.purple[50],
                  onTap: () {
                    _seekBackward;
                  },
                  child:
                      Image.asset(height: 25, width: 25, 'images/icons/next.png'),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.replay_10),
                iconSize: 25.0,
                color: Colors.deepPurple.shade300,
                onPressed: _seekBackward,
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.deepPurple.shade300,
                child: Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    iconSize: 40.0,
                    color: Colors.white,
                    onPressed: _playPause,
                  ),
                ),
              ),

              IconButton(
                icon: const Icon(Icons.forward_10),
                iconSize: 25.0,
                color: Colors.deepPurple.shade300,
                onPressed: _seekForward,
              ),
              Material(
                child: InkWell(
                  splashColor: Colors.purple[50],
                  onTap: () {
                    _seekForward;
                  },
                  child: Image.asset(height: 25, width: 25, 'images/icons/previous.png'),
                ),
              ),
              // IconButton(
              //   icon: const Icon(Icons.skip_next_outlined),
              //   iconSize: 36.0,
              //   color: Colors.deepPurple,
              //   onPressed: _seekForward,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class AudioWaveformPainter extends CustomPainter {
  final Animation<double> animation;
  final Paint playedWavePaint;
  final Paint unplayedWavePaint;
  final Duration playedDuration;
  final Duration totalDuration;

  // This array controls the height of each bar in the waveform
  final List<double> waveHeights = [
    50,
    40,
    60,
    45,
    55,
    40,
    50,
    45,
    60,
    55,
    40,
    50,
    45,
    60,
    55,
    50,
    40,
    60,
    45,
    55,
    40,
    50,
    45,
    60,
    55,
    50,
    40,
    60,
    45,
    55,
    // Add more values as needed
  ];

  AudioWaveformPainter({
    required this.animation,
    required this.playedDuration,
    required this.totalDuration,
  })  : playedWavePaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4.0
          ..strokeCap = StrokeCap.round
          ..color = const Color(0xff8367C7),
        unplayedWavePaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4.0
          ..strokeCap = StrokeCap.round
          ..color = Colors.grey.shade300,
        super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;

    final waveHeight = height / 2;
    final numberOfWaves = waveHeights.length;
    final waveLength = width / numberOfWaves;

    final playedRatio = playedDuration.inMilliseconds / totalDuration.inMilliseconds;
    // final playedRatio = (animation.value * totalDuration.inMilliseconds) / totalDuration.inMilliseconds;

    for (int i = 0; i < numberOfWaves; i++) {
      double x = i * waveLength;
      double y = waveHeight - ((waveHeights[i])-40) / 2;

      final paint = (i / numberOfWaves) <= playedRatio
          ? playedWavePaint
          : unplayedWavePaint;

      canvas.drawLine(
        Offset(x, waveHeight + waveHeights[i] / 2),
        Offset(x, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant AudioWaveformPainter oldDelegate) {
    return true;
  }
}
