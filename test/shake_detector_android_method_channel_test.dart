import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shake_detector_android/shake_detector_android_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelShakeDetectorAndroid platform = MethodChannelShakeDetectorAndroid();
  const MethodChannel channel = MethodChannel('shake_detector_android');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
