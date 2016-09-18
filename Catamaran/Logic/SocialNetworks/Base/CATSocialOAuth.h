#import <Foundation/Foundation.h>
#import "CATOAuthAppearance.h"
#import "CATOAuthCredential.h"

typedef void (^SocialOAuthAuthorizeHandler)();
typedef void (^SocialOAuthAuthorizeCompletionBlock)(CATOAuthCredential *credential, NSString *errorString);

@interface CATSocialOAuth : NSObject

@property(nonatomic, strong, readonly) NSString *baseURL;
@property(nonatomic, strong, readonly) NSString *authPath;
@property(nonatomic, strong, readonly) NSString *clientID;
@property(nonatomic, strong, readonly) NSString *clientSecret;
@property(nonatomic, strong, readonly) NSString *responseType;
@property(nonatomic, strong, readonly) NSURL *redirectURI;

@property(nonatomic, copy) SocialOAuthAuthorizeHandler authorizeHandler;
@property(nonatomic, copy) SocialOAuthAuthorizeCompletionBlock authorizeCompletionBlock;

@property(nonatomic, strong) CATOAuthAppearance *appearance;

- (void)authorize;
- (void)didHandleRedirectURL:(NSURL *)URL;

- (NSURL *)OAuthURL;
- (NSURL *)OAuthAccessTokenByCode:(NSString *)code;

- (NSDictionary *)OAuthURLAdditionalParameters;

+ (instancetype)OAuth;
+ (instancetype)OAuthWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope;
- (instancetype)initWithBaseURL:(NSString *)baseURL authPath:(NSString *)authPath clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope;

- (instancetype)init NS_UNAVAILABLE;

@end
