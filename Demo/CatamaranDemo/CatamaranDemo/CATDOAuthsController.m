//
//  CATDOAuthsController.m
//  CatamaranDemo
//
//  Created by Alexandr on 16.04.16.
//  Copyright © 2016 Orangesoft LLC. All rights reserved.
//

#import "CATDOAuthsController.h"
#import "CATSocialOAuthFactory.h"
#import "CATDConfigurator.h"
#import "CATOAuthController.h"
#import "CATOAuthCredential.h"
#import "CATOAuthManager.h"

@interface CATDOAuthsController()

@property(nonatomic, strong) NSArray *socialNetworks;

@end

@implementation CATDOAuthsController

#pragma mark Private methods

- (void)initSocialNewtorks
{
    CATSocialOAuthFactory *factory = [[CATSocialOAuthFactory alloc] initWithConfigurator:[CATDConfigurator new]];
    NSMutableArray *socialNetowkrs = [NSMutableArray array];
    
    for(NSUInteger oauthIndex = 0; oauthIndex < OSOAuthTypeGitHub + 1; oauthIndex++)
    {
        [socialNetowkrs addObject:[factory OAuthByType:oauthIndex]];
    }
    
    self.socialNetworks = socialNetowkrs.copy;
}

- (void)createAndPresentOAuthControllerForOAuth:(CATSocialOAuth *)oauth
{
    CATOAuthController *oauthController = [[CATOAuthController alloc] initWithSocialOAuth:oauth];
    oauthController.onCancelButtonTap = ^(__weak UIViewController *weakOAuthController)
    {
        [weakOAuthController.navigationController dismissViewControllerAnimated:YES completion:nil];
    };
    oauthController.completionBlock = ^(CATOAuthCredential *credential, NSString *errorString, __weak UIViewController *weakOAuthController)
    {
        if(errorString)
        {
            [[[UIAlertView alloc] initWithTitle:@"Hmm..." message:errorString delegate:nil cancelButtonTitle:@"Try again." otherButtonTitles:nil] show];
        }
        else
        {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:credential];
            [[NSUserDefaults standardUserDefaults] setValue:data forKey:NSStringFromClass([oauth class])];
            
            [[[UIAlertView alloc] initWithTitle:@"Access token" message:credential.accessToken delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        
        [weakOAuthController.navigationController dismissViewControllerAnimated:YES completion:nil];
    };
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:oauthController] animated:YES completion:nil];
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.socialNetworks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CATDOAuthCellIdentifier"];
    CATSocialOAuth *socialOAuth = self.socialNetworks[indexPath.row];
    cell.textLabel.text = [socialOAuth.appearance title];
    return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CATSocialOAuth *oauth = self.socialNetworks[indexPath.row];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromClass([oauth class])];
    if(!data)
    {
        [self createAndPresentOAuthControllerForOAuth:oauth];
    }
    else
    {
        CATOAuthCredential *credential = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        [[[UIAlertView alloc] initWithTitle:@"Access token" message:credential.accessToken delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initSocialNewtorks];
}

@end
