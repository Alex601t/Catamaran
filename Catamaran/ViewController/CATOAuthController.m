#import "CATOAuthController.h"
#import "CATOAuthView.h"
#import "CATOAuthResponseParser.h"
#import "CATOAuthManager.h"

@interface CATOAuthController ()
<
    UIWebViewDelegate
>

@property(nonatomic, strong, readwrite) CATSocialOAuth *socialOAuth;
@property(nonatomic, strong) CATOAuthView *view;

@end

@implementation CATOAuthController
@dynamic view;

#pragma mark Private methods

- (void)configureAppearance
{
    CATOAuthAppearance *appearance = self.socialOAuth.appearance;
    if(appearance)
    {
        if(appearance.attributedString)
        {
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.attributedText = appearance.attributedString;
            [titleLabel sizeToFit];
    
            [self.navigationItem setTitleView:titleLabel];
        }
        
        [self.view configureWithAppearance:appearance navigationBar:self.navigationController.navigationBar];
        [self setTitle:appearance.title];
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)onCancelBarButtonTap:(UIBarButtonItem *)barButton
{
    if(self.onCancelButtonTap)
    {
        __weak __typeof(self)wself = self;
        self.onCancelButtonTap(wself);
    }
}

#pragma mark UIWebViewDelegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL shouldStart = NO;
    if([request.URL.host isEqualToString:self.socialOAuth.redirectURI.host])
    {
        [self.socialOAuth didHandleRedirectURL:request.URL];
    }
    else if([request.URL.absoluteString rangeOfString:@"access_token="].location != NSNotFound)
    {
        [self.socialOAuth didHandleRedirectURL:request.URL];
    }
    else if([request.URL.absoluteString rangeOfString:@"error="].location != NSNotFound)
    {
        [self.socialOAuth didHandleRedirectURL:request.URL];
    }
    else
    {
        shouldStart = YES;
    }
    return shouldStart;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if(webView.request.URL.absoluteString.length == 0)
    {
        [self.view.activityIndicatorView startAnimating];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if(self.view.activityIndicatorView.isAnimating)
    {
        [self.view.activityIndicatorView stopAnimating];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if(self.view.activityIndicatorView.isAnimating)
    {
        [self.view.activityIndicatorView stopAnimating];
    }
}

#pragma mark UIViewController methods

- (void)loadView
{
    self.view = [[CATOAuthView alloc] init];
    
    [self configureAppearance];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) style:UIBarButtonItemStylePlain target:self action:@selector(onCancelBarButtonTap:)];
    
    self.view.webView.delegate = self;
    
    __weak __typeof(self)wself = self;
    self.socialOAuth.authorizeHandler = ^
    {
        [wself.view.webView loadRequest:[NSURLRequest requestWithURL:[wself.socialOAuth OAuthURL]]];
    };
    self.socialOAuth.authorizeCompletionBlock = ^(CATOAuthCredential *credential, NSString *errorString)
    {
        dispatch_async(dispatch_get_main_queue(), ^
        {
            if(wself.completionBlock)
            {
                wself.completionBlock(credential, errorString, wself);
            }
        });
    };
    [self.view.activityIndicatorView startAnimating];
    [wself.socialOAuth authorize];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.socialOAuth.appearance.statusBarStyle;
}

#pragma mark Interface methods

- (instancetype)initWithSocialOAuth:(CATSocialOAuth *)socialOAuth
{
    NSAssert(socialOAuth, @"Social OAuth can't be empty");
    
    self = [super init];
    if(self)
    {
        self.socialOAuth = socialOAuth;
    }
    return self;
}

@end

@interface UINavigationController(Appearance)

@end

@implementation UINavigationController(Appearance)

#pragma mark UIViewController methods

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.visibleViewController.preferredStatusBarStyle;
}

@end
