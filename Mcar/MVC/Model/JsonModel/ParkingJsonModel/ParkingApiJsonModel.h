//
//  ParkingApiJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/16/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ParkingJsonModel.h"
#import "MetadataJsonModel.h"

@interface ParkingApiJsonModel : JSONModel
@property(strong,nonatomic) MetadataJsonModel<Optional> *metadata;
@property(strong,nonatomic) NSNumber<Optional> *status;
@property(strong,nonatomic) NSString<Optional> *message;
@property(strong,nonatomic) NSArray<ParkingJsonModel*><Optional> *data;
@end
