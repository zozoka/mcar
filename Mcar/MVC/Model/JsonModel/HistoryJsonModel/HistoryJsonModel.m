//
//  HistoryJsonModel.m
//  Mcar
//
//  Created by thanh tung on 10/23/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "HistoryJsonModel.h"

@implementation HistoryJsonModel
+ (JSONKeyMapper *) keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"historyId":@"id",
                                                                  @"description_api":@"description"
                                                                  }];
}
@end
