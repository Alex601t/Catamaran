#import "CATSocialOAuth.h"
#import "CATOAuthResponseParser.h"
#import "CATOAuthManager.h"

static NSString *const OAuthControllerAccessTokenKey = @"access_token";
static NSString *const OAuthControllerErrorKey = @"error";
static NSString *const OAuthControllerAccessDeniedKey = @"access_denied";
static NSString *const OAuthControllerCodeKey = @"code";

@interface CATSocialOAuth ()

@property(nonatomic, strong, readwrite) NSString *baseURL;
@property(nonatomic, strong, readwrite) NSString *authPath;
@property(nonatomic, strong, readwrite) NSString *clientID;
@property(nonatomic, strong, readwrite) NSString *clientSecret;
@property(nonatomic, strong, readwrite) NSString *responseType;
@property(nonatomic, strong, readwrite) NSURL *redirectURI;

@property(nonatomic, strong, readwrite) NSString *scope;

@end

@implementation CATSocialOAuth

#pragma mark Private methods

- (NSString *)defaultOAuthStringURL
{
    if(![[self.baseURL substringFromIndex:self.baseURL.length - 1] isEqualToString:@"/"])
    {
        NSAssert(NO, @"Set to base URL forward slash \"/\" at index %lu", (unsigned long)self.baseURL.length - 1);
    }
    
    if([[self.authPath substringToIndex:1] isEqualToString:@"/"])
    {
        NSAssert(NO, @"Remove from auth path forward slash \"/\" at index 1");
    }
    
    NSMutableString *stringURL = [NSMutableString stringWithFormat:@"%@%@?", self.baseURL, self.authPath];
    [stringURL appendFormat:@"client_id=%@", self.clientID];
    [stringURL appendFormat:@"&redirect_uri=%@", self.redirectURI];
    return stringURL;
}

- (void)processResponse:(NSDictionary *)response
{
    if(response[OAuthControllerErrorKey])
    {
        #if DEBUG
            [self humanableOAuthError:response[OAuthControllerErrorKey]];
        #endif
        
        self.authorizeCompletionBlock(nil, response[OAuthControllerErrorKey]);
    }
    else if(response[OAuthControllerAccessTokenKey])
    {
        self.authorizeCompletionBlock([[CATOAuthManager manager] credentialByResponse:response], nil);
    }
    else if(response[OAuthControllerCodeKey])
    {
        [self authorizeWithAccessCode:response[OAuthControllerCodeKey]];
    }
    else
    {
        NSAssert(NO, @"Unsupported response %@", response);
        self.authorizeCompletionBlock(nil, NSLocalizedString(@"Error while authorize", nil));
    }
}

- (void)authorizeWithAccessCode:(NSString *)accessCode
{
    NSAssert(accessCode.length > 0, @"Access Code can't be empty");
    NSAssert(self.authorizeCompletionBlock, @"Completion block can't be nil");
    
    __weak __typeof(self)wself = self;
    [[CATOAuthManager manager] authenticateUsingSocialOAuth:self code:accessCode completionBlock:^(NSDictionary *response, NSString *errorString)
    {
        if(!errorString)
        {
            [wself processResponse:response];
        }
        else
        {
            wself.authorizeCompletionBlock(nil, errorString);
        }
    }];
}

- (void)humanableOAuthError:(NSString *)OAuthError
{
    NSString *errorString = [NSString stringWithFormat:@"Error response - %@", OAuthError];
    if([OAuthError isEqualToString:@"invalid_request"])
    {
        errorString = @"The request is missing a required parameter, includes an unsupported parameter value (other than grant type), repeats a parameter, includes multiple credentials, utilizes more than one mechanism for authenticating the client, or is otherwise malformed.";
    }
    else if([OAuthError isEqualToString:@"unauthorized_client"])
    {
        errorString = @"The client is not authorized to request an authorization code using this method.";
    }
    else if([OAuthError isEqualToString:@"access_denied"])
    {
        errorString = @"The resource owner or authorization server denied the request.";
    }
    else if([OAuthError isEqualToString:@"unsupported_response_type"])
    {
        errorString = @"The authorization server does not support obtaining an access token using this method.";
    }
    else if([OAuthError isEqualToString:@"invalid_scope"])
    {
        errorString = @"The requested scope is invalid, unknown, or malformed.";
    }
    else if([OAuthError isEqualToString:@"server_error"])
    {
        errorString = @"The authorization server encountered an unexpected condition that prevented it from fulfilling the request.)";
    }
    NSAssert(NO, errorString);
}

