//
//  MCSession.m
//  BaseProject
//
//  Created by Tinhvv on 4/20/16.
//  Copyright © 2016 Tinhvv. All rights reserved.
//

#import "MCSession.h"
#import "PPDeviceUtil.h"
#import "NSObject+Extension.h"
#import "Macros.h"
@implementation MCSession
+ (instancetype)sharedSession {
    static MCSession *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [MCSession new];
    });
    
    return _sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        [self restoreSessionIfNeeded];
    }
    return self;
}

- (void)initDefaultData {
    self.uniqueToken = @"";
    self.deviceId = [PPDeviceUtil UUIDString];
    self.deviceOs = [NSString stringWithFormat:@"%@ %@", [PPDeviceUtil systemName], [PPDeviceUtil systemVersion]];
    self.deviceName = [PPDeviceUtil name];
    self.isAuthenticated = NO;
    self.userId = nil;
    self.userFullName = @"";
    self.userEmail = @"";
    self.userPhone = @"";
    self.userImageAvataUrl = @"";
    self.dateOfBirth = @"";
    self.imageFromUrl = NO;
    self.yearOfManufactureCar = @"";
    self.userCarName = @"";
    self.carNumber = @"";
    self.user_car_id = nil;
}

- (void)save {
    NSDictionary *allDataTmp = [self propertiesDictionary];
    NSMutableDictionary *allData = [[NSMutableDictionary alloc] initWithDictionary:allDataTmp];
    
    for (id key in[allDataTmp allKeys]) {
        id value = [allDataTmp objectForKey:key];
        
        if (!([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])) {
            [allData removeObjectForKey:key];
        }
    }
    
    NSString *sessionKey = [NSString stringWithFormat:@"%@_%@", kSessionKey, kSessionVersion];
    [[NSUserDefaults standardUserDefaults] setObject:allData forKey:sessionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)restoreSessionIfNeeded {
    NSString *sessionKey = [NSString stringWithFormat:@"%@_%@", kSessionKey, kSessionVersion];
    NSDictionary *allData = [[NSUserDefaults standardUserDefaults] objectForKey:sessionKey];
    
    if (allData && ![allData isEqual:[NSNull null]]) {
        [self initDefaultData];
        
        NSArray *keyArray =  [allData allKeys];
        NSUInteger count = [keyArray count];
        for (int i = 0; i < count; i++) {
            id obj = [allData objectForKey:[keyArray objectAtIndex:i]];
            if ([self respondsToSelector:NSSelectorFromString([keyArray objectAtIndex:i])]) {
                [self setValue:obj forKey:[keyArray objectAtIndex:i]];
            }
        }
    }
    else {
        [self initDefaultData];
    }
    [self save];
}

- (void)clearSessionData {
    NSString *sessionKey = [NSString stringWithFormat:@"%@_%@", kSessionKey, kSessionVersion];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:sessionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self initDefaultData];
}

- (void)printDescription {
    NSString *sessionKey = [NSString stringWithFormat:@"%@_%@", kSessionKey, kSessionVersion];
    NSDictionary *allData = [[NSUserDefaults standardUserDefaults] objectForKey:sessionKey];
    DLog(@"%@", allData);
}
@end
