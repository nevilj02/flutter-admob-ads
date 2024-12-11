import 'dart:ui';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class GAInterstitialRewardedAd {
  RewardedInterstitialAd? _rewardedInterstitial;

  loadAd({
    required String adUnitId,
    required GenericAdEventCallback<RewardedInterstitialAd> onAdLoaded,
    required FullScreenAdLoadErrorCallback onAdFailedToLoad,
  }) {
    RewardedInterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedInterstitial = ad;
          onAdLoaded.call(ad);
        },
        onAdFailedToLoad: (error) {
          _rewardedInterstitial?.dispose();
          _rewardedInterstitial = null;
          onAdFailedToLoad.call(error);
        },
      ),
    );
  }

  show({
    GenericAdEventCallback<Ad>? onAdShowedFullScreenContent,
    Function(Ad ad, AdError error)? onAdFailedToShowFullScreenContent,
    GenericAdEventCallback<Ad>? onAdDismissedFullScreenContent,
    GenericAdEventCallback<Ad>? onAdImpression,
    GenericAdEventCallback<Ad>? onAdClicked,
    GenericAdEventCallback<Ad>? onAdWillDismissFullScreenContent,
    required OnUserEarnedRewardCallback onUserEarnedReward,
    VoidCallback? onAdNull,
  }) {
    if (_rewardedInterstitial != null) {
      _rewardedInterstitial?.fullScreenContentCallback =
          FullScreenContentCallback(
        onAdShowedFullScreenContent: onAdShowedFullScreenContent,
        onAdFailedToShowFullScreenContent: (ad, error) {
          _rewardedInterstitial?.dispose();
          _rewardedInterstitial = null;
          onAdFailedToShowFullScreenContent?.call(ad, error);
        },
        onAdDismissedFullScreenContent: (ad) {
          _rewardedInterstitial?.dispose();
          _rewardedInterstitial = null;
          onAdDismissedFullScreenContent?.call(ad);
        },
        onAdImpression: onAdImpression,
        onAdClicked: onAdClicked,
        onAdWillDismissFullScreenContent: onAdWillDismissFullScreenContent,
      );
      _rewardedInterstitial?.show(
        onUserEarnedReward: onUserEarnedReward,
      );
    } else {
      onAdNull?.call();
    }
  }

  void dispose() {
    if (_rewardedInterstitial != null) {
      _rewardedInterstitial!.dispose();
    }
  }
}
