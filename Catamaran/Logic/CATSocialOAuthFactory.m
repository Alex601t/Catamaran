#import "CATSocialOAuthFactory.h"
#import "CATOAuths.h"

@interface CATSocialOAuthFactory ()

@property(nonatomic, strong) id<CATOAuthConfigurator> configurator;

@end

@implementation CATSocialOAuthFactory

#pragma mark Interface methods

- (instancetype)initWithConfigurator:(id<CATOAuthConfigurator>)configurator
{
    NSAssert(configurator, @"OAuthConfigurator can't be nil");
    self = [super init];
    if(self)
    {
        self.configurator = configurator;
    }
    return self;
}

- (CATSocialOAuth *)OAuthByType:(OSOAuthType)type
{
    NSURL *redirectURI = [self.configurator redirectURI];
    NSString *tokenResponseType = @"token";
    switch(type)
    {
        case OSOAuthTypeFacebook :
            return [CATFacebookOAuth OAuthWithClientID:[self.configurator facebookApplicationID] clientSecret:nil responseType:tokenResponseType redirectURI:redirectURI scope:[self.configurator facebookScope]];
            
        case OSOAuthTypeGoogle :
            return [CATGoogleOAuth OAuthWithClientID:[self.configurator googleApplicationID] clientSecret:nil responseType:tokenResponseType redirectURI:redirectURI scope:[self.configurator googleScope]];
        
        case OSOAuthTypeInstagram:
            return [CATInstagramOAuth OAuthWithClientID:[self.configurator instagramApplicationID] clientSecret:nil responseType:tokenResponseType redirectURI:redirectURI scope:[self.configurator instagramScope]];
            
        case OSOAuthTypeVK :
            return [CATVKOAuth OAuthWithClientID:[self.configurator vkApplicationID] clientSecret:nil responseType:tokenResponseType redirectURI:redirectURI scope:[self.configurator vkScope]];
            
        case OSOAuthTypeYandex :
            return [CATYandexOAuth OAuthWithClientID:[self.configurator yandexApplicationID] clientSecret:nil responseType:tokenResponseType redirectURI:redirectURI scope:nil];
            
        case OSOAuthTypeMailRu :
            return [CATMailRuOAuth OAuthWithClientID:[self.configurator mailRuApplicationID] clientSecret:nil responseType:tokenResponseType redirectURI:redirectURI scope:nil];
            
        case OSOAuthTypeFoursquare:
            return [CATFoursquareOAuth OAuthWithClientID:[self.configurator foursquareApplicationID] clientSecret:nil responseType:tokenResponseType redirectURI:redirectURI scope:nil];
            
        case OSOAuthTypeOK :
            return [CATOKOAuth OAuthWithClientID:[self.configurator okApplicationID] clientSecret:[self.configurator okApplicationSecret] responseType:@"code" redirectURI:redirectURI scope:[self.configurator okScope]];
            
        case OSOAuthTypeLinkedIn:
            return [CATLinkedInOAuth OAuthWithClientID:[self.configurator linkedInApplicationID] clientSecret:[self.configurator linkedInScope] responseType:@"code" redirectURI:redirectURI scope:[self.configurator linkedInScope]];
    }
}

@end
