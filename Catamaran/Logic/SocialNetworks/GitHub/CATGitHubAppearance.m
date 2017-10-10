#import "CATGitHubAppearance.h"

@implementation CATGitHubAppearance

#pragma mark NSObject methods

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.title = NSLocalizedString(@"GitHub", nil);
        
        self.tintColor = [UIColor colorWithRed:37.0f / 255.0f  green:42.0f / 255.0f  blue:46.0f / 255.0f  alpha:1.00];
        self.mainColor = [UIColor colorWithRed:206.0f / 255.0f green:207.0f / 255.0f blue:207.0f / 255.0f alpha:1.00];
        self.backgroundColor = [UIColor colorWithRed:37.0f / 255.0f  green:42.0f / 255.0f  blue:46.0f / 255.0f  alpha:1.00];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.title];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:self.tintColor range:NSMakeRange(0, self.title.length)];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20.0f] range:NSMakeRange(0, self.title.length)];
        
        self.attributedString = attributedString;
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    return self;
}

@end
