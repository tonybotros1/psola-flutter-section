// ignore_for_file: depend_on_referenced_packages, must_be_immutable, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:psola/constants.dart';
import 'package:get/get.dart';

import '../controller/player_screen_controller.dart';

class PlayerScreen extends GetView<PlayerScreenController> {
  PlayerScreen({super.key});

  PlayerScreenController playerScreenController =
      Get.put(PlayerScreenController());

  @override
  Widget build(BuildContext context) {
    return GetX<PlayerScreenController>(
        init: PlayerScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                backgroundColor: backgroundColor,
                title: const Text('audio name goes here'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Slider(
                      min: 0,
                      max: controller.duration.value.inSeconds.toDouble(),
                      value: controller.position.value.inSeconds.toDouble(),
                      onChanged: (value) async {
                        final position = Duration(seconds: value.toInt());
                        await controller.player.seek(position);
                        await controller.player.resume();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Text(
                              "${twoDigits(controller.position.value.inMinutes.remainder(60))}:${twoDigits(controller.position.value.inSeconds.remainder(60))}"),
                          SizedBox(
                            width: size.width / 1.5,
                          ),
                          Text(
                              "${twoDigits(controller.duration.value.inMinutes.remainder(60))}:${twoDigits(controller.duration.value.inSeconds.remainder(60))}"),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => controller.play(),
                      icon: Icon(
                        controller.isPlaying.value
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.lightBlue,
                        size: size.width / 8,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
