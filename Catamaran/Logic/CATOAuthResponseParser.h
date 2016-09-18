#import <Foundation/Foundation.h>

@interface CATOAuthResponseParser : NSObject

+ (NSDictionary *)parseResponseURL:(NSURL *)responseURL;

@end
