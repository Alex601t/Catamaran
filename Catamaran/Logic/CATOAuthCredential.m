#import "CATOAuthCredential.h"

@interface CATOAuthCredential ()

@property(nonatomic, copy, readwrite) NSString *accessToken;
@property(nonatomic, copy, readwrite) NSString *tokenType;
@property(nonatomic, copy, readwrite) NSString *refreshToken;

@property(nonatomic, copy) NSDate *expiration;

@end

@implementation CATOAuthCredential

#pragma mark NSCoding methods

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    self.accessToken = [decoder decodeObjectForKey:NSStringFromSelector(@selector(accessToken))];
    self.tokenType = [decoder decodeObjectForKey:NSStringFromSelector(@selector(tokenType))];
    self.refreshToken = [decoder decodeObjectForKey:NSStringFromSelector(@selector(refreshToken))];
    self.expiration = [decoder decodeObjectForKey:NSStringFromSelector(@selector(expiration))];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.accessToken forKey:NSStringFromSelector(@selector(accessToken))];
    [encoder encodeObject:self.tokenType forKey:NSStringFromSelector(@selector(tokenType))];
    [encoder encodeObject:self.refreshToken forKey:NSStringFromSelector(@selector(refreshToken))];
    [encoder encodeObject:self.expiration forKey:NSStringFromSelector(@selector(expiration))];
}

#pragma mark Interface methods

+ (instancetype)credentialWithOAuthToken:(NSString *)token tokenType:(NSString *)type
{
    return [[self alloc] initWithOAuthToken:token tokenType:type];
}

- (instancetype)initWithOAuthToken:(NSString *)token tokenType:(NSString *)type
{
    NSAssert(token.length > 0, @"Token can't be empty");
    
    self = [super init];
    if(self)
    {
        self.accessToken = token;
        self.tokenType = type;
    }
    return self;
}

- (void)setRefreshToken:(NSString *)refreshToken
{
    _refreshToken = refreshToken;
}

- (void)setExpiration:(NSDate *)expiration
{
    _expiration = expiration;
}

- (void)setRefreshToken:(NSString *)refreshToken expiration:(NSDate *)expiration
{
    NSAssert(refreshToken.length > 0, @"Refresh token can't be empty");
    NSParameterAssert(expiration);
    
    self.refreshToken = refreshToken;
    self.expiration = expiration;
}

- (BOOL)isExpired
{
    return [self.expiration compare:[NSDate date]] == NSOrderedAscending;
}

@end
