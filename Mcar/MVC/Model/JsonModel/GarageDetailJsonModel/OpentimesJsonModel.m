//
//  OpentimesJsonModel.m
//  Mcar
//
//  Created by thanh tung on 10/11/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "OpentimesJsonModel.h"

@implementation OpentimesJsonModel
+ (JSONKeyMapper *) keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"idOpenTime":@"id"
                                                                  }];
}
@end
