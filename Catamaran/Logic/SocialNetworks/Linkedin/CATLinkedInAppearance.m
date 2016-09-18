#import "CATLinkedInAppearance.h"

@implementation CATLinkedInAppearance

#pragma mark NSObject methods

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.title = NSLocalizedString(@"Linkedin", nil);
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.title];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, self.title.length - 2)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.13 green:0.53 blue:0.73 alpha:1.00] range:NSMakeRange(self.title.length - 2, 2)];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0f] range:NSMakeRange(0, self.title.length - 2)];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:26.0f] range:NSMakeRange(self.title.length - 2, 2)];
        
        self.attributedString = attributedString;
        self.tintColor = [UIColor blackColor];
        self.mainColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00];
        
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    return self;
}

@end
