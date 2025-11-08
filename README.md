# ga_native_ad

[![Pub Version](https://img.shields.io/pub/v/ga_native_ad.svg)](https://pub.dev/packages/ga_native_ad)

The `ga_native_ad` package is a powerful and easy-to-use Flutter plugin for integrating a variety of ad formats into your Flutter applications. This plugin supports banner ads, interstitial ads, rewarded ads, app open ads, native medium ads, native banner ads, and video native ads. It's designed to provide seamless ad experiences while maximizing your app's revenue.

## Features

- **Banner Ad**:  Display standard banner ads within your app.
- **Interstitial Ad**:  Show full-screen ads at natural transition points in your app.
- **Rewarded Ad**:  Reward users for watching video ads or interacting with ads.
- **App Open Ad**:  Display ads when users open your app.
- **Native Medium Ad**:  Show ads that blend seamlessly with your app’s content.
- **Native Banner Ad**:  Display smaller, content-rich banner ads.
- **Video Native Ad**:  Integrate video ads that match the look and feel of your app.

## Installation

Add `ga_native_ad` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  ga_native_ad: ^latest_version
```

- Install it - You can install packages from the command line:

```sh
flutter pub get
```

## Android Specific Setup
### Update your AndroidManifest.xml

Add your AdMob App ID to your app's AndroidManifest.xml file by adding the `<meta-data>` tag shown below. You can find your App ID in the AdMob UI. For android:value insert your own AdMob App ID in quotes, as shown below.

You can use these test App ID's from Admob for development:
```
Android: ca-app-pub-3940256099942544~3347511713 
```

```xml
<manifest>
  <application>
    <meta-data
      android:name="com.google.android.gms.ads.APPLICATION_ID"
      android:value="ca-app-pub-3940256099942544~3347511713"/>
  </application>
</manifest>
```

### Initialize the plugin

First thing to do before attempting to show any ads is to initialize the plugin. You can do this in the earliest starting point of your app, your `main` function:

```dart

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  GAService.askConsent(
    isDebug: true,
    debugGeography: DebugLocation.debugGeographyEea,
    testIds: ['8632117E8B093EC69374D08607E50253'],
    onConsentUpdate: () => GAService.init(
        videoNativeAdId: 'ca-app-pub-3940256099942544/1044960115'),
    onError: (error) {
      print('error -> $error');
      GAService.init(
          videoNativeAdId: 'ca-app-pub-3940256099942544/1044960115');
    },
  );
}
```