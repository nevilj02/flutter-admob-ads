import 'package:flutter_test/flutter_test.dart';
import 'package:ga_native_ad/ga_native_ad_method_channel.dart';

void main() {
  MethodChannelGANativeAd platform = MethodChannelGANativeAd();
  // const MethodChannel channel = MethodChannel('ga_native_ad');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // channel.setMockMethodCallHandler((MethodCall methodCall) async {
    //   return '42';
    // });
  });

  tearDown(() {
    // channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
