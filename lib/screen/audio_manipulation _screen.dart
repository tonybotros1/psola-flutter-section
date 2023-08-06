// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:psola/constants.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:action_slider/action_slider.dart';

class AudioManipulationScreen extends StatefulWidget {
  const AudioManipulationScreen({super.key});

  @override
  State<AudioManipulationScreen> createState() =>
      _AudioManipulationScreenState();
}

class _AudioManipulationScreenState extends State<AudioManipulationScreen> {
  _AudioManipulationScreenState();
  double amplitude = 1.0;
  double timeStretch = 1.0;
  double pitshScale = 1.0;
  final double _min = 0.25;
  final double _max = 2.0;
  final double _step = 0.25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Audio Manipulation"),
        backgroundColor: backgroundColor,
      ),
      body: Container(
        padding: EdgeInsets.all(size.width / 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Change audio\'s Amplitude:',style: slidersText(context),),
            SfSlider(
              activeColor: Colors.redAccent.shade400,
              inactiveColor: Colors.green.shade50,
              value: amplitude,
              onChanged: (value) {
                setState(() {
                  amplitude = value as double;
                });
              },
              min: _min,
              max: _max,
              interval: _step,
              stepSize: _step,
              showLabels: true,
              showTicks: true,
              enableTooltip: true,
              showDividers: true,
            ),
            Text('Change audio\'s Duration:',style: slidersText(context),),
            SfSlider(
              activeColor: Colors.blueAccent.shade400,
              inactiveColor: Colors.red.shade50,
              value: timeStretch,
              onChanged: (value) {
                setState(() {
                  timeStretch = value as double;
                });
              },
              min: _min,
              max: _max,
              interval: _step,
              stepSize: _step,
              showLabels: true,
              showTicks: true,
              enableTooltip: true,
              showDividers: true,
            ),
            Text('Change audio\'s Pitch Shift:',style: slidersText(context),),
            SfSlider(
              value: pitshScale,
              onChanged: (value) {
                setState(() {
                  pitshScale = value as double;
                });
              },
              min: _min,
              max: _max,
              interval: _step,
              stepSize: _step,
              showLabels: true,
              showTicks: true,
              enableTooltip: true,
              showDividers: true,
            ),
            ActionSlider.standard(
              sliderBehavior: SliderBehavior.stretch,
              rolling: true,
              width: 300.0,
              backgroundColor: Colors.blueAccent,
              toggleColor: Colors.white,
              iconAlignment: Alignment.centerRight,
              loadingIcon: const SizedBox(
                  width: 55,
                  child: Center(
                      child: SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(
                            strokeWidth: 2.0, color: Colors.blueAccent),
                      ))),
              successIcon: const SizedBox(
                  width: 55, child: Center(child: Icon(Icons.check_rounded))),
              icon: const SizedBox(
                  width: 55, child: Center(child: Icon(Icons.refresh_rounded))),
              action: (controller) async {
                controller.loading(); //starts loading animation
                await Future.delayed(const Duration(seconds: 3));
                controller.success(); //starts success animation
                await Future.delayed(const Duration(seconds: 1));
                controller.reset(); //resets the slider
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}