//
//  HistoryScheduleJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/24/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "GarageDetailJsonModel.h"


@interface HistoryScheduleJsonModel : JSONModel
@property(strong,nonatomic) NSNumber<Optional> *historyScheduleId;
@property(strong,nonatomic) NSNumber<Optional> *user_id;
@property(strong,nonatomic) NSNumber<Optional> *garage_id;
@property(strong,nonatomic) NSString<Optional> *created_at;
@property(strong,nonatomic) NSString<Optional> *updated_at;
@property(strong,nonatomic) NSString<Optional> *date;
@property(strong,nonatomic) NSNumber<Optional> *status;
@property(strong,nonatomic) NSString<Optional> *additional_request;
@property(strong,nonatomic) NSNumber<Optional> *point;
@property(strong,nonatomic) NSNumber<Optional> *user_car_id;
@property(strong,nonatomic) NSString<Optional> *time_start;
@property(strong,nonatomic) NSString<Optional> *time_end;
@property(strong,nonatomic) GarageDetailJsonModel<Optional> *garage;
@end

