//
//  HistoryScheduleApiJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/24/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MetadataJsonModel.h"
#import "HistoryScheduleJsonModel.h"

@interface HistoryScheduleApiJsonModel : JSONModel
@property(strong,nonatomic)MetadataJsonModel<Optional> *metadata;
@property(strong,nonatomic)NSNumber<Optional> *status;
@property(strong,nonatomic)NSString<Optional> *message;
@property(strong,nonatomic)NSArray<HistoryScheduleJsonModel*><Optional> *data;
@end
