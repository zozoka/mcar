//
//  HistoryJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/23/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "GarageDetailJsonModel.h"

@interface HistoryJsonModel : JSONModel
@property(strong,nonatomic) NSNumber<Optional> *historyId;
@property(strong,nonatomic) NSString<Optional> *action;
@property(strong,nonatomic) NSString<Optional> *created_at;
@property(strong,nonatomic) NSString<Optional> *updated_at;
@property(strong,nonatomic) NSString<Optional> *garage_id;
@property(strong,nonatomic) NSString<Optional> *user_id;
@property(strong,nonatomic) NSString<Optional> *booking_id;
@property(strong,nonatomic) NSString<Optional> *description_api;
@property(strong,nonatomic) GarageDetailJsonModel<Optional> *garage;
@end

//id: 7,
//action: "book",
//description: "Đặt lịch hẹn",
//created_at: "2017-09-21 18:15:27",
//updated_at: "2017-09-21 18:15:27",
//garage_id: 1,
//user_id: 39,
//booking_id: 24,
//garage: {

