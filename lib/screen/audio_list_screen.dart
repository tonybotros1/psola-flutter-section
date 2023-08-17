//TODO:create a list of recorded audio

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psola/controller/audio_list_screen_controller.dart';
import 'package:psola/model/audios_model.dart';

import '../constants.dart';
import 'player_screen.dart';

class AudioListScreen extends StatelessWidget {
  AudioListScreen({super.key});

  final AudioListScreenController audioListScreenController =
      Get.put(AudioListScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your records'),
        backgroundColor: backgroundColor,
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: GetBuilder<AudioListScreenController>(
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
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: Get.width,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Get.to(() => PlayerScreen(),
                                          transition: Transition.rightToLeft,
                                          arguments: snapshot.data![i].file);
                                    },
                                    child:
                                        Text('${snapshot.data![i].fileName}')),
                              ),
                            );
                          });
                    } else {
                      return const Center(
                        child: SingleChildScrollView(),
                      );
                    }
                  });
            }),
      ),
    );
  }
}
