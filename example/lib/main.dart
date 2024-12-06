import 'package:flutter/material.dart';
import 'package:ga_native_ad/ga_native_ad.dart';
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
    GANativeAd.init(videoNativeAdId: 'ca-app-pub-3940256099942544/1044960115');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
