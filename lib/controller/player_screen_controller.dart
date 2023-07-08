import 'dart:io';

import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayerScreenContorller extends GetxController {
  AudioPlayer player = AudioPlayer();
  File record = Get.arguments;
  RxBool isPlaying = RxBool(false);
  Rx<Duration> duration = Rx<Duration>(Duration.zero);
  Rx<Duration> position = Rx<Duration>(Duration.zero);


  @override
  void onInit() {
    initAudio();
    player.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.PLAYING;
    });
    player.onDurationChanged.listen((newDuration) {
      duration.value = newDuration;
    });
    player.onAudioPositionChanged.listen((newPosition) {
      position.value = newPosition;
    });
    super.onInit();
  }

  @override
  void onClose() {
    player.dispose();

    super.onClose();
  }

  Future<void> initAudio() async {
    try {
      await player.play(record.path, isLocal: true);
    } catch (e) {
      throw 'error reading the file';
    }
  }

  Future<void> play() async {
    if (isPlaying.value) {
      await player.pause();
    } else {
      await player.resume();
    }
  }
}
