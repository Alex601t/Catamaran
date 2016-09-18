#import "CATOAuthManager.h"

@implementation CATOAuthManager

#pragma mark Private methods

- (NSURLRequest *)requestWithHTTPMethod:(NSString *)HTTPMethod URL:(NSURL *)URL
{
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:URL];
    mutableRequest.HTTPMethod = HTTPMethod;
    return mutableRequest;
}

- (NSDictionary *)serializeResponseData:(NSData *)responseData URLResponse:(NSURLResponse *)URLResponse
{
    NSDictionary *response = nil;
    if(responseData.length > 1)
    {
        if([URLResponse isMemberOfClass:[NSHTTPURLResponse class]])
        {
            NSHTTPURLResponse *httURLResponse = (NSHTTPURLResponse *)URLResponse;
            NSString *responseContentType = [httURLResponse allHeaderFields][@"Content-Type"];
            if([responseContentType rangeOfString:@"application/json"].location != NSNotFound)
            {
                NSError *serializationError = nil;
                response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&serializationError];
                if(serializationError)
                {
                    #if DEBUG
                        NSLog(@"Error while try to serialize %@ data %@", serializationError.localizedDescription, [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
                    #endif
                }
            }
            else
            {
                #if DEBUG
                    NSLog(@"Unsupported response content type %@", responseContentType);
                #endif
            }
        }
    }
    return response;
}

#pragma mark Interface methods

+ (CATOAuthManager *)manager
{
    static CATOAuthManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        manager = [[CATOAuthManager alloc] init];
    });
    return manager;
}

- (void)authenticateUsingSocialOAuth:(CATSocialOAuth *)socialOAuth code:(NSString *)code completionBlock:(OAuthManagerCompletionBlock)completionBlock
{
    NSAssert(socialOAuth, @"Social OAuth can't be nil");
    NSAssert(code.length, @"Code can't be empty");
    
    __weak __typeof(self)wself = self;
    NSURLRequest *request = [self requestWithHTTPMethod:@"POST" URL:[socialOAuth OAuthAccessTokenByCode:code]];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if(!error && completionBlock)
        {
            NSDictionary *responseObject = [wself serializeResponseData:data URLResponse:response];
            completionBlock(responseObject, responseObject ? nil : NSLocalizedString(@"Error while authorize.", nil));
        }
        else if(completionBlock)
        {
            completionBlock(nil, error.localizedDescription);
        }
    }];
    [task resume];
}

- (CATOAuthCredential *)credentialByResponse:(NSDictionary *)response
{
    NSAssert(response[@"access_token"], @"Response don't have access_token %@", response);
    
    CATOAuthCredential *credential = [CATOAuthCredential credentialWithOAuthToken:response[@"access_token"] tokenType:response[@"token_type"]];
    NSString *refreshToken = response[@"refresh_token"];
    NSNumber *expiresIn = response[@"expires_in"];
    NSDate *expireDate = nil;
    
    if(expiresIn && ![expiresIn isEqual:[NSNull null]])
    {
        expireDate = [NSDate dateWithTimeIntervalSinceNow:[expiresIn doubleValue]];
        [credential setExpiration:expireDate];
    }
    if(refreshToken && ![refreshToken isEqual:[NSNull null]])
    {
        [credential setRefreshToken:refreshToken];
    }
    
    return credential;
}

@end
