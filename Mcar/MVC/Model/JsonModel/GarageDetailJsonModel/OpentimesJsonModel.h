//
//  OpentimesJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/11/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface OpentimesJsonModel : JSONModel
@property(strong,nonatomic)NSNumber<Optional> *idOpenTime;
@property(strong,nonatomic)NSNumber<Optional> *garage_id;
@property(strong,nonatomic)NSNumber<Optional> *date_id;
@property(strong,nonatomic)NSString<Optional> *time_start;
@property(strong,nonatomic)NSString<Optional> *time_end;
@property(strong,nonatomic)NSString<Optional> *created_at;
@property(strong,nonatomic)NSString<Optional> *updated_at;
@property(strong,nonatomic)NSNumber<Optional> *created_user;
@property(strong,nonatomic)NSNumber<Optional> *updated_user;
@end
//id: 1,
//garage_id: 1,
//date_id: 0,
//time_start: "08:00:00",
//time_end: "17:30:00",
//created_at: "-0001-11-30 00:00:00",
//updated_at: "-0001-11-30 00:00:00",
//created_user: null,
//updated_user: null

