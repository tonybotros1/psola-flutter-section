// ignore_for_file: unnecessary_import, implementation_imports, depend_on_referenced_packages

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:psola/constants.dart';
import 'package:psola/screen/player_screen.dart';
import '../controller/play_sound_screen_and_plot.dart';
import 'audio_manipulation _screen.dart';

class PlaySoundScreen extends StatelessWidget {
  PlaySoundScreen({super.key});

  final PlayAndPlot playAndPlot = Get.put(PlayAndPlot());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Psola'),
        backgroundColor: backgroundColor,
      ),
      body: GetX<PlayAndPlot>(
        init: PlayAndPlot(),
        builder: (controller) {
          if (controller.isLoading.isTrue) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              color: containerColor,
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 0.01,
                              size.width / 20,
                              size.width * 0.01,
                              size.width / 20),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                            ),
                            child: SizedBox(
                              height: 300,
                              width: Get.width,
                              child: LineChart(
                                LineChartData(
                                  minX: 0,
                                  maxX: controller.waveformData.length
                                          .toDouble() -
                                      1,
                                  minY: -2,
                                  maxY: 2,
                                  // titlesData: FlTitlesData(
                                  //   bottomTitles:
                                  //       SideTitles(showTitles: false),
                                  //   leftTitles:
                                  //       SideTitles(showTitles: false),
                                  // ),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: controller.waveformData
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        return FlSpot(
                                            entry.key.toDouble(), entry.value);
                                      }).toList(),
                                      isCurved: false,
                                      color: Colors.blue,
                                      barWidth: 2,
                                      dotData: FlDotData(show: false),
                                      belowBarData: BarAreaData(show: false),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () => Get.to(() => PlayerScreen(),
                                    transition: Transition.rightToLeft,
                                    arguments: controller.record),
                              child: const Row(
                                children: [
                                  Icon(Icons.arrow_back_ios_new_rounded),
                                  Text('play'),
                                ],
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () => Get.to(() => const AudioManipulationScreen(),
                                    transition: Transition.rightToLeft),
                              child: const Row(
                                children: [
                                  Text('edit'),
                                  Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
