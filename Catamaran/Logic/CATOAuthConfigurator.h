#import <Foundation/Foundation.h>

@protocol CATOAuthConfigurator <NSObject>

@required
- (NSURL *)redirectURI;

@optional
- (NSString *)facebookApplicationID;
- (NSString *)facebookScope; // permissions in format — permission1,permission2..permissionN

- (NSString *)instagramApplicationID;
- (NSString *)instagramScope; // scope in format — scope1+scope2+..+scopeN

- (NSString *)okApplicationID;
- (NSString *)okApplicationSecret;
- (NSString *)okScope; // scope in format — scope1;scope2..scopeN

- (NSString *)vkApplicationID;
- (NSString *)vkScope; // scope in format — scope1,scope2..scopeN

- (NSString *)googleApplicationID;
- (NSString *)googleScope; // scope in format — scope1+scope2+..+scopeN

- (NSString *)linkedInApplicationID;
- (NSString *)linkedInApplicationSecret;
- (NSString *)linkedInScope; // scope in format — scope1+scope2..scopeN

- (NSString *)foursquareApplicationID;
- (NSString *)foursquareScope;

- (NSString *)yandexApplicationID;
- (NSString *)yandexScope;

- (NSString *)mailRuApplicationID;
- (NSString *)mailRuScope;

@end
