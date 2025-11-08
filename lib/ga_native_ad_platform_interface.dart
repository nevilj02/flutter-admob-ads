import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ga_native_ad_method_channel.dart';

abstract class GANativeAdPlatform extends PlatformInterface {
  /// Constructs a FlutterNativeAdPlatform.
  GANativeAdPlatform() : super(token: _token);

  static final Object _token = Object();

  static GANativeAdPlatform _instance = MethodChannelGANativeAd();

  /// The default instance of [GANativeAdPlatform] to use.
  ///
  /// Defaults to [MethodChannelGANativeAd].
  static GANativeAdPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GANativeAdPlatform] when
  /// they register themselves.
  static set instance(GANativeAdPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getNativeAd() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
