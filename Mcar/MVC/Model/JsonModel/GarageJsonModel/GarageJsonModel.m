//
//  GarageJsonModel.m
//  Mcar
//
//  Created by thanh tung on 10/3/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "GarageJsonModel.h"

@implementation GarageJsonModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"garageID": @"id"
                                                                  }];
}
@end
