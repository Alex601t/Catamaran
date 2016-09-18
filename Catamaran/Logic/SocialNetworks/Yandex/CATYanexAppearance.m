#import "CATYanexAppearance.h"

@implementation CATYanexAppearance

#pragma mark NSObject methods

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.title = NSLocalizedString(@"Яндекс", nil);
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.title];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0f] range:NSMakeRange(0, self.title.length)];
        
        self.attributedString = attributedString;
        self.tintColor = [UIColor blackColor];
        self.mainColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00];
        self.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.95 alpha:1.00];
        
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    return self;
}

@end
