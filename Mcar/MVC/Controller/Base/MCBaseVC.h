//
//  MCBaseVC.h
//  BaseProject
//
//  Created by Tinhvv on 4/20/16.
//  Copyright © 2016 Tinhvv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGlobal.h"
#import <AFNetworking/AFNetworking.h>
#import "MCNetworkManager.h"
#import "MCSession.h"
#import <UIImageView+AFNetworking.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Google/SignIn.h>
#import <AccountKit/AccountKit.h>

@interface MCBaseVC : UIViewController
@property (nonatomic, strong, readonly) MCNetworkManager *networkManager;
@property (nonatomic, strong, readonly) MCSession *session;
@end
