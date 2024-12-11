import 'package:flutter/material.dart';
import 'package:ga_native_ad/ga_interstitial_ad.dart';

class InterstitialAdScreen extends StatefulWidget {
  const InterstitialAdScreen({Key? key}) : super(key: key);

  @override
  State<InterstitialAdScreen> createState() => _InterstitialAdScreenState();
}

class _InterstitialAdScreenState extends State<InterstitialAdScreen> {
  bool isInterstitialAdReady = false;

  GAInterstitialAd gaInterstitialAd = GAInterstitialAd();

  @override
  void initState() {
    super.initState();
    loadAds();
  }

  loadAds() async {
    await _loadInterstitialAd();
  }

  _loadInterstitialAd() async {
    await gaInterstitialAd.loadAd(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      onAdLoaded: (ad) {
        isInterstitialAdReady = true;
      },
      onAdFailedToLoad: (err) {
        print('Failed to load an interstitial ad: ${err.message}');
        isInterstitialAdReady = false;
        _loadInterstitialAd();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("InterstitialAD")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  isInterstitialAdReady
                      ? await gaInterstitialAd.show(
                          onAdDismissedFullScreenContent: () {
                          _loadInterstitialAd();
                        }, onAdFailedToShowFullScreenContent: (ad, error) {
                          _loadInterstitialAd();
                        })
                      : null;
                },
                child: const Text("InterstitialAd")),
          ],
        ),
      ),
    );
  }
}
