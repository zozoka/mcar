//
//  RoleJsonModel.m
//  Mcar
//
//  Created by thanh tung on 9/28/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "RoleJsonModel.h"

@implementation RoleJsonModel
+ (JSONKeyMapper *) keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                       @"role_id":@"id",
                                                       @"des":@"description"
                                                       }];
}
@end
