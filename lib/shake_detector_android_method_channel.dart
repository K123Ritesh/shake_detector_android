import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'shake_detector_android_platform_interface.dart';

/// An implementation of [ShakeDetectorAndroidPlatform] that uses method channels.
class MethodChannelShakeDetectorAndroid extends ShakeDetectorAndroidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('shake_detector_android');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
