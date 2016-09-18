#import "CATInstagramAppearance.h"

@implementation CATInstagramAppearance

#pragma mark NSObject methods

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.title = NSLocalizedString(@"Instagram", nil);
        self.tintColor = [UIColor colorWithRed:0.00 green:0.29 blue:0.46 alpha:1.00];
        self.mainColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.00];
        self.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.98 alpha:1.00];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.title];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:self.tintColor range:NSMakeRange(0, self.title.length)];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0f] range:NSMakeRange(0, self.title.length)];
        
        self.attributedString = attributedString;
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    return self;
}

@end
