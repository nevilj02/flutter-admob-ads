import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ga_native_ad/models/native_styles.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

export 'ga_interstitial_ad.dart';
export 'ga_banner_ad.dart';
export 'ga_rewarded_ad.dart';
export 'ga_open_ad.dart';

class GANativeAd {
  GANativeAd();

  late NativeAd _nativeAd;
  late NativeAd _mediumNativeAd;

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
    NativeStyles? style,
  }) {
    _nativeAd = NativeAd(
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
      customOptions: {
        'headlineColor': style?.headlineColor ?? "#FF000000",
        'bodyColor': style?.bodyColor ?? "#FFAAAAAA",
      },
    );

    _nativeAd.load();
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
    NativeStyles? style,
  }) {
    _mediumNativeAd = NativeAd(
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
      customOptions: {
        'headlineColor': style?.headlineColor ?? "#FF000000",
        'bodyColor': style?.bodyColor ?? "#FFAAAAAA",
      },
    );
    _mediumNativeAd.load();
  }

  Widget getSmallAd() {
    try {
      return AdWidget(ad: _nativeAd);
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
      return AdWidget(ad: _mediumNativeAd);
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

  void disposeBanner() {
    try {
      _nativeAd.dispose();
    } catch (e) {}
  }

  void disposeMedium() {
    try {
      _mediumNativeAd.dispose();
    } catch (e) {}
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
