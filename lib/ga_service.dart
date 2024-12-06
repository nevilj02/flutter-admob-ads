import 'package:ga_native_ad/ga_native_ad.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GAService {
  void init({required String videoNativeAdId}) {
    MobileAds.instance.initialize();
    GANativeAd.init(videoNativeAdId: videoNativeAdId);
  }
}
