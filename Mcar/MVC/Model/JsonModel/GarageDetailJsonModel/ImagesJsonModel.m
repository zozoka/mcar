//
//  ImagesJsonModel.m
//  Mcar
//
//  Created by thanh tung on 10/11/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "ImagesJsonModel.h"

@implementation ImagesJsonModel
+ (JSONKeyMapper *) keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"idImage":@"id"
                                                                  }];
}
@end