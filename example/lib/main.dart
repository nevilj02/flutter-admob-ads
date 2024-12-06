import 'package:flutter/material.dart';
import 'package:ga_native_ad/enums/debug_locations.dart';
import 'package:ga_native_ad/ga_native_ad.dart';
import 'package:ga_native_ad/ga_service.dart';
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
  @override
  void initState() {
    GAService.askConsent(
      isDebug: true,
      debugGeography: DebugLocation.debugGeographyEea,
      testIds: ['8632117E8B093EC69374D08607E50253'],
      onConsentUpdate: () => GAService.init(
          videoNativeAdId: 'ca-app-pub-3940256099942544/1044960115'),
      onError: (error) {
        print('error -> $error');
        GAService.init(
            videoNativeAdId: 'ca-app-pub-3940256099942544/1044960115');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
