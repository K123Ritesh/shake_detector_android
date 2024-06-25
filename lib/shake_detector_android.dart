import 'package:flutter/services.dart';

class ShakeDetectorAndroid {
  String getPlatformVersion() {
    return '0.0.1';
  }

  static const EventChannel _eventChannel = EventChannel('shake_detector');

  static void startListening(Function(bool) onShakeDetected) {
    _eventChannel.receiveBroadcastStream().listen((event) {
      onShakeDetected(event as bool);
    });
  }
}
