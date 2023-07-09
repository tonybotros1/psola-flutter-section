import 'dart:io';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:typed_data';

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



// to convert the audio file to array so we can plot it:
Future<List<int>> convertAudioTo1DArray(File audioFile) async {
  // Read the audio file as bytes
  Uint8List audioBytes = await audioFile.readAsBytes();

  // Convert the audio bytes to a 1D array
  List<int> audioArray = audioBytes.toList();

  return audioArray;
}

}
