import 'package:flutter/material.dart';
import 'package:get/get.dart';

const backgroundColor = Color(0xff353b48);
const containerColor = Color(0xff57606f);
const containerColor2 = Color(0xff353b48);
final size = Get.size;
// final size = MediaQuery.of(context).size;

String audioPath = 'storage/emulated/0/Download/${DateTime.now().hashCode}.wav';

String twoDigits(int n) => n.toString().padLeft(2, '0');
