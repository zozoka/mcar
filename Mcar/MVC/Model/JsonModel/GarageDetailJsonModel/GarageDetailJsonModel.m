//
//  GarageDetailJsonModel.m
//  Mcar
//
//  Created by thanh tung on 10/11/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "GarageDetailJsonModel.h"

@implementation GarageDetailJsonModel
+ (JSONKeyMapper *) keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"idGarage":@"id"
                                                                  }];
}

@end
