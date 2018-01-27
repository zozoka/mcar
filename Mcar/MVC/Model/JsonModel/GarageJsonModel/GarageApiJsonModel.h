//
//  GarageApiJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/3/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MetadataJsonModel.h"
#import "GarageJsonModel.h"

@interface GarageApiJsonModel : JSONModel
@property(strong,nonatomic) MetadataJsonModel<Optional> *metadata;
@property(strong,nonatomic) NSNumber<Optional> *status;
@property(strong,nonatomic) NSString<Optional> *message;
@property(strong,nonatomic) NSArray<GarageJsonModel*><Optional> *data;
@end

