// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

class StartScreenController extends GetxController {
  final recorder = FlutterSoundRecorder();
  File? selectedAudioPath;
  String? recordedAudioPath;
  bool isRecorderReady = false;
  bool isPickingFile = false;

  @override
  void onInit() {
    initRecorder();
    reset();

    super.onInit();
  }

  @override
  void onClose() {
    recorder.closeRecorder();
    super.onClose();
  }

  Future<void> initRecorder() async {
    recordedAudioPath = '';
    selectedAudioPath = (null);
    isRecorderReady = false;
    isPickingFile = false;

    audioPath;
    final state = await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    if (state != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
    update();
  }

  Future<void> record() async {
    if (!isRecorderReady) return;
    Directory directory = Directory(path.dirname(audioPath.toString()));
    if (!directory.existsSync()) {
      directory.createSync();
    }
    await recorder.startRecorder(
      toFile: audioPath.toString(),
      codec: Codec.pcm16WAV,
      numChannels: 1,
    );
    update();
  }

  Future<void> stop() async {
    if (!isRecorderReady) return;
    await recorder.stopRecorder();
    update();
  }

  bool check() {
    return selectedAudioPath != null;
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['wav', 'mp3']);
    if (result != null) {
      File file = File(result.files.single.path.toString());
      selectedAudioPath = file;
      isPickingFile = true;
    } else {
      // User canceled the picker
      isPickingFile = false;
    }
    update();
  }

  void reset() {
    selectedAudioPath = null;
    isPickingFile = false;
    update();
  }

// to send the audio to python section:
  Future<http.StreamedResponse> uploadAudioFile() async {
    var uri = Uri.parse('http://your-flask-server-url/upload');

    var request = http.MultipartRequest('POST', uri);

    // Add audio file
    var file = await http.MultipartFile.fromPath(
        'audio', selectedAudioPath!.path,
        // contentType: MediaType('audio', 'wav')
        );
    request.files.add(file);

    // Add parameters
    request.fields['param1'] = 'value1';
    request.fields['param2'] = 'value2';

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    print(responseData);

    if (response.statusCode == 200) {
      print('File uploaded successfully');
    } else {
      print('Error uploading file');
    }
    return response;
  }
}
