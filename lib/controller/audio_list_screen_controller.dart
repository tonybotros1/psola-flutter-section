import 'dart:io';

import 'package:get/get.dart';
import 'package:psola/constants.dart';
import 'package:path/path.dart' as path;
import 'package:psola/model/audios_model.dart';

class AudioListScreenController extends GetxController {
  late String audioName;
  List<AudiosFiles> audios = [];

  Future<List<AudiosFiles>> getAudios() async {
    Directory directory = Directory(path.dirname(audioDir.toString()));
    if (await directory.exists()) {
      final files = await directory.list().toList();

      for (final file in files) {
        if (file.path.endsWith('.wav')) {
          final fileContent = File(file.path);
          final audioFile = AudiosFiles(
              fileName: path.basename(file.path), file: fileContent);
          audios.add(audioFile);
        }
      }

      print("Audios: $audios");
      return audios;
    } else {
      return [];
    }
  }
}
