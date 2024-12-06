import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

export 'ga_interstitial_ad.dart';
export 'ga_banner_ad.dart';
export 'ga_rewarded_ad.dart';
export 'ga_open_ad.dart';

class GANativeAd {
  GANativeAd();

  late NativeAd nativeAd;
  late NativeAd mediumNativeAd;

  GANativeAd.init({required String videoNativeAdId}) {
    invokeNativeAd(videoNativeAdId: videoNativeAdId);
  }

  invokeNativeAd({required String videoNativeAdId}) async {
    const methodChannel = MethodChannel("ga_native_ad");

    Map<String, String> nativeID = {"nativeVideoID": videoNativeAdId};
    await methodChannel.invokeMethod("getNativeAds", nativeID);
  }

  loadSmallAd({
    required String adUnitId,
    AdEventCallback? onAdLoaded,
    Function(Ad ad, LoadAdError error)? onAdFailedToLoad,
    AdEventCallback? onAdImpression,
    AdEventCallback? onAdOpened,
    AdEventCallback? onAdClicked,
    AdEventCallback? onAdClosed,
    AdEventCallback? onAdWillDismissScreen,
    OnPaidEventCallback? onPaidEvent,
  }) {
    nativeAd = NativeAd(
      adUnitId: adUnitId,
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
        onAdImpression: onAdImpression,
        onAdOpened: onAdOpened,
        onAdClicked: onAdClicked,
        onAdClosed: onAdClosed,
        onAdWillDismissScreen: onAdWillDismissScreen,
        onPaidEvent: onPaidEvent,
      ),
    );

    nativeAd.load();
  }

  loadMediumAd({
    required String adUnitId,
    AdEventCallback? onAdLoaded,
    Function(Ad ad, LoadAdError error)? onAdFailedToLoad,
    AdEventCallback? onAdImpression,
    AdEventCallback? onAdOpened,
    AdEventCallback? onAdClicked,
    AdEventCallback? onAdClosed,
    AdEventCallback? onAdWillDismissScreen,
    OnPaidEventCallback? onPaidEvent,
  }) {
    mediumNativeAd = NativeAd(
      adUnitId: adUnitId,
      factoryId: 'listTileMedium',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
        onAdImpression: onAdImpression,
        onAdOpened: onAdOpened,
        onAdClicked: onAdClicked,
        onAdClosed: onAdClosed,
        onAdWillDismissScreen: onAdWillDismissScreen,
        onPaidEvent: onPaidEvent,
      ),
    );
    mediumNativeAd.load();
  }

  Widget getSmallAd() {
    try {
      return AdWidget(ad: nativeAd);
    } catch (e) {
      return Container(
        height: 60,
        alignment: Alignment.center,
        child: const Text(
          'Please load native small ad first!',
          style: TextStyle(color: Colors.red),
        ),
      );
    }
  }

  Widget getMediumAd() {
    try {
      return AdWidget(ad: mediumNativeAd);
    } catch (e) {
      return Container(
        height: 60,
        alignment: Alignment.center,
        child: const Text(
          'Please load native medium ad first!',
          style: TextStyle(color: Colors.red),
        ),
      );
    }
  }

  Widget addVideoNativeAD(BuildContext context) {
    const String viewType = '<platform-view-type>';
    final Map<String, dynamic> creationParams = <String, dynamic>{};
    return AndroidView(
      viewType: viewType,
      // layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}