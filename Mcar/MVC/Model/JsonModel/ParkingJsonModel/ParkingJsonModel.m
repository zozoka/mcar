//
//  ParkingJsonModel.m
//  Mcar
//
//  Created by thanh tung on 10/16/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "ParkingJsonModel.h"

@implementation ParkingJsonModel
+ (JSONKeyMapper *) keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"parkingId":@"id"
                                                                  }];
}
@end


