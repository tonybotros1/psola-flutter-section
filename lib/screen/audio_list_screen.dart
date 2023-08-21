//TODO:create a list of recorded audio

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psola/controller/audio_list_screen_controller.dart';
import 'package:psola/model/audios_model.dart';

import '../constants.dart';
import 'play_sound_screen_and_plot.dart';

class AudioListScreen extends StatelessWidget {
  AudioListScreen({super.key});

  final AudioListScreenController audioListScreenController =
      Get.put(AudioListScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your records'),
        backgroundColor: appBarColor,
      ),
      backgroundColor: backgroundColor,
      body: GetBuilder<AudioListScreenController>(
          init: AudioListScreenController(),
          builder: (controller) {
            return FutureBuilder<List<AudiosFiles>>(
                future: controller.getAudios(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.audios.length,
                        itemBuilder: (context, i) {
                          controller.isLoadingValues.add(false);
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: Get.width,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: GetX<AudioListScreenController>(
                                    builder: (controller) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: elevatedButtonColor),
                                    onPressed: controller.isLoadingValues[i]
                                        ? null
                                        : () async {
                                            controller.isLoadingValues[i] =
                                                true;
                                            await controller.audioArray(
                                                snapshot.data![i].fileName);
                                            controller.isLoadingValues[i] =
                                                false;
                                            Get.to(() => PlaySoundScreen(),
                                                transition:
                                                    Transition.rightToLeft,
                                                arguments: AudiosFiles(
                                                    file:
                                                        snapshot.data![i].file,
                                                    array: controller.array));
                                          },
                                    child: controller.isLoadingValues[i]
                                        ? const CircularProgressIndicator(
                                            color: Color(0xffCA5116),
                                          ) // Show loading indicator on the button
                                        : Text('${snapshot.data![i].fileName}'),
                                  );
                                }),
                              ));
                        });
                  } else {
                    return const Center(
                      child: SingleChildScrollView(),
                    );
                  }
                });
          }),
    );
  }
}
