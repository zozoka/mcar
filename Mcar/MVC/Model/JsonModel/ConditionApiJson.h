//
//  ConditionApiJson.h
//  Matching
//
//  Created by thanh tung on 2/22/17.
//  Copyright © 2017 Ominext. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ConditionJson;

@interface ConditionApiJson : JSONModel
@property (nonatomic) NSNumber *status;
@property (strong,nonatomic) NSString *message;
//@property (strong,nonatomic) MCMetadataJson *metadata;
@property (strong,nonatomic) NSArray<ConditionJson> *data;
@end
