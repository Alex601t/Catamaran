#import "CATMailRuAppearance.h"

@implementation CATMailRuAppearance

#pragma mark NSObject methods

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.title = NSLocalizedString(@"mail.ru", nil);
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.title];
        NSRange dotRange = [self.title rangeOfString:@"."];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, dotRange.location)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.98 green:0.69 blue:0.21 alpha:1.00] range:NSMakeRange(dotRange.location, self.title.length - dotRange.location)];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0f] range:NSMakeRange(0, self.title.length)];
        
        self.attributedString = attributedString;
        
        self.tintColor = [UIColor whiteColor];
        self.mainColor = [UIColor colorWithRed:0.09 green:0.55 blue:0.89 alpha:1.00];
        self.backgroundColor = [UIColor whiteColor];
        
        self.statusBarStyle = UIStatusBarStyleLightContent;
    }
    return self;
}

@end
