import 'package:flutter/material.dart';
import 'package:ga_native_ad/ga_interstitial_rewarded_ad.dart';

class InterstitialRewardedAdScreen extends StatefulWidget {
  const InterstitialRewardedAdScreen({Key? key}) : super(key: key);

  @override
  State<InterstitialRewardedAdScreen> createState() =>
      _InterstitialRewardedAdScreenState();
}

class _InterstitialRewardedAdScreenState
    extends State<InterstitialRewardedAdScreen> {
  bool isInterstitialAdReady = false;
  bool isRewardedInterstitialAdReady = false;

  @override
  void initState() {
    super.initState();
    loadAds();
  }

  loadAds() async {
    await _loadRewardedInterstitialAd();
  }

  _loadRewardedInterstitialAd() async {
    await GAInterstitialRewardedAd.loadAd(
      adUnitId: 'ca-app-pub-3940256099942544/5354046379',
      onAdLoaded: (ad) {
        isRewardedInterstitialAdReady = true;
      },
      onAdFailedToLoad: (error) {
        isRewardedInterstitialAdReady = false;
        print('RewardedInterstitialAd failed to load: $error');
        _loadRewardedInterstitialAd();
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
                  isRewardedInterstitialAdReady
                      ? await GAInterstitialRewardedAd.show(
                          onAdDismissedFullScreenContent: (ad) {
                          _loadRewardedInterstitialAd();
                        }, onAdFailedToShowFullScreenContent: (ad, error) {
                          _loadRewardedInterstitialAd();
                        }, onUserEarnedReward: (ad, reward) {
                          _loadRewardedInterstitialAd();
                        })
                      : null;
                },
                child: const Text("RewardedInterstitialAd")),
          ],
        ),
      ),
    );
  }
}
