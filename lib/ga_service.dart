import 'package:ga_native_ad/enums/debug_locations.dart';
import 'package:ga_native_ad/ga_native_ad.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GAService {
  void init({required String videoNativeAdId}) {
    MobileAds.instance.initialize();
    GANativeAd.init(videoNativeAdId: videoNativeAdId);
  }

  void askConsent({
    Function? onConsentUpdate,
    Function? onError,
    bool? isDebug,
    DebugLocation? debugGeography,
    List<String>? testIds,
  }) {
    DebugGeography geography = _getGeography(debugGeography);

    final ConsentRequestParameters params = isDebug == true
        ? ConsentRequestParameters(
            consentDebugSettings: ConsentDebugSettings(
              debugGeography: geography,
              testIdentifiers: testIds,
            ),
          )
        : ConsentRequestParameters();

    ConsentInformation.instance.requestConsentInfoUpdate(params, () async {
      ConsentForm.loadAndShowConsentFormIfRequired(
        (formError) {
          if (formError != null) {
            onError?.call(formError);
          } else {
            onConsentUpdate?.call();
          }
        },
      );
    }, (FormError error) {
      onError?.call(error);
    });
  }

  DebugGeography _getGeography(DebugLocation? location) {
    switch (location) {
      case DebugLocation.debugGeographyEea:
        return DebugGeography.debugGeographyEea;
      case DebugLocation.debugGeographyNotEea:
        return DebugGeography.debugGeographyNotEea;
      default:
        return DebugGeography.debugGeographyDisabled;
    }
  }
}
