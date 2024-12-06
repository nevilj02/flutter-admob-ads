import 'package:flutter_test/flutter_test.dart';
import 'package:ga_native_ad/ga_native_ad_platform_interface.dart';
import 'package:ga_native_ad/ga_native_ad_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterNativeAdPlatform
    with MockPlatformInterfaceMixin
    implements GANativeAdPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> getNativeAd() {
    // TODO: implement getNativeAd
    throw UnimplementedError();
  }
}

void main() {
  final GANativeAdPlatform initialPlatform =
      GANativeAdPlatform.instance;

  test('$MethodChannelGANativeAd is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGANativeAd>());
  });

  test('getPlatformVersion', () async {
    // FlutterNativeAd flutterNativeAdPlugin = FlutterNativeAd();
    MockFlutterNativeAdPlatform fakePlatform = MockFlutterNativeAdPlatform();
    GANativeAdPlatform.instance = fakePlatform;

    // expect(await flutterNativeAdPlugin.getPlatformVersion(), '42');
  });
}
