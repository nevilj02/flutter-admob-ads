import 'package:google_mobile_ads/google_mobile_ads.dart';

class GAAppOpenAd {
  AppOpenAd? _appOpenAd;

  loadAd({
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

  setDisplayCallback({
    GenericAdEventCallback<Ad>? onAdShowedFullScreenContent,
    Function(Ad ad, AdError error)? onAdFailedToShowFullScreenContent,
    GenericAdEventCallback<Ad>? onAdDismissedFullScreenContent,
    GenericAdEventCallback<Ad>? onAdImpression,
    GenericAdEventCallback<Ad>? onAdClicked,
    GenericAdEventCallback<Ad>? onAdWillDismissFullScreenContent,
  }) {
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
        onAdDismissedFullScreenContent?.call(ad);
      },
      onAdImpression: onAdImpression,
      onAdClicked: onAdClicked,
      onAdWillDismissFullScreenContent: onAdWillDismissFullScreenContent,
    );
  }

  show() {
    _appOpenAd?.show();
  }
}
