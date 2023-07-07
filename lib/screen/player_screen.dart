// ignore_for_file: depend_on_referenced_packages, must_be_immutable, avoid_web_libraries_in_flutter

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:psola/constants.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  AudioPlayer player = AudioPlayer();
  File record = Get.arguments;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    initAudio();
    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });
    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    player.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future initAudio() async {
    try {
      await player.play(record.path, isLocal: true);
    } catch (e) {
      throw 'error reading the file';
    }
  }

  Future play() async {
    if (isPlaying) {
      await player.pause();
    } else {
      await player.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('audio name goes here'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await player.seek(position);
                await player.resume();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Text(
                      "${twoDigits(position.inMinutes.remainder(60))}:${twoDigits(position.inSeconds.remainder(60))}"),
                  SizedBox(
                    width: size.width / 1.5,
                  ),
                  Text(
                      "${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}"),
                ],
              ),
            ),
            IconButton(
              onPressed: () => play(),
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.lightBlue,
                size: size.width / 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
