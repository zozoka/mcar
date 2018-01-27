//
//  ApiCarBrandJsonModel.h
//  Mcar
//
//  Created by thanh tung on 11/4/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MetadataJsonModel.h"
#import "CarBrandsJsonModel.h"


@interface ApiCarBrandJsonModel : JSONModel
@property(strong,nonatomic) MetadataJsonModel<Optional> *metadata;
@property(strong,nonatomic) NSNumber<Optional> *status;
@property(strong,nonatomic) NSString<Optional> *message;
@property(strong,nonatomic) NSArray<CarBrandsJsonModel *><Optional> *data;
@end
