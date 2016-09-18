#import "CATFoursquareOAuth.h"
#import "CATFoursquareAppearance.h"

@implementation CATFoursquareOAuth

#pragma mark Interface methods

+ (instancetype)OAuthWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope
{
    return [[CATFoursquareOAuth alloc] initWithBaseURL:@"https://foursquare.com/" authPath:@"oauth2/authenticate" clientID:clientID clientSecret:clientSecret responseType:responseType redirectURI:redirectURI scope:scope];
}

- (instancetype)initWithBaseURL:(NSString *)baseURL authPath:(NSString *)authPath clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope
{
    self = [super initWithBaseURL:baseURL authPath:authPath clientID:clientID clientSecret:clientSecret responseType:responseType redirectURI:redirectURI scope:scope];
    if(self)
    {
        self.appearance = [CATFoursquareAppearance appearance];
    }
    return self;
}

@end
