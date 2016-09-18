#import "CATFacebookOAuth.h"
#import "CATFacebookAppearance.h"

@implementation CATFacebookOAuth

#pragma mark Interface methods

+ (instancetype)OAuthWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope
{
    return [[CATFacebookOAuth alloc] initWithBaseURL:@"https://www.facebook.com/" authPath:@"dialog/oauth" clientID:clientID clientSecret:clientSecret responseType:responseType redirectURI:redirectURI scope:scope];
}

- (instancetype)initWithBaseURL:(NSString *)baseURL authPath:(NSString *)authPath clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope
{
    self = [super initWithBaseURL:baseURL authPath:authPath clientID:clientID clientSecret:clientSecret responseType:responseType redirectURI:redirectURI scope:scope];
    if(self)
    {
        self.appearance = [CATFacebookAppearance appearance];
    }
    return self;
}

- (NSDictionary *)OAuthURLAdditionalParameters
{
    return @{@"display" : @"popup"};
}

@end
