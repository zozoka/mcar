//
//  GarageServicesApiJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/3/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface GarageServicesApiJsonModel : JSONModel
@property(strong,nonatomic)NSNumber<Optional> *idService;
@property(strong,nonatomic)NSString<Optional> *name;
@property(strong,nonatomic)NSNumber<Optional> *garage_id;
@property(strong,nonatomic)NSString<Optional> *created_at;
@property(strong,nonatomic)NSString<Optional> *updated_at;
@property(strong,nonatomic)NSString<Optional> *created_user;
@property(strong,nonatomic)NSString<Optional> *updated_user;
@end
