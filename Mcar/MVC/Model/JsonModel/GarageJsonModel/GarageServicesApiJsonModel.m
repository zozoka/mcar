//
//  GarageServicesApiJsonModel.m
//  Mcar
//
//  Created by thanh tung on 10/3/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "GarageServicesApiJsonModel.h"

@implementation GarageServicesApiJsonModel
+ (JSONKeyMapper *) keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"idService":@"id"
                                                                  }];
}
@end
