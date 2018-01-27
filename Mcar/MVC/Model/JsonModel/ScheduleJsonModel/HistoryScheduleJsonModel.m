//
//  HistoryScheduleJsonModel.m
//  Mcar
//
//  Created by thanh tung on 10/24/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "HistoryScheduleJsonModel.h"

@implementation HistoryScheduleJsonModel
+ (JSONKeyMapper *) keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"historyScheduleId":@"id"
                                                                  }];
}
@end
