import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:psola/constants.dart';
import 'package:http_parser/http_parser.dart'; // Add this import

class AudioManipulationController extends GetxController {
  var selectedAudio = Get.arguments;
  late RxString algorithmName = RxString('');
  RxDouble amplitude = RxDouble(1.0);
  RxDouble timeStretch = RxDouble(1.0);
  RxDouble pitshScale = RxDouble(1.0);
  final RxDouble min = RxDouble(0.25);
  final RxDouble max = RxDouble(2.0);
  final RxDouble? step = RxDouble(0.25);
  RxBool lpcPressed = RxBool(false);
  RxBool dwtPressed = RxBool(false);
  RxBool wptPressed = RxBool(false);

  void selectAlgorithm(algo) {
    algorithmName.value = algo;
  }

  void selectDWT() {
    lpcPressed.value = true;
    dwtPressed.value = false;
    wptPressed.value = true;
    update();
  }

  void selectWPT() {
    lpcPressed.value = true;
    dwtPressed.value = true;
    wptPressed.value = false;
    update();
  }

  void selectLPC() {
    lpcPressed.value = false;
    dwtPressed.value = true;
    wptPressed.value = true;
    update();
  }

  void disableSelectedAlgorithm() {
    lpcPressed.value = false;
    dwtPressed.value = false;
    wptPressed.value = false;
    update();
  }

// to send the audio to python section:
  Future<http.StreamedResponse> uploadAudioFile() async {
    var uri = Uri.parse('$BACKENDURL/${algorithmName.value}');
    print("tttttttttttttttttttttttttttttttttttt: $uri");

    var request = http.MultipartRequest('POST', uri);

    // Add audio file
    request.files.add(http.MultipartFile(
      'audio',
      selectedAudio.readAsBytes().asStream(),
      selectedAudio.lengthSync(),
      filename: selectedAudio.path,
      contentType:
          MediaType('audio', 'wav'), // Adjust the content type accordingly
    ));

    // Add parameters
    request.fields['Amplitude'] = "${amplitude.value}";
    request.fields['Time_stretch'] = "${timeStretch.value}";
    request.fields['Pitch_shift'] = "${pitshScale.value}";

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    print("Response Data: $responseData");

    if (response.statusCode == 200) {
      print('File uploaded successfully');
    } else {
      print('Error uploading file');
    }
    return response;
  }
}
