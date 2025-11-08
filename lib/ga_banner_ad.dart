import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GABannerAd {
  late BannerAd bannerAd;

  loadAd({
    required String adUnitId,
    AdEventCallback? onAdLoaded,
    AdLoadErrorCallback? onAdFailedToLoad,
    AdEventCallback? onAdImpression,
    AdEventCallback? onAdOpened,
    AdEventCallback? onAdClicked,
    AdEventCallback? onAdClosed,
    AdEventCallback? onAdWillDismissScreen,
    OnPaidEventCallback? onPaidEvent,
  }) {
    bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: (ad, error) {
          bannerAd.dispose();
          onAdFailedToLoad?.call(ad, error);
        },
        onAdImpression: onAdImpression,
        onAdOpened: onAdOpened,
        onAdClicked: onAdClicked,
        onAdClosed: onAdClosed,
        onAdWillDismissScreen: onAdWillDismissScreen,
        onPaidEvent: onPaidEvent,
      ),
    );
    bannerAd.load();
  }

  Widget getAd() {
    try {
      return AdWidget(ad: bannerAd);
    } catch (e) {
      return Container(
        height: 60,
        alignment: Alignment.center,
        child: const Text(
          'Please load banner ad first!',
          style: TextStyle(color: Colors.red),
        ),
      );
    }
  }

  void dispose() {
    try {
      bannerAd.dispose();
    } catch (e) {}
  }
}
