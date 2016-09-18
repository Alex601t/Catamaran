#import "CATGoogleAppearance.h"

@implementation CATGoogleAppearance

#pragma mark NSObject methods

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.title = NSLocalizedString(@"Google", nil);
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.title];
        
        NSArray <UIColor *>*symbolColors = @[
            [UIColor colorWithRed:0.26 green:0.52 blue:0.96 alpha:1.00],
            [UIColor colorWithRed:0.92 green:0.26 blue:0.21 alpha:1.00],
            [UIColor colorWithRed:0.98 green:0.74 blue:0.02 alpha:1.00],
            [UIColor colorWithRed:0.26 green:0.52 blue:0.96 alpha:1.00],
            [UIColor colorWithRed:0.20 green:0.66 blue:0.33 alpha:1.00],
            [UIColor colorWithRed:0.92 green:0.26 blue:0.21 alpha:1.00],
        ];
        for(NSUInteger symbolIndex = 0; symbolIndex < self.title.length; symbolIndex++)
        {
            [attributedString addAttribute:NSForegroundColorAttributeName value:symbolColors[symbolIndex] range:NSMakeRange(symbolIndex, 1)];
        }
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:21.0f] range:NSMakeRange(0, self.title.length)];
        self.attributedString = attributedString;
        
        self.tintColor = [UIColor colorWithRed:0.28 green:0.54 blue:0.95 alpha:1.00];
        self.mainColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
        self.backgroundColor = [UIColor whiteColor];
        
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    return self;
}

@end
