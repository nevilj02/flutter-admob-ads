import 'package:flutter/material.dart';
import 'package:ga_native_ad/ga_rewarded_ad.dart';

class RewardedAdScreen extends StatefulWidget {
  const RewardedAdScreen({Key? key}) : super(key: key);

  @override
  State<RewardedAdScreen> createState() => _RewardedAdScreenState();
}

class _RewardedAdScreenState extends State<RewardedAdScreen> {
  final _rewardedAd = GARewardedAd();
  bool isRewardedAdReady = false;

  @override
  void initState() {
    super.initState();
    loadAds();
  }

  loadAds() async {
    await _rewardedAd.loadAd(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      onAdLoaded: (ad) {
        isRewardedAdReady = true;
      },
      onAdFailedToLoad: (error) {
        print('Failed to load a rewarded ad: ${error.message}');
        isRewardedAdReady = false;
        loadAds();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RewardedAd")),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              isRewardedAdReady
                  ? await _rewardedAd.show(onUserEarnedReward: (ad, reward) {
                      loadAds();
                    })
                  : null;

              _rewardedAd.setDisplayCallback(
                  onAdDismissedFullScreenContent: (ad) {
                print('$ad onAdDismissedFullScreenContent.');
                ad.dispose();
                loadAds();
              }, onAdFailedToShowFullScreenContent: (ad, error) {
                print('$ad onAdFailedToShowFullScreenContent: $error');
                ad.dispose();
                loadAds();
              });
            },
            child: const Text("RewardedAd")),
      ),
    );
  }
}
