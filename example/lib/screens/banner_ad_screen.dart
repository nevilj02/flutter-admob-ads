import 'package:flutter/material.dart';
import 'package:ga_native_ad/ga_native_ad.dart';

class BannerAdScreen extends StatefulWidget {
  const BannerAdScreen({Key? key}) : super(key: key);

  @override
  State<BannerAdScreen> createState() => _BannerAdScreenState();
}

class _BannerAdScreenState extends State<BannerAdScreen> {
  final _adBanner = GABannerAd();
  var isBannerAdReady = false;
  @override
  void initState() {
    super.initState();
    loadAd();
  }

  loadAd() async {
    await _adBanner.loadAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      onAdLoaded: (_) {
        isBannerAdReady = true;
        setState(() => "");
      },
      onAdFailedToLoad: (ad, err) {
        print('Failed to load a banner ad: ${err.message}');
        isBannerAdReady = false;
        ad.dispose();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BannerAd")),
      body: Center(
        child: Column(
          children: [
            Container(
                height: 50,
                child: isBannerAdReady
                    ? _adBanner.getAd()
                    : SizedBox.shrink())
          ],
        ),
      ),
    );
  }
}