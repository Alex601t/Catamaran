#import "CATFoursquareAppearance.h"

@implementation CATFoursquareAppearance

#pragma mark NSObject methods

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.title = NSLocalizedString(@"FOURSQUARE", nil);
        
        self.tintColor = [UIColor colorWithRed:0.03 green:0.20 blue:0.64 alpha:1.00];
        self.mainColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
        self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.title];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:self.tintColor range:NSMakeRange(0, self.title.length)];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20.0f] range:NSMakeRange(0, self.title.length)];
        
        self.attributedString = attributedString;
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    return self;
}

@end
