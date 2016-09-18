#import "CATOAuthAppearance.h"

@implementation CATOAuthAppearance

#pragma mark NSObject methods

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.activityIndicatorStyle = UIActivityIndicatorViewStyleGray;
    }
    return self;
}

#pragma mark Interface methods

+ (instancetype)appearance
{
    return [[self alloc] init];
}

@end
