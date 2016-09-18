#import "CATVKOAuth.h"
#import "CATVKAppearance.h"

@implementation CATVKOAuth

#pragma mark Interface methods

+ (instancetype)OAuthWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope
{
    return [[CATVKOAuth alloc] initWithBaseURL:@"https://oauth.vk.com/" authPath:@"authorize" clientID:clientID clientSecret:clientSecret responseType:responseType redirectURI:redirectURI scope:scope];
}

- (instancetype)initWithBaseURL:(NSString *)baseURL authPath:(NSString *)authPath clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope
{
    self = [super initWithBaseURL:baseURL authPath:authPath clientID:clientID clientSecret:clientSecret responseType:responseType redirectURI:redirectURI scope:scope];
    if(self)
    {
        self.appearance = [CATVKAppearance appearance];
    }
    return self;
}

@end
