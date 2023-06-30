import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

import '../controller/play_sound_screen_and_plot.dart';
import '../model/plot_model.dart';
import 'player_screen.dart';

class PlaySoundScreen extends GetView<PlayAndPlot> {
  PlaySoundScreen({super.key});

  final PlayAndPlot playAndPlot = Get.put(PlayAndPlot());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Psola'),
          backgroundColor: const Color(0xff353b48),
        ),
        body: GetBuilder<PlayAndPlot>(
          builder: (controller) => Container(
            color: const Color(0xff57606f),
            child: Column(
              children: [
                Expanded(
                    flex: 8,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
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
                                    minY: -1,
                                    maxY: 1,
                                    
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: controller.waveformData
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          return FlSpot(entry.key.toDouble(),
                                              entry.value);
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
                          )
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const PlayerScreen(),
                            transition: Transition.downToUp);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: const Color(0xff353b48),
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
                                  child:
                                      Image.asset('assets/images/player.png')),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Expanded(child: Text('Name of the file')),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
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
          ),
        ));
  }
}
