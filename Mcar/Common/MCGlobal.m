//
//  MCGlobal.m
//  BaseProject
//
//  Created by Tinhvv on 4/20/16.
//  Copyright © 2016 Tinhvv. All rights reserved.
//

#import "MCGlobal.h"

@implementation MCGlobal
+ (instancetype) shareGlobal{
    static MCGlobal *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [MCGlobal new];
    });
    
    return _sharedInstance;
}

//---------------------------------------------------------------------------------
//MARK: - MESSAGE

- (void) showMessage:(NSString *)message inView:(id)mySelf{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OK = [UIAlertAction actionWithTitle:OMLang(@"OK") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:OK];
    
    [mySelf presentViewController:alertController animated:YES completion:nil];
}

- (void) showMessage:(NSString *)message inView:(id) mySelf action:(void (^) (void))handleAction{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OK = [UIAlertAction actionWithTitle:OMLang(@"OK") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handleAction) {
            handleAction();
        }
    }];
    
    [alertController addAction:OK];
    
    [mySelf presentViewController:alertController animated:YES completion:nil];
}

- (void) showMessage:(NSString *)message buttonTitle1:(NSString *)btnTitle1 buttonTitle2:(NSString *)btnTitle2 inView:(id)mySelf action:(void (^)(void))handleAction{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:btnTitle1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *OK = [UIAlertAction actionWithTitle:btnTitle2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handleAction) {
            handleAction();
        }
    }];
    
    [alertController addAction:cancel];
    [alertController addAction:OK];
    
    
    [mySelf presentViewController:alertController animated:YES completion:nil];
}

- (void) showMessage:(NSString *)message buttonTitle1:(NSString *)btnTitle1 buttonTitle2:(NSString *)btnTitle2 inView:(id) mySelf action1:(void (^) (void))handleAction1 action2:(void (^) (void))handleAction2{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:btnTitle1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handleAction1) {
            handleAction1();
        }
    }];
    
    UIAlertAction *OK = [UIAlertAction actionWithTitle:btnTitle2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handleAction2) {
            handleAction2();
        }
    }];
    
    [alertController addAction:cancel];
    [alertController addAction:OK];
    
    
    [mySelf presentViewController:alertController animated:YES completion:nil];
}

- (void) showMessage:(NSString *)message buttonTitle1:(NSString *)btnTitle1 buttonTitle2:(NSString *)btnTitle2 buttonTitle3:(NSString *)btnTitle3 inView:(id) mySelf action1:(void (^) (void))handleAction1 action2:(void (^) (void))handleAction2 action3:(void (^) (void))handleAction3{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:btnTitle1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handleAction1) {
            handleAction1();
        }
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:btnTitle2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handleAction2) {
            handleAction2();
        }
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:btnTitle3 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handleAction3) {
            handleAction3();
        }
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    
    
    
    [mySelf presentViewController:alertController animated:YES completion:nil];
}


- (void) showActionSheetWithTitle:(NSString *)title message:(NSString *)message buttonTitle1:(NSString *)btn1 buttonTitle2:(NSString *)btn2 inView:(UIViewController*)mySelf buttonSender:(UIButton*)sender action1:(void (^)(void))handleAction1 action2:(void (^)(void))handleAction2{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:title      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:message
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:OMLang(@"Cancel")
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                              }];
    
    UIAlertAction* button1 = [UIAlertAction
                              actionWithTitle:btn1
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  if (handleAction1) {
                                      handleAction1();
                                  }
                              }];
    
    UIAlertAction* button2 = [UIAlertAction
                              actionWithTitle:btn2
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  if (handleAction2) {
                                      handleAction2();
                                  }
                              }];
    
    [alert addAction:button0];
    [alert addAction:button1];
    [alert addAction:button2];
    alert.popoverPresentationController.sourceView = mySelf.view;
    alert.popoverPresentationController.sourceRect = sender.bounds;
    [mySelf presentViewController:alert animated:YES completion:nil];
}


- (void)changeAllSubviewsToFont:(NSString *)fontName inView:(UIView *)view {
    if ([view respondsToSelector:@selector(font)] && [view respondsToSelector:@selector(setFont:)]) {
        UIFont* currentFont = [view performSelector:@selector(font)];
        UIFont* jpFont = [UIFont fontWithName:fontName size:currentFont.pointSize];
        [view performSelector:@selector(setFont:) withObject:jpFont];
    }else if ([view respondsToSelector:@selector(subviews)]) {
        for (UIView* subview in view.subviews) {
            [self changeAllSubviewsToFont:fontName inView:subview];
        }
    }
}
- (void)showActionSheetWithArrayStringTitle:(NSArray*)stringArr inViewController:(UIViewController*)viewController andActionforButton:(UIButton*)button{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i=0; i<stringArr.count; i++) {
        if (![stringArr[i] isKindOfClass:[NSString class]]) {
            return;
        }
        UIAlertAction *act = [UIAlertAction actionWithTitle:stringArr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            button.tag = i;
            [button setTitle:stringArr[i] forState:UIControlStateNormal];
        }];
        [alert addAction:act];
    }
    UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:OMLang(@"CancelButton") style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAct];
    [viewController presentViewController:alert animated:YES completion:nil];
}

