#import "CATLinkedInOAuth.h"
#import "CATLinkedInAppearance.h"

@implementation CATLinkedInOAuth

#pragma mark Interface methods

+ (instancetype)OAuthWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope
{
    return [[CATLinkedInOAuth alloc] initWithBaseURL:@"https://www.linkedin.com/" authPath:@"uas/oauth2/authorization" clientID:clientID clientSecret:clientSecret responseType:responseType redirectURI:redirectURI scope:scope];
}

- (instancetype)initWithBaseURL:(NSString *)baseURL authPath:(NSString *)authPath clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope
{
    self = [super initWithBaseURL:baseURL authPath:authPath clientID:clientID clientSecret:clientSecret responseType:responseType redirectURI:redirectURI scope:scope];
    if(self)
    {
        self.appearance = [CATLinkedInAppearance appearance];
    }
    return self;
}

- (NSURL *)OAuthURL
{
    NSMutableString *stringOAuthURL = [super OAuthURL].absoluteString.mutableCopy;
    [stringOAuthURL appendString:@"&state=DCcGFWf45A53sdfKef555"];
    return [NSURL URLWithString:stringOAuthURL];
}

@end
