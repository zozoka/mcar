//
//  CarBrandsJsonModel.m
//  Mcar
//
//  Created by thanh tung on 10/11/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "CarBrandsJsonModel.h"

@implementation CarBrandsJsonModel
+ (JSONKeyMapper *) keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"idCarBrand":@"id"
                                                                  }];
}
@end
