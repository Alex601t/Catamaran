#import "CATGitHubOAuth.h"
#import "CATGitHubAppearance.h"

@implementation CATGitHubOAuth

#pragma mark Interface methods

+ (instancetype)OAuthWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope
{
    return [[CATGitHubOAuth alloc] initWithBaseURL:@"https://github.com/" authPath:@"login/oauth/authorize" clientID:clientID clientSecret:clientSecret responseType:responseType redirectURI:redirectURI scope:scope];
}

- (instancetype)initWithBaseURL:(NSString *)baseURL authPath:(NSString *)authPath clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope
{
    self = [super initWithBaseURL:baseURL authPath:authPath clientID:clientID clientSecret:clientSecret responseType:responseType redirectURI:redirectURI scope:scope];
    if(self)
    {
        self.appearance = [CATGitHubAppearance appearance];
    }
    return self;
}

- (NSURL *)OAuthAccessTokenByCode:(NSString *)code {
    NSURL *OAuthURL = [super OAuthAccessTokenByCode:code];
    OAuthURL = [NSURL URLWithString:[OAuthURL.absoluteString stringByReplacingOccurrencesOfString:self.authPath withString:@"login/oauth/access_token"]];
    return OAuthURL;
}

@end
