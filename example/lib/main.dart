import 'package:flutter/material.dart';
import 'package:ga_native_ad/enums/debug_locations.dart';
import 'package:ga_native_ad/ga_native_ad.dart';
import 'package:ga_native_ad/ga_service.dart';
import 'package:ga_native_ad/utils/app_life_cycle_reactor.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GAService gaService = GAService();

  @override
  void initState() {
    gaService.askConsent(
      isDebug: true,
      debugGeography: DebugLocation.debugGeographyEea,
      testIds: ['8632117E8B093EC69374D08607E50253'],
      onConsentUpdate: () => gaService.init(
          videoNativeAdId: 'ca-app-pub-3940256099942544/1044960115'),
      onError: (error) {
        print('error -> $error');
        gaService.init(
            videoNativeAdId: 'ca-app-pub-3940256099942544/1044960115');
      },
    );

    AppLifecycleReactor(
      onAppForeground: () => GAAppOpenAd.show(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
