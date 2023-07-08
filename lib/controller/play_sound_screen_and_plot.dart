import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../model/plot_model.dart';

class PlayAndPlot extends GetxController {
  RxList<double> waveformData = RxList<double>.of(
      [0.1, 0.2, 0.3, 0.2, 0.1, -0.1, -0.2, -0.3, -0.2, -0.1]);
  RxList<ChartData> chartData = RxList([]);

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void onInit() {
    generateChartData();
    super.onInit();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

// to draw the chart
  void generateChartData() {
    for (int i = 0; i < waveformData.length; i++) {
      chartData.add(ChartData(i.toDouble(), waveformData[i]));
    }
  }

// for the player:
  void playAudio(filePath) {
    audioPlayer.setFilePath(filePath);
    audioPlayer.play();
  }

  void stopAudio() {
    audioPlayer.dispose();
  }
}
