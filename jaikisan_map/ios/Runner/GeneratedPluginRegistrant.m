//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<app_settings/AppSettingsPlugin.h>)
#import <app_settings/AppSettingsPlugin.h>
#else
@import app_settings;
#endif

#if __has_include(<google_maps_flutter/FLTGoogleMapsPlugin.h>)
#import <google_maps_flutter/FLTGoogleMapsPlugin.h>
#else
@import google_maps_flutter;
#endif

#if __has_include(<image_gallery_saver/ImageGallerySaverPlugin.h>)
#import <image_gallery_saver/ImageGallerySaverPlugin.h>
#else
@import image_gallery_saver;
#endif

#if __has_include(<path_provider/FLTPathProviderPlugin.h>)
#import <path_provider/FLTPathProviderPlugin.h>
#else
@import path_provider;
#endif

#if __has_include(<permission_handler/PermissionHandlerPlugin.h>)
#import <permission_handler/PermissionHandlerPlugin.h>
#else
@import permission_handler;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [AppSettingsPlugin registerWithRegistrar:[registry registrarForPlugin:@"AppSettingsPlugin"]];
  [FLTGoogleMapsPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTGoogleMapsPlugin"]];
  [ImageGallerySaverPlugin registerWithRegistrar:[registry registrarForPlugin:@"ImageGallerySaverPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
}

@end
