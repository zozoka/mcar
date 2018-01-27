//
//  CarJsonModel.m
//  Mcar
//
//  Created by thanh tung on 11/8/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "CarJsonModel.h"

@implementation CarJsonModel
+ (JSONKeyMapper *) keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"idCar":@"id"
                                                                  }];
}

@end
