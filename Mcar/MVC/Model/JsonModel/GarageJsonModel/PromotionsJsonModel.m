//
//  PromotionsJsonModel.m
//  Mcar
//
//  Created by thanh tung on 10/3/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "PromotionsJsonModel.h"

@implementation PromotionsJsonModel
+ (JSONKeyMapper *) keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"idPromotion":@"id"
                                                                  }];
}

@end
