#import <UIKit/UIKit.h>

@class CATOAuthAppearance;
@interface CATOAuthView : UIView

@property(nonatomic, strong, readonly) UIWebView *webView;
@property(nonatomic, strong, readonly) UIActivityIndicatorView *activityIndicatorView;

- (void)configureWithAppearance:(CATOAuthAppearance *)appearance navigationBar:(UINavigationBar *)navigationBar;

@end
