#import <Foundation/Foundation.h>
#import "CATOAuthConfigurator.h"

typedef NS_ENUM(NSUInteger, OSOAuthType)
{
    OSOAuthTypeFacebook,
    OSOAuthTypeInstagram,
    OSOAuthTypeVK,
    OSOAuthTypeOK,
    OSOAuthTypeGoogle,
    OSOAuthTypeLinkedIn,
    OSOAuthTypeFoursquare,
    OSOAuthTypeYandex,
    OSOAuthTypeMailRu,
};

@class CATSocialOAuth;
@interface CATSocialOAuthFactory : NSObject

- (CATSocialOAuth *)OAuthByType:(OSOAuthType)type;

- (instancetype)initWithConfigurator:(id <CATOAuthConfigurator>)configurator;
- (instancetype)init NS_UNAVAILABLE;

@end
