// ignore_for_file: unnecessary_import, implementation_imports, depend_on_referenced_packages

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:psola/constants.dart';
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
                            // ElevatedButton(
                            //     onPressed: () => Get.to(() => PlaySoundScreen(),
                            //         transition: Transition.rightToLeft,
                            //         arguments: controller.record),
                            //   child: const Row(
                            //     children: [
                            //       Icon(Icons.arrow_back_ios_new_rounded),
                            //       Text('play'),
                            //     ],
                            //   ),
                            // ),
                            ElevatedButton(
                              onPressed: () => Get.to(
                                  () =>  AudioManipulationScreen(),
                                  transition: Transition.rightToLeft,
                                  arguments: controller.record),
                              child: const Row(
                                children: [
                                  Text('edit'),
                                  Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Slider(
                              min: 0,
                              max: controller.duration.value.inSeconds
                                  .toDouble(),
                              value: controller.position.value.inSeconds
                                  .toDouble(),
                              onChanged: (value) async {
                                final position =
                                    Duration(seconds: value.toInt());
                                await controller.player.seek(position);
                                await controller.player.resume();
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                children: [
                                  Text(
                                      "${twoDigits(controller.position.value.inMinutes.remainder(60))}:${twoDigits(controller.position.value.inSeconds.remainder(60))}"),
                                  SizedBox(
                                    width: size.width / 1.5,
                                  ),
                                  Text(
                                      "${twoDigits(controller.duration.value.inMinutes.remainder(60))}:${twoDigits(controller.duration.value.inSeconds.remainder(60))}"),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => controller.play(),
                              icon: Icon(
                                controller.isPlaying.value
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.lightBlue,
                                size: size.width / 8,
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
