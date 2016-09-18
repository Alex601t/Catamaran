#import <Foundation/Foundation.h>

@interface CATOAuthCredential : NSObject
<
    NSCoding
>

@property(nonatomic, copy, readonly) NSString *accessToken;
@property(nonatomic, copy, readonly) NSString *tokenType;
@property(nonatomic, copy, readonly) NSString *refreshToken;

@property(nonatomic, assign, getter = isExpired, readonly) BOOL expired;

+ (instancetype)credentialWithOAuthToken:(NSString *)token tokenType:(NSString *)type;
- (instancetype)initWithOAuthToken:(NSString *)token tokenType:(NSString *)type;
- (instancetype)init NS_UNAVAILABLE;

- (void)setRefreshToken:(NSString *)refreshToken;
- (void)setExpiration:(NSDate *)expiration;

- (void)setRefreshToken:(NSString *)refreshToken expiration:(NSDate *)expiration;

@end