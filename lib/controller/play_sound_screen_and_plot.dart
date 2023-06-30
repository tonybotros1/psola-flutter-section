import 'package:get/get.dart';

import '../model/plot_model.dart';

class PlayAndPlot extends GetxController {
  RxList<double> waveformData = RxList<double>.of(
      [0.1, 0.2, 0.3, 0.2, 0.1, -0.1, -0.2, -0.3, -0.2, -0.1]);
  RxList<ChartData> chartData = RxList([]);

  @override
  void onInit() {
    generateChartData();
    super.onInit();
  }

  void generateChartData() {
    for (int i = 0; i < waveformData.length; i++) {
      chartData.add(ChartData(i.toDouble(), waveformData[i]));
    }
  }
}