- (void)showActionSheetWithArrayStringTitle:(NSArray*)stringArr inViewController:(UIViewController*)viewController andActionforButton:(UIButton*)button disPlayInLabel:(UILabel*)label{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i=0; i<stringArr.count; i++) {
        if (![stringArr[i] isKindOfClass:[NSString class]]) {
            return;
        }
        UIAlertAction *act = [UIAlertAction actionWithTitle:stringArr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            button.tag = i;
            //            [button setTitle:stringArr[i] forState:UIControlStateNormal];
            label.text = stringArr[i];
        }];
        [alert addAction:act];
    }
    UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:OMLang(@"CancelButton") style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAct];
    [viewController presentViewController:alert animated:YES completion:nil];
}
// COLOR
// Assumes input like "#00FF00" (#RRGGBB).
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


#pragma mark - show indicator view
- (UIActivityIndicatorView *)showIndicatorInView:(UIView*)view{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //indicator.frame = CGRectMake(0, 0, 24, 24);
    indicator.center = view.center;
    [view addSubview:indicator];
    [indicator startAnimating];
    return indicator;
}

- (void)hiddenIndicator:(UIActivityIndicatorView*)indicatorView{
    [indicatorView stopAnimating];
    indicatorView.hidesWhenStopped = TRUE;
}

#pragma mark - save to nsUserDefault
- (void)saveArrayListToNSuserDefault:(NSMutableArray *)object withKey:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
    
}



- (void)saveCustomObject:(id)object key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
    
}

#pragma mark - get object from nsUserDefault

- (id)loadCustomObjectWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}
- (NSMutableArray *)getArrayListFromNSuserDefaultwithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    NSMutableArray *arrayObj = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return arrayObj;
}

#pragma mark DATE TIME


- (NSString*)formatDatewithString:(NSString*)dateString{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormatter2=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, dd-MM-yyyy"];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [[NSDate alloc]init];
    date = [dateFormatter2 dateFromString:dateString];
    NSString * dateOpen = [dateFormatter stringFromDate:date];
    
    NSLocale* currentLocale = [NSLocale currentLocale];
    [[NSDate date] descriptionWithLocale:currentLocale];
    NSDate *currentDate = [NSDate date];
    NSComparisonResult result = [currentDate compare:date];
    if (result == NSOrderedSame) {
        return [NSString stringWithFormat:@"Hôm nay, %@",dateOpen];
    }else{
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        dayComponent.day = 1;
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];
        NSComparisonResult result2 = [nextDate compare:date];
        if (result2 == NSOrderedSame) {
            return [NSString stringWithFormat:@"Ngày mai, %@",dateOpen];
        }else{
            return dateOpen;
        }
    }
}

-(void)ShareWithFriend:(id)mySelf andButtonSender:(UIButton*)sender{
    //    NSString *textToShare = OMLang(@"share_text");
    NSString * strUrl = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%d",YOUR_APP_STORE_ID];
    NSURL *myWebsite = [NSURL URLWithString:strUrl];
    
    //    NSArray *objectsToShare = @[textToShare, myWebsite];
    NSArray *objectsToShare = [NSArray arrayWithObjects:self, myWebsite, nil];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    if (SLComposeViewControllerResultDone){
        
    }
    activityVC.excludedActivityTypes = excludeActivities;
    UIViewController *viewController = (UIViewController*)mySelf;
    activityVC.popoverPresentationController.sourceView = viewController.view;
    activityVC.popoverPresentationController.sourceRect = sender.bounds;
    [mySelf presentViewController:activityVC animated:YES completion:nil];
}
#pragma mark - format mobile number
- (NSString *)formatNumber:(NSString *)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSLog(@"%@", mobileNumber);
    return mobileNumber;
}

-(BOOL)stringIsNilOrEmpty:(NSString*)aString {
    BOOL result = (aString.length == 0 || [aString isEqualToString:@"nil"] || (aString == (NSString *)[NSNull null]));
    return result;
}

/// convert datetime like facebook
- (NSString *)timeAgoStringFromDate:(NSDate *)date {
    NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond)
                                               fromDate:date
                                                 toDate:now
                                                options:0];
    
    if (components.year > 0) {
        formatter.allowedUnits = NSCalendarUnitYear;
    } else if (components.month > 0) {
        formatter.allowedUnits = NSCalendarUnitMonth;
    } else if (components.weekOfMonth > 0) {
        formatter.allowedUnits = NSCalendarUnitWeekOfMonth;
    } else if (components.day > 0) {
        formatter.allowedUnits = NSCalendarUnitDay;
    } else if (components.hour > 0) {
        formatter.allowedUnits = NSCalendarUnitHour;
    } else if (components.minute > 0) {
        formatter.allowedUnits = NSCalendarUnitMinute;
    } else {
        formatter.allowedUnits = NSCalendarUnitSecond;
    }
    
    NSString *formatString = NSLocalizedString(@"%@ trước", @"Used to say how much time has passed. e.g. '2 hours ago'");
    return [NSString stringWithFormat:formatString, [formatter stringFromDateComponents:components]];
}

@end
