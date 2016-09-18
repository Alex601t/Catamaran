#import <Foundation/Foundation.h>
#import "CATSocialOAuth.h"
#import "CATOAuthCredential.h"

typedef void (^OAuthManagerCompletionBlock)(NSDictionary *response, NSString *errorString);

@interface CATOAuthManager : NSObject

+ (CATOAuthManager *)manager;

- (void)authenticateUsingSocialOAuth:(CATSocialOAuth *)socialOAuth code:(NSString *)code completionBlock:(OAuthManagerCompletionBlock)completionBlock;

- (CATOAuthCredential *)credentialByResponse:(NSDictionary *)response;

@end
