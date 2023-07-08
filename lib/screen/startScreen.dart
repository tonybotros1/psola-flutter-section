// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psola/constants.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:psola/screen/player_screen.dart';

import '../controller/start_screen_controller.dart';

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
                    })),
            GetBuilder<StartScreenController>(
                builder: (controller) => ElevatedButton(
                      onPressed: () async {
                        if (controller.recorder.isRecording) {
                          await controller.stop();
                        } else {
                          await controller.record();
                        }
                      },
                      child: Icon(controller.recorder.isRecording
                          ? Icons.stop
                          : Icons.mic),
                    )),
            GetBuilder<StartScreenController>(
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
                      child: Icon(controller.isPickingFile
                          ? Icons.done
                          : Icons.folder),
                    )),
            GetBuilder<StartScreenController>(
                builder: (controller) => ElevatedButton(
                      onPressed: () => controller.reset(),
                      child: const Icon(Icons.restart_alt),
                    )),
            GetBuilder<StartScreenController>(
                builder: (controller) => ElevatedButton(
                      onPressed: controller.check()
                          ? () => Get.to(() =>  PlayerScreen(),
                              transition: Transition.rightToLeft,
                              arguments: controller.selectedAudioPath)
                          : null,
                      child: const Icon(Icons.arrow_forward_ios_rounded),
                    )),
          ],
        ),
      ),
    );
  }
}
