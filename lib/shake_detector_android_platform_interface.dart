import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'shake_detector_android_method_channel.dart';

abstract class ShakeDetectorAndroidPlatform extends PlatformInterface {
  /// Constructs a ShakeDetectorAndroidPlatform.
  ShakeDetectorAndroidPlatform() : super(token: _token);

  static final Object _token = Object();

  static ShakeDetectorAndroidPlatform _instance =
      MethodChannelShakeDetectorAndroid();

  /// The default instance of [ShakeDetectorAndroidPlatform] to use.
  ///
  /// Defaults to [MethodChannelShakeDetectorAndroid].
  static ShakeDetectorAndroidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ShakeDetectorAndroidPlatform] when
  /// they register themselves.
  static set instance(ShakeDetectorAndroidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
