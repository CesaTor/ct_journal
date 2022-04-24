import 'package:ct_journal/utils.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class CTAudioPlayer extends  StatefulWidget {
  final String filePath;  // File to play
  const CTAudioPlayer({Key? key, required this.filePath}) : super(key: key);
  @override
  State<CTAudioPlayer> createState() => _CTAudioPlayerState();
}

class _CTAudioPlayerState extends State<CTAudioPlayer> {

  int _maxDuration = 100;
  int _currentPos = 0;
  String _currentPostLabel = "00:00";
  bool _isPlaying = false;
  bool _audioPlayed = false;

  late AudioPlayer player;


  void _initPlayer() async {
    Duration? d = await player.setFilePath(widget.filePath);
    setState(() {
      _maxDuration = d!.inMilliseconds;
    });

    player.positionStream.listen((Duration  d){
      setState(() {
        _currentPos = d.inMilliseconds;  // get the currPos of playing audio
        _currentPostLabel = d2l(d);      // set the elapsed time label text
      });
    });
  }

  @override
  void initState() {
    // instantiate just_audio player
    player = AudioPlayer();
    _initPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top:50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_currentPostLabel, style: const TextStyle(fontSize: 25),),
            _buildSlider(),
            Wrap(
              spacing: 10,
              children: [
                _buildPlayPauseButton(),
                _buildStopButton()
              ],
            )
          ],
        )
    );
  }

  // Audio Slider
  Slider _buildSlider() {
    return Slider(
      min: 0,
      max: _maxDuration.toDouble(),
      value: _maxDuration > _currentPos
          ? _currentPos.toDouble()
          : _maxDuration.toDouble(),
      onChanged: (double value) {
        player.seek(Duration(milliseconds: value ~/ 1000.0));
        if(value == _maxDuration) {
          player.stop();
          setState(() {
            _isPlaying = false;
          });
        }
      },
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    );
  }

  // Play/Pause button
  ElevatedButton _buildPlayPauseButton() {
    return ElevatedButton.icon(
        onPressed: () async {
          if (!_isPlaying && !_audioPlayed) {
            _isPlaying = true;
            await player.play();
          } else if (_audioPlayed && !_isPlaying) {
            _isPlaying = true;
            await player.play();
          } else {
            await player.pause();
            _isPlaying = false;
          }
          setState(() {});
        },
        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
        label: Text(_isPlaying ? "Pause" : "Play")
    );
  }

  // Stop button
  ElevatedButton _buildStopButton() {
    return ElevatedButton.icon(
        onPressed: () async {
          await player.stop();
          setState(() {
            _isPlaying = false;
          });
        },
        icon: const Icon(Icons.stop),
        label: const Text("Stop")
    );
  }
}