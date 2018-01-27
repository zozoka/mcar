//
//  MCGlobal.h
//  BaseProject
//
//  Created by Tinhvv on 4/20/16.
//  Copyright © 2016 Tinhvv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "Macros.h"
#import "MCLib.h"
#import "MCConfig.h"
#import "StringDefine.h"

@interface MCGlobal : NSObject
+ (instancetype) shareGlobal;
//MARK: - MESSAGE
- (void) showMessage:(NSString *)message inView:(id) mySelf;
- (void) showMessage:(NSString *)message inView:(id) mySelf action:(void (^) (void))handleAction;
- (void) showMessage:(NSString *)message buttonTitle1:(NSString *)btnTitle1 buttonTitle2:(NSString *)btnTitle2 inView:(id) mySelf action:(void (^) (void))handleAction;

- (void) showMessage:(NSString *)message buttonTitle1:(NSString *)btnTitle1 buttonTitle2:(NSString *)btnTitle2 inView:(id) mySelf action1:(void (^) (void))handleAction1 action2:(void (^) (void))handleAction2 ;
- (void) showMessage:(NSString *)message buttonTitle1:(NSString *)btnTitle1 buttonTitle2:(NSString *)btnTitle2 buttonTitle3:(NSString *)btnTitle3 inView:(id) mySelf action1:(void (^) (void))handleAction1 action2:(void (^) (void))handleAction2 action3:(void (^) (void))handleAction3;
//MARK: - INDICATOR
- (UIActivityIndicatorView *)showIndicatorInView:(UIView*)view;
- (void)hiddenIndicator:(UIActivityIndicatorView*)indicatorView;
//MARK: - ACTIONSHEET
- (void) showActionSheetWithTitle:(NSString *)title message:(NSString *)message buttonTitle1:(NSString *)btn1 buttonTitle2:(NSString *)btn2 inView:(UIViewController*) mySelf buttonSender:(UIButton*)sender action1:(void (^) (void))handleAction1 action2:(void (^) (void))handleAction2;
//MARK: - COLOR
- (UIColor *)colorFromHexString:(NSString *)hexString;
//MARK: - SAVE TO NSUSERDEFAULT
- (void)saveArrayListToNSuserDefault:(NSMutableArray *)object withKey:(NSString *)key;

- (void)saveCustomObject:(id)object key:(NSString *)key;
//MARK: - GET OBJECT FROM NSUSERDEFAULT
- (id)loadCustomObjectWithKey:(NSString *)key;
- (NSMutableArray *)getArrayListFromNSuserDefaultwithKey:(NSString *)key;
//MARK: - DATE TIME
- (NSString*)formatDatewithString:(NSString*)dateString;// input: YY-MM-DD out: EEEE, dd-MM-yyyy
- (NSString *)formatNumber:(NSString *)mobileNumber;
//MARK: - string is nil or empty
-(BOOL)stringIsNilOrEmpty:(NSString*)aString;
//share
-(void)ShareWithFriend:(id)mySelf andButtonSender:(UIButton*)sender;
// convert time like facebook
- (NSString *)timeAgoStringFromDate:(NSDate *)date;
@end
