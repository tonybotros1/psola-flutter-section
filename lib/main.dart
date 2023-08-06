import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psola/screen/audio_manipulation%20_screen.dart';

// import 'screen/startScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AudioManipulationScreen(),
    );
  }
}
