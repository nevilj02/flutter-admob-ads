#import GANativeAdPlugin.h
#if __has_include(<ga_native_ad/ga_native_ad-Swift.h>)
#import <ga_native_ad/ga_native_ad-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ga_native_ad-Swift.h"
#endif

@implementation GANativeAdPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterNativeAdPlugin registerWithRegistrar:registrar];
}
@end
