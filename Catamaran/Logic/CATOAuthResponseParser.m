#import "CATOAuthResponseParser.h"

@implementation CATOAuthResponseParser

#pragma mark Interface methods

+ (NSDictionary *)parseResponseURL:(NSURL *)responseURL
{
    NSString *stringResponseURL = responseURL.absoluteString;
    NSRange separatedRange = [stringResponseURL rangeOfString:@"#"];
    if(separatedRange.location == NSNotFound)
    {
        separatedRange = [stringResponseURL rangeOfString:@"?"];
    }
    
    NSMutableDictionary *response = [NSMutableDictionary dictionary];
    if(separatedRange.location != NSNotFound)
    {
        NSString *stringResponse = [stringResponseURL substringFromIndex:separatedRange.location + separatedRange.length];
        NSArray <NSString *>*separatedResponse = [stringResponse componentsSeparatedByString:@"&"];
        for(NSString *value in separatedResponse)
        {
            if([value rangeOfString:@"="].location != NSNotFound)
            {
                NSArray *separatedValue = [value componentsSeparatedByString:@"="];
                NSAssert(separatedValue.count <= 2 && separatedValue.count != 0, @"Error while separated value %@ (Unsupported objects count)", value);
                if(separatedValue.count == 2)
                {
                    response[[separatedValue firstObject]] = [separatedValue lastObject];
                }
            }
            else
            {
                NSAssert(NO, @"Can't separated value %@ by string \"=\"", value);
            }
        }
    }
    else
    {
        NSAssert(NO, @"Can't found separated key \"#\" or \"?\" in response string %@", stringResponseURL);
    }
    return response;
}

@end
