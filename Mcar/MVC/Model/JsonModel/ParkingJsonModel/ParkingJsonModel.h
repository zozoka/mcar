//
//  ParkingJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/16/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ParkingJsonModel : JSONModel
@property (strong,nonatomic) NSNumber<Optional> *parkingId;
@property (strong,nonatomic) NSString<Optional> *name;
@property (strong,nonatomic) NSString<Optional> *address;
@property (strong,nonatomic) NSNumber<Optional> *latitude;
@property (strong,nonatomic) NSNumber<Optional> *longitude;
@property (strong,nonatomic) NSString<Optional> *created_at;
@property (strong,nonatomic) NSString<Optional> *updated_at;
@property (strong,nonatomic) NSNumber<Optional> *created_user;
@property (strong,nonatomic) NSNumber<Optional> *updated_user;
@property (strong,nonatomic) NSNumber<Optional> *distance;
@end


