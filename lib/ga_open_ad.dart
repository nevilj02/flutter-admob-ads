import 'dart:ui';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class GAAppOpenAd {
  static AppOpenAd? _appOpenAd;

  static loadAd({
    required String adUnitId,
    required GenericAdEventCallback<AppOpenAd> onAdLoaded,
    required FullScreenAdLoadErrorCallback onAdFailedToLoad,
  }) {
    AppOpenAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          onAdLoaded.call(ad);
        },
        onAdFailedToLoad: (error) {
          _appOpenAd?.dispose();
          _appOpenAd = null;
          onAdFailedToLoad.call(error);
        },
      ),
    );
  }

  static show({
    GenericAdEventCallback<Ad>? onAdShowedFullScreenContent,
    Function(Ad ad, AdError error)? onAdFailedToShowFullScreenContent,
    VoidCallback? onAdDismissedFullScreenContent,
    GenericAdEventCallback<Ad>? onAdImpression,
    GenericAdEventCallback<Ad>? onAdClicked,
    GenericAdEventCallback<Ad>? onAdWillDismissFullScreenContent,
  }) {
    if (_appOpenAd != null) {
      _appOpenAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: onAdShowedFullScreenContent,
        onAdFailedToShowFullScreenContent: (ad, error) {
          _appOpenAd?.dispose();
          _appOpenAd = null;
          onAdFailedToShowFullScreenContent?.call(ad, error);
        },
        onAdDismissedFullScreenContent: (ad) {
          _appOpenAd?.dispose();
          _appOpenAd = null;
          onAdDismissedFullScreenContent?.call();
        },
        onAdImpression: onAdImpression,
        onAdClicked: onAdClicked,
        onAdWillDismissFullScreenContent: onAdWillDismissFullScreenContent,
      );
      _appOpenAd?.show();
    } else {
      onAdDismissedFullScreenContent?.call();
    }
  }
}
