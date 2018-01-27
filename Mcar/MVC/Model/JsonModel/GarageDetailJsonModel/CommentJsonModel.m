//
//  CommentJsonModel.m
//  Mcar
//
//  Created by thanh tung on 10/11/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "CommentJsonModel.h"

@implementation CommentJsonModel
+ (JSONKeyMapper *) keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"idComment":@"id"
                                                                  }];
}

@end
