#import "CATYandexOAuth.h"
#import "CATYanexAppearance.h"

@implementation CATYandexOAuth

#pragma mark Interface methods

+ (instancetype)OAuthWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope
{
    return [[CATYandexOAuth alloc] initWithBaseURL:@"https://oauth.yandex.ru/" authPath:@"authorize" clientID:clientID clientSecret:clientSecret responseType:responseType redirectURI:redirectURI scope:scope];
}

- (instancetype)initWithBaseURL:(NSString *)baseURL authPath:(NSString *)authPath clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope
{
    self = [super initWithBaseURL:baseURL authPath:authPath clientID:clientID clientSecret:clientSecret responseType:responseType redirectURI:redirectURI scope:scope];
    if(self)
    {
        self.appearance = [CATYanexAppearance appearance];
    }
    return self;
}

+ (instancetype)OAuth
{
    return [[CATYandexOAuth alloc] initWithBaseURL:@"https://oauth.yandex.ru/" authPath:@"authorize" clientID:@"CLIEND_ID" clientSecret:@"CLIENT_SECRET" responseType:@"token" redirectURI:[NSURL URLWithString:@"http://localhost"] scope:@"SCOPE"];
}

- (NSDictionary *)OAuthURLAdditionalParameters
{
    return @{@"display" : @"popup"};
}

@end
