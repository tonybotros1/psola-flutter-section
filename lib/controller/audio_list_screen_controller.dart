import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:psola/constants.dart';
import 'package:path/path.dart' as path;
import 'package:psola/model/audios_model.dart';
import 'package:http/http.dart' as http;

class AudioListScreenController extends GetxController {
  late String audioName;
  List<AudiosFiles> audios = [];
  late String fileName;
  RxList isLoadingValues = RxList([]);
  RxList<double> array = RxList([]);

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

      return audios;
    } else {
      return [];
    }
  }

  Future audioArray(name) async {
    var uri = Uri.parse('$BACKENDURL/array/$name');
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      var responseArray = List<dynamic>.from(responseBody['array']);
      // array.addAll(responseBody['array']);
      array.addAll(responseArray.map((element) => element.toDouble()));
      print("array aaaaaaaaaaaaaa: ${array}");
    } else {
      update();
      print('Error with status code');
    }
  }
}
