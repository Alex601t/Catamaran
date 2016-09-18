![demo][platform]

<p align="center">
    <img src="Assets/Catamaran-icon.png?raw=true" alt="Catamaran"/>
</p>

# Catamaran

An easy way to get Social Newtworks authenticating by <b>OAuth 2.0</b> on Objective-C via `UIWebView`

## Supported Social Newtworks

![Image](Assets/google-logo.png "Image")
![Image](Assets/facebook-logo.png "Image")
![Image](Assets/foursquare-logo.png "Image")
![Image](Assets/linkedIn-logo.png "Image")
![Image](Assets/instagram-logo.png "Image")
![Image](Assets/mail-ru-logo.png "Image")
![Image](Assets/ok-logo.png "Image")
![Image](Assets/yandex-logo.png "Image")
![Image](Assets/vk-logo.png "Image")

# How to use Catamaran ?

## Via Supported Social Newtworks

#### Step 1

Create `NSObject` class `import "OAuthConfigurator.h"` and implement `OAuthConfigurator` protocol:

```objc
@implementation Configurator

#pragma mark OAuthConfigurator methods

- (NSURL *)redirectURI
{
    return [NSURL URLWithString:@"http://localhost"];
}

- (NSString *)facebookApplicationID
{
    return @"APPLICATION_ID";
}

- (NSString *)facebookScope
{
    return @"SCOPE";
}

...

```

#### Step 2

Create `OAuthController` and set to constructor Social OAuth object from `SocialOAuthFactory`:

```objc
- (void)presentOAuthWithOAuthType:(OAuthType)type
{
    SocialOAuthFactory *socialOAuthFactory = [[SocialOAuthFactory alloc] initWithConfigurator:[Configurator new]];
    OAuthController *oauthController = [[OAuthController alloc] initWithSocialOAuth:[socialOAuthFactory OAuthByType:type]];

    oauthController.completionBlock = ^(NSDictionary *response, NSString *errorString, __weak UIViewController *weakOAuthController)
    {
        if(!errorString)
        {
            // create OAuthCredential from response and save to Keychain or something else
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Authorization Error", nil) message:errorString delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
        }

        [weakOAuthController.navigationController dismissViewControllerAnimated:YES completion:nil];
    };
    oauthController.onCancelButtonTap = ^(__weak UIViewController *weakOAuthController)
    {
        [weakOAuthController.navigationController dismissViewControllerAnimated:YES completion:nil];
    };

    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:oauthController] animated:YES completion:nil];
}

```

#### Step 3

Create `OAuthCredential` from completion block response via `OAuthManager`:

```objc
OAuthCredential *credential = [[OAuthManager manager] credentialByResponse:response];
```

`OAuthCredential` supporting `NSCoding` protocol, you can save `OAuthCredential` object to Keychain, NSUserDefault and etc.

# Via custom Social Newtworks

#### Step 1

Create Social Network class subclass of `SocialOAuth` and override constructor:

```objc
@implementation YandexOAuth

#pragma mark Interface methods

+ (instancetype)OAuth
{
    return [[YandexOAuth alloc] initWithBaseURL:@"https://oauth.yandex.ru/" authPath:@"authorize" clientID:@"CLIEND_ID" clientSecret:@"CLIENT_SECRET" responseType:@"token" redirectURI:[NSURL URLWithString:@"http://localhost"] scope:@"SCOPE"];
}
```

Also you can create class subclass of `OAuthAppearance`:

```objc
@implementation YanexAppearance

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
```

And set to Social OAuth (override main constructor):

```objc
- (instancetype)initWithBaseURL:(NSString *)baseURL authPath:(NSString *)authPath clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret responseType:(NSString *)responseType redirectURI:(NSURL *)redirectURI scope:(NSString *)scope
{
    self = [super initWithBaseURL:baseURL authPath:authPath clientID:clientID clientSecret:clientSecret responseType:responseType redirectURI:redirectURI scope:scope];
    if(self)
    {
        self.appearance = [YanexAppearance appearance];
    }
    return self;
}
```

#### Step 2

Create `YanexAppearance` and set to `OAuthController`:

``` 
OAuthController *oauthController = [[OAuthController alloc] initWithSocialOAuth:[YanexAppearance OAuth]];

oauthController.onCancelButtonTap = ^(__weak UIViewController *weakOAuthController)
{
	// dismiss
};
    oauthController.completionBlock = ^(CATOAuthCredential *credential, NSString *errorString, __weak UIViewController *weakOAuthController)
{
	// dismiss and procces credential (save to user defaults or something else)
};
[self presentViewController:[[UINavigationController alloc] initWithRootViewController:oauthController] animated:YES completion:nil];

```

#### Demo

![demo][demo]

# TO DO:

- Support `SFSafariViewController`. But some social networks don't support callback like `myapp://callback`;
- Support *OAuth 1.0*  for `Twitter` and etc;
- Tests, correct serialize response data;
- Support `TV_OS`;
- Renew `Access token`;
- More social networks : ) ;
- Any ideas ?




[demo]: https://github.com/Alex601t/OAuth/blob/master/Assets/Catamaran.gif 
[platform]: https://img.shields.io/badge/platform-iOS-brightgreen.svg
