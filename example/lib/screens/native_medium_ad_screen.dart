import 'package:flutter/material.dart';
import 'package:ga_native_ad/ga_native_ad.dart';
import 'package:ga_native_ad/models/native_styles.dart';

class NativeMediumAdScreen extends StatefulWidget {
  const NativeMediumAdScreen({Key? key}) : super(key: key);

  @override
  State<NativeMediumAdScreen> createState() => _NativeMediumAdScreenState();
}

class _NativeMediumAdScreenState extends State<NativeMediumAdScreen> {
  bool isMediumNativeAdReady = false;

  GANativeAd gaNativeAd = GANativeAd();

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  loadAd() async {
    await gaNativeAd.loadMediumAd(
      adUnitId: 'ca-app-pub-3940256099942544/1044960115',
      onAdLoaded: (ad) {
        isMediumNativeAdReady = true;
        setState(() => "");
      },
      onAdFailedToLoad: (ad, error) {
        isMediumNativeAdReady = false;
        ad.dispose();
        print('Ad load failed (code=${error.code} message=${error.message})');
      },
      style: NativeStyles(
        headlineColor: "#FFFF0000",
        bodyColor: "#FF0000FF",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NativeMediumAdScreen")),
      body: Center(
        child: Column(
          children: [
            Container(
                height: 255,
                child: isMediumNativeAdReady
                    ? gaNativeAd.getMediumAd()
                    : SizedBox.shrink())
          ],
        ),
      ),
    );
  }
}
