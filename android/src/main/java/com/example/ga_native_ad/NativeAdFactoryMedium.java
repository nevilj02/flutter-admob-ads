package com.example.ga_native_ad;

import android.content.Context;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RatingBar;
import android.widget.TextView;

import com.google.android.gms.ads.nativead.MediaView;
import com.google.android.gms.ads.nativead.NativeAd;
import com.google.android.gms.ads.nativead.NativeAdView;

import java.util.Map;

import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;

class NativeAdFactoryMedium implements GoogleMobileAdsPlugin.NativeAdFactory {

    private final Context context;

    NativeAdFactoryMedium(Context context) {
        this.context = context;
    }

    public  NativeAdView createNativeAd(NativeAd nativeAd, Map<String, Object> customOptions) {
        NativeAdView nativeAdView = (NativeAdView) LayoutInflater.from(context)
                .inflate(R.layout.medium_template, null);

// icon
        nativeAdView.setIconView(nativeAdView.findViewById(R.id.native_ad_icon));
        if (nativeAd.getIcon() == null) {
            nativeAdView.getIconView().setVisibility(View.GONE);
        } else {
            ((ImageView)nativeAdView.getIconView()).setImageDrawable(nativeAd.getIcon().getDrawable());
        }

//  media
        MediaView mediaView = nativeAdView.findViewById(R.id.native_ad_media);
        mediaView.setMediaContent(nativeAd.getMediaContent());
        nativeAdView.setMediaView(mediaView);

//   headline
//        nativeAdView.setHeadlineView(nativeAdView.findViewById(R.id.native_ad_headline));
//        ((TextView)nativeAdView.getHeadlineView()).setText(nativeAd.getHeadline());
        TextView headlineView = nativeAdView.findViewById(R.id.native_ad_headline);
        headlineView.setText(nativeAd.getHeadline());
        nativeAdView.setHeadlineView(headlineView);

        String headlineColor = (String) customOptions.get("headlineColor");
        if (headlineColor != null) {
            try {
                headlineView.setTextColor(Color.parseColor(headlineColor));
            } catch (IllegalArgumentException e) {
                headlineView.setTextColor(Color.BLACK);
            }
        }

//  bodyView
//        nativeAdView.setBodyView(nativeAdView.findViewById(R.id.native_ad_body));
//        if(nativeAd.getBody()==null){
//            nativeAdView.getBodyView().setVisibility(View.INVISIBLE);
//        }else {
//            ((TextView)nativeAdView.getBodyView()).setText(nativeAd.getBody());
//            nativeAdView.getBodyView().setVisibility(View.VISIBLE);
//        }
        TextView bodyView = nativeAdView.findViewById(R.id.native_ad_body);
        if (nativeAd.getBody() != null) {
            bodyView.setText(nativeAd.getBody());
            nativeAdView.setBodyView(bodyView);

            String bodyColor = (String) customOptions.get("bodyColor");
            if (bodyColor != null) {
                try {
                    bodyView.setTextColor(Color.parseColor(bodyColor));
                } catch (IllegalArgumentException e) {
                    bodyView.setTextColor(Color.GRAY); // Fallback color
                }
            }
        } else {
            bodyView.setVisibility(View.INVISIBLE);
        }

// button
        nativeAdView.setCallToActionView(nativeAdView.findViewById(R.id.native_ad_button));
        if(nativeAd.getCallToAction()==null){
            nativeAdView.getCallToActionView().setVisibility(View.INVISIBLE);
        }else{
            ((Button)nativeAdView.getCallToActionView()).setText(nativeAd.getCallToAction());
        }

        nativeAdView.setNativeAd(nativeAd);

        return nativeAdView;
    }
}
