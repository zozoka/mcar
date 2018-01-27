//
//  GarageServicesJsonModel.m
//  Mcar
//
//  Created by thanh tung on 10/11/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "GarageServicesJsonModel.h"

@implementation GarageServicesJsonModel
+ (JSONKeyMapper *) keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"idService":@"id"
                                                                  }];
}
@end
