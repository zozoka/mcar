//
//  MCUserJson.m
//  BaseProject
//
//  Created by Tinhvv on 8/12/16.
//  Copyright © 2016 Tinhvv. All rights reserved.
//

#import "MCUserJson.h"

@implementation MCUserJson
/**
 *  Json Example:
 {
    id:100,
    user_name: "Tinhvv",
    email: "tinhvv@ominext.com"
 }
 */

/**
*  Option 1: Use coding convention
*/
+ (JSONKeyMapper *) keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                       @"id":@"userID",
                                                       @"user_name":@"userName",
                                                       @"email":@"email"
                                                       }];
}


/**
 *  Option 2: Quickly
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
