//
//  MCSession.h
//  BaseProject
//
//  Created by Tinhvv on 4/20/16.
//  Copyright © 2016 Tinhvv. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSessionKey             @"kSessionKey"
#define kSessionVersion         @"1.0"

@interface MCSession : NSObject

+ (instancetype)sharedSession;

/**
 * Add your session properties here
 */
@property (strong, nonatomic) NSString *uniqueToken;

@property (strong, nonatomic) NSString *deviceId;
@property (strong, nonatomic) NSString *deviceOs;
@property (strong, nonatomic) NSString *deviceType;
@property (strong, nonatomic) NSString *deviceName;
@property (strong, nonatomic) NSString *deviceToken;
@property (assign, nonatomic) BOOL isAuthenticated;
@property (strong, nonatomic) NSNumber *currentUserId;

// Auth token
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSString *userFullName;
@property (strong, nonatomic) NSString *userImageAvataUrl;
@property (assign, nonatomic) BOOL imageFromUrl; //YES = from link url; NO = from library device
@property (strong, nonatomic) NSString *userEmail;
@property (strong, nonatomic) NSString *userPhone;
@property (strong, nonatomic) NSString *dateOfBirth;
// user 's car
@property (strong, nonatomic) NSString *userCarName;
@property (strong, nonatomic) NSString *yearOfManufactureCar;
@property (strong, nonatomic) NSString *carNumber;
@property (strong, nonatomic) NSNumber *user_car_id;

- (void)save;
- (void)restoreSessionIfNeeded;
- (void)clearSessionData;
- (void)printDescription;

@end
