// ignore_for_file: unnecessary_import, implementation_imports

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../controller/play_sound_screen_and_plot.dart';
import 'player_screen.dart';

class PlaySoundScreen extends StatelessWidget {
  PlaySoundScreen({super.key});

  final PlayAndPlot playAndPlot = Get.put(PlayAndPlot());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Psola'),
          backgroundColor: const Color(0xff353b48),
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
                  color: const Color(0xff57606f),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8, 20, 8, 20),
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
                                                  entry.key.toDouble(),
                                                  entry.value);
                                            }).toList(),
                                            isCurved: false,
                                            color: Colors.blue,
                                            barWidth: 2,
                                            dotData: FlDotData(show: false),
                                            belowBarData:
                                                BarAreaData(show: false),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => PlayerScreen(),
                                  transition: Transition.rightToLeft,
                                  arguments: controller.record);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xff353b48),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  )),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Image.asset(
                                            'assets/images/player.png')),
                                  ),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  const Expanded(
                                      child: Text('Name of the file')),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.play_circle_fill_rounded,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                );
              }
            }));
  }
}
