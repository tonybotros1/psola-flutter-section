// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:psola/constants.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final recorder = FlutterSoundRecorder();
  String? uploadedAudioPath;
  bool isRecorderReady = false;
  bool isPickingFile = false;

  @override
  void initState() {
    initRecorder();
    reset();
    super.initState();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
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
  }

  Future record() async {
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
  }

  Future stop() async {
    if (!isRecorderReady) return;
    await recorder.stopRecorder();
  }

  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['wav']);
    if (result != null) {
      File file = File(result.files.single.path.toString());
      uploadedAudioPath = file.toString();
      isPickingFile = true;
    } else {
      // User canceled the picker
      isPickingFile = false;
    }
  }

  void reset() {
    uploadedAudioPath = null;
    isPickingFile = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            StreamBuilder<RecordingDisposition>(
                stream: recorder.onProgress,
                builder: (context, snapshot) {
                  final duration = snapshot.hasData
                      ? snapshot.data!.duration
                      : Duration.zero;
                  String twoDigits(int n) => n.toString().padLeft(2, '0');
                  final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
                  final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
                  return Text(
                    '$twoDigitMinutes:$twoDigitSeconds',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width / 4,
                    ),
                  );
                }),
            ElevatedButton(
              onPressed: () async {
                if (recorder.isRecording) {
                  await stop();
                } else {
                  await record();
                }
                setState(() {});
              },
              child: Icon(recorder.isRecording ? Icons.stop : Icons.mic),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!isPickingFile) {
                  await pickFile();
                } else {
                  return;
                }
                setState(() {});
              },
              child: Icon(isPickingFile ? Icons.done : Icons.folder),
            ),
            ElevatedButton(
              onPressed: () => reset(),
              child: const Icon(Icons.restart_alt),
            ),
          ],
        ),
      ),
    );
  }
}
