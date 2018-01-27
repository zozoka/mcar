//
//  AppDelegate.h
//  Mcar
//
//  Created by thanh tung on 9/14/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBaseNavigationController.h"
#import "HomeVC.h"
#import "M02_ParkingVC.h"
#import "M03_HistoryVC.h"
#import "M04_NotifyNoteVC.h"
@import GoogleMaps;
@import GooglePlaces;
#import <Google/SignIn.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,GIDSignInDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabbarController;
@property (strong ,nonatomic) CLLocationManager *locationManager;
@property (strong ,nonatomic) CLLocation *myLocation;

@end

