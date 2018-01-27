//
//  GarageJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/3/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "PromotionsJsonModel.h"
#import "GarageServicesApiJsonModel.h"

@interface GarageJsonModel : JSONModel
@property(strong,nonatomic) NSNumber<Optional> *garageID;
@property(strong,nonatomic) NSString<Optional> *name;
@property(strong,nonatomic) NSString<Optional> *avatar;
@property(strong,nonatomic) NSString<Optional> *address;
@property(strong,nonatomic) NSNumber<Optional> *latitude;
@property(strong,nonatomic) NSNumber<Optional> *longitude;
@property(strong,nonatomic) NSNumber<Optional> *rating;
@property(strong,nonatomic) NSNumber<Optional> *has_advertising;
@property(strong,nonatomic) NSNumber<Optional> *distance;
@property(strong,nonatomic) NSString<Optional> *referral_information;

@property(strong,nonatomic) NSArray<GarageServicesApiJsonModel*><Optional> *garage_services;
@property(strong,nonatomic) NSArray<PromotionsJsonModel*><Optional> *promotions;
@end

