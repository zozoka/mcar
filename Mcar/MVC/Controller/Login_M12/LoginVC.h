//
//  LoginVC.h
//  Mcar
//
//  Created by thanh tung on 9/27/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBaseVC.h"
#import <AccountKit/AccountKit.h>
#import "LoginApiJsonModel.h"
#import "DataLoginJsonModel.h"
#import "UserJsonModel.h"
#import "UserVC.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Google/SignIn.h>
#import "UpdateInfoUserVC.h"

@interface LoginVC : MCBaseVC<AKFViewControllerDelegate,GIDSignInUIDelegate,GIDSignInDelegate>
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *googleView;
@property (weak, nonatomic) IBOutlet UIView *facebookView;

@end
