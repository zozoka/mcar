//
//  MCDataManager.m
//  BaseProject
//
//  Created by Tinhvv on 4/20/16.
//  Copyright © 2016 Tinhvv. All rights reserved.
//

#import "MCDataManager.h"

@implementation MCDataManager
+ (instancetype)sharedData {
    static MCDataManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [MCDataManager new];
    });
    
    return _sharedInstance;
}
@end
