import 'package:flutter/material.dart';
import 'package:ga_native_ad/ga_open_ad.dart';

class AppOpenAdScreen extends StatefulWidget {
  const AppOpenAdScreen({Key? key}) : super(key: key);

  @override
  State<AppOpenAdScreen> createState() => _AppOpenAdScreenState();
}

class _AppOpenAdScreenState extends State<AppOpenAdScreen> {
  bool isAppOpenAdAdReady = false;
  final _adOpenAd = GAAppOpenAd();

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  loadAd() async {
    await _adOpenAd.loadAd(
      adUnitId: 'ca-app-pub-3940256099942544/9257395921',
      onAdLoaded: (ad) {
        print('$ad loaded');
        isAppOpenAdAdReady = true;
      },
      onAdFailedToLoad: (error) {
        isAppOpenAdAdReady = false;
        print('AppOpenAd failed to load: $error');
        loadAd();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AdOpenAd")),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              isAppOpenAdAdReady
                  ? await _adOpenAd.show(
                      onAdFailedToShowFullScreenContent: (ad, error) {
                      loadAd();
                    }, onAdDismissedFullScreenContent: () {
                      loadAd();
                    })
                  : null;
              loadAd();
            },
            child: const Text("AdOpenAd")),
      ),
    );
  }
}
