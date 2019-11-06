#import "SocialSharingPlugin.h"
#import <social_sharing/social_sharing-Swift.h>

@implementation SocialSharingPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSocialSharingPlugin registerWithRegistrar:registrar];
}
@end
