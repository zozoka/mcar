//
//  UserJsonModel.h
//  Mcar
//
//  Created by thanh tung on 9/28/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
#import "RoleJsonModel.h"


@interface UserJsonModel : JSONModel
@property (strong,nonatomic)NSNumber<Optional> *user_id;
@property (strong,nonatomic)NSString<Optional> *name;
@property (strong,nonatomic)NSString<Optional> *address;
@property (strong,nonatomic)NSString<Optional> *created_at;
@property (strong,nonatomic)NSString<Optional> *updated_at;
@property (strong,nonatomic)NSString<Optional> *avatar;
@property (strong,nonatomic)NSString<Optional> *google_id;
@property (strong,nonatomic)NSString<Optional> *facebook_id;
@property (strong,nonatomic)NSString<Optional> *google_access_token;
@property (strong,nonatomic)NSString<Optional> *facebook_access_token;
@property (strong,nonatomic)NSNumber<Optional> *is_updated_info;
@property (strong,nonatomic)NSString<Optional> *last_login;
@property (strong,nonatomic)NSNumber<Optional> *status;
@property (strong,nonatomic)NSString<Optional> *email;
@property (strong,nonatomic)NSString<Optional> *phone;
@property (strong,nonatomic)NSString<Optional> *birthday;
@property (strong,nonatomic)NSNumber<Optional> *role_id;
@property (strong,nonatomic)RoleJsonModel<Optional> *role;
@property(strong,nonatomic)NSNumber<Optional> *point;
@property(strong,nonatomic)NSNumber<Optional> *garage_id;
@property(strong,nonatomic)NSNumber<Optional> *balance;
@property(strong,nonatomic)NSString<Optional> *job;
@property(strong,nonatomic)NSString<Optional> *recent_latitude;
@property(strong,nonatomic)NSString<Optional> *recent_longitude;

@end
