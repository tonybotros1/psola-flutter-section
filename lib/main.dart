import 'package:flutter/material.dart';

import 'screen/play_sound_screen_and_plot.dart';
import 'screen/start_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlaySoundScreen(),
    );
  }
}
