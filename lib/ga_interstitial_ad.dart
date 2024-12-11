import 'dart:ui';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class GAInterstitialAd {
  InterstitialAd? _interstitialAd;

  loadAd({
    required String adUnitId,
    required GenericAdEventCallback<InterstitialAd> onAdLoaded,
    required FullScreenAdLoadErrorCallback onAdFailedToLoad,
  }) {
    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          onAdLoaded.call(ad);
        },
        onAdFailedToLoad: (error) {
          _interstitialAd?.dispose();
          _interstitialAd = null;
          onAdFailedToLoad.call(error);
        },
      ),
    );
  }

  show({
    GenericAdEventCallback<Ad>? onAdShowedFullScreenContent,
    Function(Ad ad, AdError error)? onAdFailedToShowFullScreenContent,
    VoidCallback? onAdDismissedFullScreenContent,
    GenericAdEventCallback<Ad>? onAdImpression,
    GenericAdEventCallback<Ad>? onAdClicked,
    GenericAdEventCallback<Ad>? onAdWillDismissFullScreenContent,
  }) {
    if (_interstitialAd != null) {
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: onAdShowedFullScreenContent,
        onAdFailedToShowFullScreenContent: (ad, error) {
          _interstitialAd?.dispose();
          _interstitialAd = null;
          onAdFailedToShowFullScreenContent?.call(ad, error);
        },
        onAdDismissedFullScreenContent: (ad) {
          _interstitialAd?.dispose();
          _interstitialAd = null;
          onAdDismissedFullScreenContent?.call();
        },
        onAdImpression: onAdImpression,
        onAdClicked: onAdClicked,
        onAdWillDismissFullScreenContent: onAdWillDismissFullScreenContent,
      );
      _interstitialAd?.show();
    } else {
      onAdDismissedFullScreenContent?.call();
    }
  }

  void dispose() {
    if (_interstitialAd != null) {
      _interstitialAd!.dispose();
    }
  }
}
