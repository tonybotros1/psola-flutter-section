import 'package:flutter/material.dart';
import 'package:get/get.dart';

// const backgroundColor = Color(0xff353b48);

// const backgroundColor = Color(0xff57606f);
// const appBarColor = Color(0xff353b48);
// const elevatedButtonColor = Color(0xfff0932b);
// const containerColor = Color(0xff57606f);
// const containerColor2 = Color(0xff353b48);

// const backgroundColor = Color(0xffB09B71);
// const appBarColor = Color(0xff87805E);
// const elevatedButtonColor = Color(0xffD8CCA3);
// const containerColor = Color(0xff57606f);
// const containerColor2 = Color(0xff353b48);

// const backgroundColor = Color(0xff526D82);
// const appBarColor = Color(0xff27374D);
// const elevatedButtonColor = Color(0xff9DB2BF);
// const containerColor = Color(0xff57606f);
// const containerColor2 = Color(0xff353b48);

// const backgroundColor = Color(0xffDBDBDB);
// const appBarColor = Color(0xffCF7500);
// const elevatedButtonColor = Color(0xffF0A500);
// const containerColor = Color(0xff57606f);
// const containerColor2 = Color(0xff353b48);

const backgroundColor = Color(0xffF1E3CB);
const appBarColor = Color(0xffCA5116);
const elevatedButtonColor = Color(0xffF9B384);
const containerColor = Color(0xff57606f);
const containerColor2 = Color(0xff353b48);

final size = Get.size;
// final size = MediaQuery.of(context).size;

String audioPath = 'storage/emulated/0/Psola/${DateTime.now().hashCode}.wav';
String newAudioPath = 'storage/emulated/0/Psola/';
String audioDir = '/storage/emulated/0/Psola/Psola';

String twoDigits(int n) => n.toString().padLeft(2, '0');

String BACKENDURL = 'http://192.168.1.108:5000';

TextStyle slidersText(BuildContext ctx) {
  return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: size.width / 20);
}

EdgeInsets buttonPadding() {
  return EdgeInsets.only(left: size.width / 4, right: size.width / 4);
}
