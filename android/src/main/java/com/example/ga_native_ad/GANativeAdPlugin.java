package com.example.ga_native_ad;

import android.app.Activity;
import android.content.Context;
import android.os.CountDownTimer;
import android.util.Log;
import android.view.View;

import androidx.annotation.NonNull;

import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.AdLoader;
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.LoadAdError;
import com.google.android.gms.ads.VideoController;
import com.google.android.gms.ads.VideoOptions;
import com.google.android.gms.ads.nativead.NativeAd;
import com.google.android.gms.ads.nativead.NativeAdOptions;

import java.util.Map;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;


/** FlutterNativeAdPlugin */
public class GANativeAdPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private MethodChannel nativeChannel;
  private Context context;
  private Activity activity;
  private FlutterEngine flutterEngine;

//  private TemplateView template;
  private static final String TAG = "-->Native";
  FlutterPluginBinding pluginBinding;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "ga_native_ad");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
    flutterEngine = flutterPluginBinding.getFlutterEngine();
    pluginBinding = flutterPluginBinding;
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {


    if (call.method.equals("getNativeAds")) {

      GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTile", new NativeAdFactorySmall(context));
      GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTileMedium", new NativeAdFactoryMedium(context));
    } else {
      result.notImplemented();
    }
  }


  // Activity Aware
  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile");
    GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTileMedium");
    channel.setMethodCallHandler(null);
  }

}
