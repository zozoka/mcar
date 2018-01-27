//
//  ProvinceJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/11/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ProvinceJsonModel : JSONModel
@property(strong,nonatomic)NSNumber<Optional> *idProvince;
@property(strong,nonatomic)NSString<Optional> *name;
@property(strong,nonatomic)NSNumber<Optional> *code;
@property(strong,nonatomic)NSString<Optional> *created_at;
@property(strong,nonatomic)NSString<Optional> *updated_at;
@property(strong,nonatomic)NSNumber<Optional> *created_user;
@property(strong,nonatomic)NSNumber<Optional> *updated_user;
@end

//id: 1,
//name: "Hà Nội",
//code: 1,
//created_at: null,
//updated_at: null,
//created_user: null,
//updated_user: null

