#import <UIKit/UIKit.h>
#import "CATSocialOAuth.h"
#import "CATOAuthCredential.h"

typedef void (^OAuthControllerCompletionBlock)(CATOAuthCredential *credential, NSString *errorString, __weak UIViewController *weakOAuthController);
typedef void (^OAuthControllerActionEventBlock)(__weak UIViewController *weakOAuthController);

@interface CATOAuthController : UIViewController

@property(nonatomic, strong, readonly) CATSocialOAuth *socialOAuth;

@property(nonatomic, copy) OAuthControllerCompletionBlock completionBlock;
@property(nonatomic, copy) OAuthControllerActionEventBlock onCancelButtonTap;

- (instancetype)initWithSocialOAuth:(CATSocialOAuth *)socialOAuth;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

@end
