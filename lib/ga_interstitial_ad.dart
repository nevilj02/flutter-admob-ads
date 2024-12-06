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

  setDisplayCallback({
    GenericAdEventCallback<Ad>? onAdShowedFullScreenContent,
    Function(Ad ad, AdError error)? onAdFailedToShowFullScreenContent,
    GenericAdEventCallback<Ad>? onAdDismissedFullScreenContent,
    GenericAdEventCallback<Ad>? onAdImpression,
    GenericAdEventCallback<Ad>? onAdClicked,
    GenericAdEventCallback<Ad>? onAdWillDismissFullScreenContent,
  }) {
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
        onAdDismissedFullScreenContent?.call(ad);
      },
      onAdImpression: onAdImpression,
      onAdClicked: onAdClicked,
      onAdWillDismissFullScreenContent: onAdWillDismissFullScreenContent,
    );
  }

  show() {
    _interstitialAd?.show();
  }
}
