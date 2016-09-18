#import "CATOKOAuth.h"
#import "CATOKAppearance.h"

@implementation CATOKOAuth

#pragma mark Interface methods

+ (instancetype)OAuthWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope
{
    return [[CATOKOAuth alloc] initWithBaseURL:@"https://connect.ok.ru/" authPath:@"oauth/authorize" clientID:clientID clientSecret:clientSecret responseType:responseType redirectURI:redirectURI scope:scope];
}

- (instancetype)initWithBaseURL:(NSString *)baseURL authPath:(NSString *)authPath clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope
{
    self = [super initWithBaseURL:baseURL authPath:authPath clientID:clientID clientSecret:clientSecret responseType:responseType redirectURI:redirectURI scope:scope];
    if(self)
    {
        self.appearance = [CATOKAppearance appearance];
    }
    return self;
}

- (NSURL *)OAuthAccessTokenByCode:(NSString *)code
{
    NSMutableString *stringURL = [[NSMutableString alloc] initWithString:@"https://api.ok.ru/oauth/token.do?"];
    
    [stringURL appendFormat:@"code=%@", code];
    [stringURL appendFormat:@"&client_id=%@", self.clientID];
    [stringURL appendFormat:@"&client_secret=%@", self.clientSecret];
    [stringURL appendFormat:@"&redirect_uri=%@", self.redirectURI];
    
    [stringURL appendString:@"&grant_type=authorization_code"];
    
    NSURL *OAuthAccessTokenURL = [NSURL URLWithString:stringURL];
    NSAssert(OAuthAccessTokenURL, @"Can't create OAuth AccessToken By Code URL from string %@", stringURL);
    return OAuthAccessTokenURL;
}

- (NSDictionary *)OAuthURLAdditionalParameters
{
    return @{@"layout" : @"m"};
}

@end
