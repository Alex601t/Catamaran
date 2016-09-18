#import "CATOKAppearance.h"

@implementation CATOKAppearance

#pragma mark NSObject methods

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.title = NSLocalizedString(@"ok.ru", nil);
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.title];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, self.title.length)];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0f] range:NSMakeRange(0, self.title.length)];
        
        self.attributedString = attributedString;
        self.tintColor = [UIColor whiteColor];
        self.mainColor = [UIColor colorWithRed:0.93 green:0.50 blue:0.17 alpha:1.00];
        self.backgroundColor = [UIColor colorWithRed:0.93 green:0.50 blue:0.17 alpha:1.00];
        
        self.statusBarStyle = UIStatusBarStyleLightContent;
        self.activityIndicatorStyle = UIActivityIndicatorViewStyleWhite;
    }
    return self;
}

@end
