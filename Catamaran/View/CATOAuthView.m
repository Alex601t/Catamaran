#import "CATOAuthView.h"
#import "CATOAuthAppearance.h"

@interface CATOAuthView ()

@property(nonatomic, strong, readwrite) UIWebView *webView;
@property(nonatomic, strong, readwrite) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation CATOAuthView

#pragma mark Private methods

- (void)initWebView
{
    self.webView = [[UIWebView alloc] init];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.webView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_webView]|" options:(NSLayoutFormatOptions) 0 metrics:nil views:NSDictionaryOfVariableBindings(_webView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_webView]|" options:(NSLayoutFormatOptions) 0 metrics:nil views:NSDictionaryOfVariableBindings(_webView)]];
}

- (void)initActivityIndicatorView
{
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.activityIndicatorView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
}

#pragma mark UIView methods

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self initWebView];
        [self initActivityIndicatorView];
    }
    return self;
}

#pragma mark Interface methods

- (void)configureWithAppearance:(CATOAuthAppearance *)appearance navigationBar:(UINavigationBar *)navigationBar
{
    self.backgroundColor = appearance.mainColor;
    self.activityIndicatorView.activityIndicatorViewStyle = appearance.activityIndicatorStyle;
    
    if(appearance.backgroundColor)
    {
        self.webView.opaque = NO;
        self.webView.backgroundColor = appearance.backgroundColor;
    }
    
    [navigationBar setTintColor:appearance.tintColor];
    [navigationBar setBarTintColor:appearance.mainColor];
    
    if(appearance.attributedString)
    {
        [navigationBar setTranslucent:NO];
        [navigationBar setShadowImage:[UIImage new]];
        [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    }
}

@end
