import 'package:flutter/material.dart';
import 'package:psola/constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PSOLA"),
        backgroundColor: backgroundColor,
      ),
      backgroundColor: backgroundColor,
      body: const Column(
        children: [
          Text("data")
        ],
      ),
    );
  }
}
