import 'package:flutter/material.dart';
import 'package:ga_native_ad/ga_interstitial_rewarded_ad.dart';

class InterstitialRewardedAdScreen extends StatefulWidget {
  const InterstitialRewardedAdScreen({Key? key}) : super(key: key);

  @override
  State<InterstitialRewardedAdScreen> createState() => _InterstitialRewardedAdScreenState();
}

class _InterstitialRewardedAdScreenState extends State<InterstitialRewardedAdScreen> {
  bool isInterstitialAdReady = false;
  bool isRewardedInterstitialAdReady = false;
  final _interstitialAd = GAInterstitialRewardedAd();

  @override
  void initState() {
    super.initState();
    loadAds();
  }

  loadAds() async {
    await _loadRewardedInterstitialAd();
  }


  _loadRewardedInterstitialAd() async {
    await _interstitialAd.loadAd(
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
                      ? await _interstitialAd.show(
                      onUserEarnedReward: (ad, reward) {
                        _loadRewardedInterstitialAd();
                      })
                      : null;

                  _interstitialAd.setDisplayCallback(
                      onAdDismissedFullScreenContent: (ad) {
                        print('$ad onAdDismissedFullScreenContent.');
                        ad.dispose();
                        _loadRewardedInterstitialAd();
                      }, onAdFailedToShowFullScreenContent: (ad, error) {
                    print('$ad onAdFailedToShowFullScreenContent: $error');
                    ad.dispose();
                    _loadRewardedInterstitialAd();
                  });
                },
                child: const Text("RewardedInterstitialAd")),
          ],
        ),
      ),
    );
  }
}