#import <UIKit/UIKit.h>

@interface CATOAuthAppearance : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSAttributedString *attributedString;

@property(nonatomic, strong) UIColor *tintColor;
@property(nonatomic, strong) UIColor *mainColor;
@property(nonatomic, strong) UIColor *backgroundColor;

@property(nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property(nonatomic, assign) UIActivityIndicatorViewStyle activityIndicatorStyle;

+ (instancetype)appearance;

@end
