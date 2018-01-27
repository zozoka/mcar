//
//  AppDelegate.m
//  Mcar
//
//  Created by thanh tung on 9/14/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self configLocation];
    [GMSServices provideAPIKey:@"AIzaSyBaMDbGSsYe5VoapngTpeqPXcw7Krmmpfc"];
    [GMSPlacesClient provideAPIKey:@"AIzaSyBaMDbGSsYe5VoapngTpeqPXcw7Krmmpfc"];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    HomeVC *homeView = [[HomeVC alloc] initWithNibName:@"HomeVC" bundle:nil];
    M02_ParkingVC * parkingVC = [[M02_ParkingVC alloc] initWithNibName:@"M02_ParkingVC" bundle:nil];
    M03_HistoryVC *historyVC = [[M03_HistoryVC alloc] initWithNibName:@"M03_HistoryVC" bundle:nil];
    M04_NotifyNoteVC *notifyVC = [[M04_NotifyNoteVC alloc]initWithNibName:@"M04_NotifyNoteVC" bundle:nil];
    
    int offset = 7;
    UIEdgeInsets imageInset = UIEdgeInsetsMake(offset, 0, -offset, 0);
    
    //[[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"home_icon.png"]];
    homeView.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"" image:[UIImage imageNamed:@"home_unselected"] selectedImage:[UIImage imageNamed:@"home_selected"]];
    homeView.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_selected"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    homeView.tabBarItem.imageInsets = imageInset;
    
    parkingVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"" image:[UIImage imageNamed:@"parking_unselected"] selectedImage:[UIImage imageNamed:@"parking_selected"]];
    parkingVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"parking_selected"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    parkingVC.tabBarItem.imageInsets = imageInset;
    
    historyVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"" image:[UIImage imageNamed:@"calenda_unselected"] selectedImage:[UIImage imageNamed:@"calenda_selected"]];
    historyVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"calenda_selected"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    historyVC.tabBarItem.imageInsets = imageInset;
    
    notifyVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"" image:[UIImage imageNamed:@"noti_unselected"] selectedImage:[UIImage imageNamed:@"noti_selected"]];
    notifyVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"noti_selected"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    notifyVC.tabBarItem.imageInsets = imageInset;
    
    UINavigationController *homeController = [[UINavigationController alloc]initWithRootViewController:homeView];
    homeController.navigationBar.hidden = YES;
    UINavigationController *parkingController = [[UINavigationController alloc]initWithRootViewController:parkingVC];
    parkingController.navigationBar.hidden = YES;
    UINavigationController *historyController = [[UINavigationController alloc]initWithRootViewController:historyVC];
    historyController.navigationBar.hidden = YES;
    UINavigationController *notifyController = [[UINavigationController alloc]initWithRootViewController:notifyVC];
    notifyController.navigationBar.hidden = YES;
    
    self.tabbarController = [[UITabBarController alloc]init];
    NSArray *controllers = [[NSArray alloc]initWithObjects:homeController,parkingController,historyController,notifyController,nil];
    self.tabbarController.viewControllers = controllers;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.tabbarController;
    
    // facebook config
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    // google config
    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError: &configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    [GIDSignIn sharedInstance].delegate = self;
    //localtion
    [self.window makeKeyAndVisible];
    return YES;
}


#ifdef __IPHONE_9_0
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary *)options {
    [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
}
#else
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    return YES;
    
}
#endif

#pragma mark setup myLocation
- (void)configLocation{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

//// google delegate
//- (BOOL)application:(UIApplication *)app
//            openURL:(NSURL *)url
//            options:(NSDictionary *)options {
//    return [[GIDSignIn sharedInstance] handleURL:url
//                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
//}

-(void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error{
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation * currentLocation = [locations lastObject];
    self.myLocation = [[CLLocation alloc]init];
    self.myLocation = currentLocation;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
