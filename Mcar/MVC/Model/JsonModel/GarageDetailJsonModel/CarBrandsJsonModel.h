//
//  CarBrandsJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/11/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CarBrandsJsonModel : JSONModel
@property(strong,nonatomic)NSNumber<Optional> *idCarBrand;
@property(strong,nonatomic)NSString<Optional> *name;
@property(strong,nonatomic)NSString<Optional> *avatar;
@property(strong,nonatomic)NSString<Optional> *created_at;
@property(strong,nonatomic)NSString<Optional> *updated_at;
@property(strong,nonatomic)NSNumber<Optional> *created_user;
@property(strong,nonatomic)NSNumber<Optional> *updated_user;
@end

//id: 2,
//name: "Aston Martin",
//created_at: null,
//updated_at: null,
//created_user: null,
//updated_user: null,

