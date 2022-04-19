import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerW extends StatefulWidget {

  final String filePath;
  const AudioPlayerW({Key? key, required this.filePath}) : super(key: key);

  @override
  State<AudioPlayerW> createState() => _AudioPlayerWState();
}

class _AudioPlayerWState extends State<AudioPlayerW> {
  final player = AudioPlayer();
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return
      Row(
        children: [
          FutureBuilder<Duration?>(
            future: player.setFilePath(widget.filePath), // async work
            builder: (BuildContext context, AsyncSnapshot<Duration?> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting: return const Text('Loading....');
                default:
                    return Text('${snapshot.data?.inSeconds}s  ');
              }
            },
          ),
          ElevatedButton(
              child: isPlaying ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
              onPressed: () async {
                if(isPlaying) {
                  player.stop();
                  setState(() {
                    isPlaying = false;
                  });
                } else {
                  player.play();
                  setState(() {
                    isPlaying = true;
                  });
                }
              }
          )
        ],
      );

  }
}
