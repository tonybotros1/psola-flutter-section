import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:typed_data';

import '../model/plot_model.dart';

class PlayAndPlot extends GetxController {
  // RxList<double> waveformData = RxList<double>.of(
  //     [0.1, 0.2, 0.3, 0.2, 0.1, -0.1, -0.2, -0.3, -0.2, -0.1]);
  RxList<double> waveformData = RxList<double>.of([]);
  RxList<ChartData> chartData = RxList([]);

  AudioPlayer audioPlayer = AudioPlayer();

  late File record = Get.arguments;
  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    convertAudioTo1DArray(record);
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

  // Future<List<int>> convertAudioTo1DArray(File audioFile) async {
  //   // Read the audio file as bytes
  //   Uint8List audioBytes = await audioFile.readAsBytes();

  //   // Convert the audio bytes to a 1D array
  //   List<int> audioArray = audioBytes.toList();
  //   print(audioArray);
  //   return audioArray;
  // }

  // to convert the audio file to array so we can plot it:
  Future<List<double>> convertAudioTo1DArray(File audioFile) async {
    try {
      // Read the audio file as bytes
      Uint8List audioBytes = await audioFile.readAsBytes();

      // Convert the audio bytes to a 1D array of doubles
      List<double> audioArray =
          audioBytes.map((byte) => byte.toDouble() / 255).toList();

      for (var value in audioArray) {
        waveformData.add(value);
      }
      print(waveformData);
      isLoading.value = false;
      return audioArray;
    } catch (e) {
      throw Text('$e');
    }
  }
}
