import 'dart:ui';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class GARewardedAd {
  RewardedAd? _rewardedAd;

  loadAd({
    required String adUnitId,
    required GenericAdEventCallback<RewardedAd> onAdLoaded,
    required FullScreenAdLoadErrorCallback onAdFailedToLoad,
  }) {
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          onAdLoaded.call(ad);
        },
        onAdFailedToLoad: (error) {
          _rewardedAd?.dispose();
          _rewardedAd = null;
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
    if (_rewardedAd != null) {
      _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: onAdShowedFullScreenContent,
        onAdFailedToShowFullScreenContent: (ad, error) {
          _rewardedAd?.dispose();
          _rewardedAd = null;
          onAdFailedToShowFullScreenContent?.call(ad, error);
        },
        onAdDismissedFullScreenContent: (ad) {
          _rewardedAd?.dispose();
          _rewardedAd = null;
          onAdDismissedFullScreenContent?.call(ad);
        },
        onAdImpression: onAdImpression,
        onAdClicked: onAdClicked,
        onAdWillDismissFullScreenContent: onAdWillDismissFullScreenContent,
      );
      _rewardedAd?.show(
        onUserEarnedReward: onUserEarnedReward,
      );
    } else {
      onAdNull?.call();
    }
  }
}
