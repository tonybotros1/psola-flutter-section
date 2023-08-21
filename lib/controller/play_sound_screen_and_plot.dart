
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

import '../model/plot_model.dart';

class PlayAndPlot extends GetxController {
  AudioPlayer player = AudioPlayer();
  var record = Get.arguments;
  late String recordAudio;
  // late List recordArray;
  RxBool isPlaying = RxBool(false);
  Rx<Duration> duration = Rx<Duration>(Duration.zero);
  Rx<Duration> position = Rx<Duration>(Duration.zero);
  RxList<double> waveformData = RxList<double>.of([]);

  RxList<ChartData> chartData = RxList([]);

  AudioPlayer audioPlayer = AudioPlayer();

  // late File record = Get.arguments;
  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    // convertAudioTo1DArray(record);
    setRecordParameters();
    generateChartData();
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
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    player.dispose();

    super.onClose();
  }

// to draw the chart
  void generateChartData() {
    for (int i = 0; i < waveformData.length; i++) {
      chartData.add(ChartData(i.toDouble(), waveformData[i]));
    }
  }

// for the player:
  // void playAudio(filePath) {
  //   audioPlayer.setFilePath(filePath);
  //   audioPlayer.play();
  // }

  void setRecordParameters() {
    var data = {"file": record.file, "array": record.array};
    recordAudio = data["file"].path;
    waveformData = (data["array"]);
  }

  void stopAudio() {
    audioPlayer.dispose();
  }

  Future<void> initAudio() async {
    try {
      // var data = {"file": record.file, "array": record.array};
      await player.play(recordAudio, isLocal: true);
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
