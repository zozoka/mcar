//
//  GarageDetailJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/11/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "CommentJsonModel.h"
#import "ImagesJsonModel.h"
#import "GarageServicesJsonModel.h"
#import "PromotionsJsonModel.h"
#import "ProvinceJsonModel.h"
#import "OpentimesJsonModel.h"
#import "CarBrandsJsonModel.h"


@interface GarageDetailJsonModel : JSONModel
@property(strong,nonatomic)NSNumber<Optional> *idGarage;
@property(strong,nonatomic)NSString<Optional> *name;
@property(strong,nonatomic)NSNumber<Optional> *latitude;
@property(strong,nonatomic)NSNumber<Optional> *longitude;
@property(strong,nonatomic)NSString<Optional> *created_at;
@property(strong,nonatomic)NSString<Optional> *updated_at;
@property(strong,nonatomic)NSString<Optional> *created_user;
@property(strong,nonatomic)NSString<Optional> *updated_user;
@property(strong,nonatomic)NSString<Optional> *address;
@property(strong,nonatomic)NSNumber<Optional> *province_id;
@property(strong,nonatomic)NSNumber<Optional> *status;
@property(strong,nonatomic)NSString<Optional> *avatar;
@property(strong,nonatomic)NSString<Optional> *opentime;
@property(strong,nonatomic)NSString<Optional> *referral_information;
@property(strong,nonatomic)NSString<Optional> *balance;
@property(strong,nonatomic)NSString<Optional> *phone;
@property(strong,nonatomic)NSString<Optional> *website;
@property(strong,nonatomic)NSString<Optional> *email;
@property(strong,nonatomic)NSNumber<Optional> *rating;
@property(strong,nonatomic)NSNumber<Optional> *rating_total;
@property(strong,nonatomic)NSNumber<Optional> *has_advertising;
@property(strong,nonatomic)NSNumber<Optional> *point;
@property(strong,nonatomic)NSNumber<Optional> *introduced_user;
@property(strong,nonatomic)NSNumber<Optional> *introduced_point;
@property(strong,nonatomic)NSNumber<Optional> *bookmarked;
@property(strong,nonatomic)NSString<Optional> *introduced_time;
@property(strong,nonatomic)NSNumber<Optional> *booking_total;
@property(strong,nonatomic)NSNumber<Optional> *garage_service_total;
@property(strong,nonatomic)NSArray<CommentJsonModel *><Optional> *comments;
@property(strong,nonatomic)NSArray<ImagesJsonModel*><Optional> *images;
@property(strong,nonatomic)NSArray<GarageServicesJsonModel*><Optional> *garage_services;
@property(strong,nonatomic)ProvinceJsonModel<Optional>*province;
@property(strong,nonatomic)NSArray<PromotionsJsonModel*><Optional> *promotions;
@property(strong,nonatomic)NSArray<OpentimesJsonModel*><Optional> *opentimes;
@property(strong,nonatomic)NSArray<CarBrandsJsonModel*><Optional> *car_brands;
@end

