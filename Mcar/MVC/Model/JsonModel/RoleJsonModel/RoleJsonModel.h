//
//  RoleJsonModel.h
//  Mcar
//
//  Created by thanh tung on 9/28/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RoleJsonModel : JSONModel

@property(strong,nonatomic) NSNumber *role_id;
@property(strong,nonatomic) NSString<Optional> *name;
@property(strong,nonatomic) NSString<Optional> *des;
@property(strong,nonatomic) NSString<Optional> *created_at;
@property(strong,nonatomic) NSString<Optional> *updated_at;
@property(strong,nonatomic) NSString<Optional> *created_user;
@property(strong,nonatomic) NSString<Optional> *updated_user;
@property(strong,nonatomic) NSNumber<Optional> *status;
@property(strong,nonatomic) NSString<Optional> *role;


@end
