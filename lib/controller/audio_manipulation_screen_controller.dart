import 'package:get/get.dart';

class AudioManipulationController extends GetxController {
  RxDouble amplitude = RxDouble(1.0);
  RxDouble timeStretch = RxDouble(1.0);
  RxDouble pitshScale = RxDouble(1.0);
  final RxDouble min = RxDouble(0.25);
  final RxDouble max = RxDouble(2.0);
  final RxDouble? step =RxDouble(0.25);
}
