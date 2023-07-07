// ignore_for_file: unnecessary_import, implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:psola/constants.dart';
import 'player_screen.dart';

class PlaySoundScreen extends StatelessWidget {
  const PlaySoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Psola'),
        backgroundColor: backgroundColor,
      ),
      body: Container(
        color: containerColor,
        child: Column(
          children: [
            Expanded(
                flex: 8,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                        ),
                        child: SizedBox(
                          height: 300,
                          width: Get.width,
                        ),
                      ),
                    )
                  ],
                )),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const PlayerScreen(),
                        transition: Transition.downToUp);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color:  containerColor2,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        )),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset('assets/images/player.png')),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                         const Expanded(child: Text('Name of the file')),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.play_circle_fill_rounded,
                                color: Colors.white,
                                size: 30,
                              )),
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