#pragma mark Interface methods

+ (instancetype)OAuthWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope
{
    NSAssert(NO, @"Implement me");
    return [super init];
}

- (instancetype)initWithBaseURL:(NSString *)baseURL authPath:(NSString *)authPath clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope
{
    NSAssert(baseURL.length > 0, @"Base URL can't be empty");
    NSAssert(authPath.length > 0, @"Auth Path URL can't be empty");
    NSAssert(clientID.length > 0, @"Client Identifier can't be empty");
    NSAssert(responseType.length > 0, @"Response Type can't be empty");
    NSAssert(redirectURI.absoluteString.length > 0, @"Redirect URI can't be empty");
    if([responseType isEqualToString:@"code"]) NSAssert(clientSecret.length > 0, @"Client secret with response type — \"code\", can't be empty");
    
    self = [super init];
    if(self)
    {
        self.baseURL = baseURL;
        self.authPath = authPath;
        self.clientID = clientID;
        self.clientSecret = clientSecret;
        self.responseType = responseType;
        self.redirectURI = redirectURI;
        self.scope = scope;
    }
    return self;
}

- (void)authorize
{
    NSAssert(self.authorizeHandler, @"Can't be nil");
    self.authorizeHandler();
}

- (void)didHandleRedirectURL:(NSURL *)URL
{
    NSAssert(self.authorizeCompletionBlock, @"Completion block can't be nil");
    
    NSDictionary *response = [CATOAuthResponseParser parseResponseURL:URL];
    if(response)
    {
        [self processResponse:response];
    }
    else
    {
        self.authorizeCompletionBlock(nil, NSLocalizedString(@"Error while authorize", nil));
    }
}

+ (instancetype)OAuth
{
    NSAssert(NO, @"Implement me");
    return [super init];
}

- (NSDictionary *)OAuthURLAdditionalParameters
{
    return nil;
}

- (NSURL *)OAuthURL
{
    NSMutableString *stringURL = [NSMutableString stringWithString:[self defaultOAuthStringURL]];
    [stringURL appendFormat:@"&response_type=%@", self.responseType];
    
    if(self.scope.length > 0)
    {
        [stringURL appendFormat:@"&scope=%@", self.scope];
    }
    
    NSDictionary *additionalParamters = [self OAuthURLAdditionalParameters];
    if(additionalParamters.count > 0)
    {
        for(NSString *key in additionalParamters.allKeys)
        {
            id object = additionalParamters[key];
            if(object)
            {
                [stringURL appendFormat:@"&%@=%@", key, object];
            }
        }
    }
    [stringURL appendString:@"&grant_type=password"];
    
    NSURL *OAuthURL = [NSURL URLWithString:stringURL];
    NSAssert(OAuthURL, @"Can't create OAuth URL from string %@", stringURL);
    return OAuthURL;
}

- (NSURL *)OAuthAccessTokenByCode:(NSString *)code
{
    NSAssert(self.clientSecret.length > 0, @"Client secret with response type — \"code\", can't be empty");
    NSAssert(code.length > 0, @"Confirmation Code can't be empty");
    
    NSMutableString *stringURL = [NSMutableString stringWithString:[self defaultOAuthStringURL]];
    [stringURL appendFormat:@"&code=%@", code];
    [stringURL appendFormat:@"&client_secret=%@", self.clientSecret];
    
    [stringURL appendString:@"&grant_type=authorization_code"];
    
    NSURL *OAuthURL = [NSURL URLWithString:stringURL];
    NSAssert(OAuthURL, @"Can't create OAuth Access Token By Code URL from string %@", stringURL);
    return OAuthURL;
}

@end
