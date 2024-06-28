import 'package:flutter_test/flutter_test.dart';
import 'package:shake_detector_android/shake_detector_android.dart';
import 'package:shake_detector_android/shake_detector_android_platform_interface.dart';
import 'package:shake_detector_android/shake_detector_android_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockShakeDetectorAndroidPlatform
    with MockPlatformInterfaceMixin
    implements ShakeDetectorAndroidPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ShakeDetectorAndroidPlatform initialPlatform =
      ShakeDetectorAndroidPlatform.instance;

  test('$MethodChannelShakeDetectorAndroid is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelShakeDetectorAndroid>());
  });

  test('getPlatformVersion', () async {
    ShakeDetectorAndroid shakeDetectorAndroidPlugin = ShakeDetectorAndroid();
    MockShakeDetectorAndroidPlatform fakePlatform =
        MockShakeDetectorAndroidPlatform();
    ShakeDetectorAndroidPlatform.instance = fakePlatform;

    expect(await shakeDetectorAndroidPlugin.getPlatformVersion(), '42');
  });
}
