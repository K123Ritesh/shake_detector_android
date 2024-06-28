import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shake_detector_android/shake_detector_android.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    ShakeDetectorAndroid.startListening((e) {
      //Do Something Here
      // print("TYPE OF SHAKE :- $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Shake Detector example app'),
        ),
        body: const Center(
          child: Text('Shake Detector'),
        ),
      ),
    );
  }
}
