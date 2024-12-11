import 'package:flutter/material.dart';
import 'package:ga_native_ad/ga_native_ad.dart';

class NativeBannerAdScreen extends StatefulWidget {
  const NativeBannerAdScreen({Key? key}) : super(key: key);

  @override
  State<NativeBannerAdScreen> createState() => _NativeBannerAdScreenState();
}

class _NativeBannerAdScreenState extends State<NativeBannerAdScreen> {
  bool isNativeAdReady = false;

  GANativeAd gaNativeAd = GANativeAd();

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  loadAd() async {
    await gaNativeAd.loadSmallAd(
      adUnitId: "ca-app-pub-3940256099942544/2247696110",
      onAdLoaded: (ad) {
        isNativeAdReady = true;
        setState(() => "");
      },
      onAdFailedToLoad: (ad, error) {
        isNativeAdReady = false;
        ad.dispose();
        print('Ad load failed (code=${error.code} message=${error.message})');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NativeBannerAd")),
      body: Center(
        child: Column(
          children: [
            Container(
                height: 102,
                child: isNativeAdReady
                    ? gaNativeAd.getSmallAd()
                    : SizedBox.shrink())
          ],
        ),
      ),
    );
  }
}
