//
//  InitialViewController.m
//  Gathr
//
//  Created by Poulose Matthen on 31/07/15.
//  Copyright (c) 2015 Zettanode. All rights reserved.
//

#import "InitialViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface InitialViewController () <FBSDKLoginButtonDelegate>

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = CGPointMake(self.view.center.x, 290);
    loginButton.delegate = self;
    [self.view addSubview:loginButton];
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    if (!error) {
        [self performSegueWithIdentifier:@"WhoSegue" sender:self];
    }
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    NSLog(@"Logged Out");
}

@end
