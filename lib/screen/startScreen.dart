// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psola/constants.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:psola/screen/audio_manipulation%20_screen.dart';

import '../controller/start_screen_controller.dart';
import 'audio_list_screen.dart';
import 'play_sound_screen_and_plot.dart';

class StartScreen extends StatelessWidget {
  StartScreen({super.key});

  final StartScreenController startScreenController =
      Get.put(StartScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PSOLA"),
        backgroundColor: backgroundColor,
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.to(() => AudioListScreen());
            },
            child: const Text(
              'previous works',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<StartScreenController>(
              init: StartScreenController(),
              builder: (controller) => StreamBuilder<RecordingDisposition>(
                stream: controller.recorder.onProgress,
                builder: (context, snapshot) {
                  final duration = snapshot.hasData
                      ? snapshot.data!.duration
                      : Duration.zero;
                  final twoDigitMinutes =
                      twoDigits(duration.inMinutes.remainder(60));
                  final twoDigitSeconds =
                      twoDigits(duration.inSeconds.remainder(60));
                  return Text(
                    '$twoDigitMinutes:$twoDigitSeconds',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width / 4,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: buttonPadding(),
              child: GetBuilder<StartScreenController>(
                builder: (controller) => ElevatedButton(
                    onPressed: () async {
                      if (controller.recorder.isRecording) {
                        await controller.stop();
                      } else {
                        await controller.record();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(controller.recorder.isRecording
                            ? Icons.stop
                            : Icons.mic),
                        Text(controller.recorder.isRecording
                            ? 'Stop recording'
                            : 'Start recording'),
                      ],
                    )),
              ),
            ),
            Padding(
              padding: buttonPadding(),
              child: GetBuilder<StartScreenController>(
                builder: (controller) => ElevatedButton(
                  onPressed: controller.isPickingFile
                      ? null
                      : () async {
                          if (!controller.isPickingFile) {
                            await controller.pickFile();
                          } else {
                            return;
                          }
                        },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                          controller.isPickingFile ? Icons.done : Icons.folder),
                      Text(controller.isPickingFile
                          ? 'file is loaded'
                          : 'Load a file'),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: buttonPadding(),
              child: GetBuilder<StartScreenController>(
                  builder: (controller) => ElevatedButton(
                        onPressed: () => controller.reset(),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Icon(Icons.restart_alt), Text('Reset')],
                        ),
                      )),
            ),
            // Padding(
            //   padding: buttonPadding(),
            //   child: GetBuilder<StartScreenController>(
            //     builder: (controller) => ElevatedButton(
            //       onPressed: controller.check()
            //           ? () => Get.to(() => PlaySoundScreen(),
            //               transition: Transition.rightToLeft,
            //               arguments: controller.selectedAudioPath)
            //           : null,
            //       child: const Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Icon(Icons.headphones),
            //           Text('Play audio'),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: buttonPadding(),
              child: GetBuilder<StartScreenController>(
                builder: (controller) => ElevatedButton(
                  onPressed: controller.check()
                      ? () => Get.to(() => AudioManipulationScreen(),
                          transition: Transition.rightToLeft,
                          arguments: controller.selectedAudioPath)
                      : null,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.settings),
                      Text('Edit audio'),
                    ],
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: buttonPadding(),
            //   child: GetBuilder<StartScreenController>(
            //     builder: (controller) => ElevatedButton(
            //       onPressed: controller.check()
            //           ? () => Get.to(() => PlaySoundScreen(),
            //               transition: Transition.rightToLeft,
            //               arguments: controller.selectedAudioPath)
            //           : null,
            //       child: const Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text('Plot and Edit'),
            //           Icon(Icons.arrow_forward_ios_rounded),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
