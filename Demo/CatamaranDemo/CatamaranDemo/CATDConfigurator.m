//
//  CATDConfigurator.m
//  CatamaranDemo
//
//  Created by Alexandr on 16.04.16.
//  Copyright © 2016 Orangesoft LLC. All rights reserved.
//

#import "CATDConfigurator.h"

@implementation CATDConfigurator

#pragma mark OAuthConfigurator methods

- (NSURL *)redirectURI
{
    return [NSURL URLWithString:@"http://localhost"];
}

- (NSString *)facebookApplicationID
{
    return @"###############";
}

- (NSString *)facebookScope
{
    return @"email";
}

- (NSString *)googleApplicationID
{
    return @"#########-############################.apps.googleusercontent.com";
}

- (NSString *)googleScope
{
    return @"https://www.googleapis.com/auth/userinfo.email+https://www.googleapis.com/auth/userinfo.profile";
}

- (NSString *)instagramApplicationID
{
    return @"################################";
}

- (NSString *)instagramScope
{
    return @"basic";
}

- (NSString *)mailRuApplicationID
{
    return @"######";
}

- (NSString *)okApplicationID
{
    return @"##########";
}

- (NSString *)okApplicationSecret
{
    return @"########################";
}

- (NSString *)okScope
{
    return @"VALUABLE_ACCESS";
}

- (NSString *)vkApplicationID
{
    return @"#######";
}

- (NSString *)vkScope
{
    return @"email";
}

- (NSString *)linkedInApplicationID
{
    return @"#############";
}

- (NSString *)linkedInApplicationSecret
{
    return @"###############";
}

- (NSString *)linkedInScope
{
    return @"r_basicprofile";
}

- (NSString *)yandexApplicationID
{
    return @"###########################";
}

- (NSString *)foursquareApplicationID
{
    return @"#########################################";
}

- (NSString *)gitHubApplicationID {
    return @"#";
}

- (NSString *)gitHubApplicationSecret {
    return @"#";
}

- (NSString *)gitHubScope {
    return @"public_repo";
}

@end
