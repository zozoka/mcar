//
//  NewsJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/17/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface NewsJsonModel : JSONModel
@property (strong,nonatomic) NSNumber<Optional> *idNews;
@property (strong,nonatomic) NSString<Optional> *body;
@property (strong,nonatomic) NSString<Optional> *created_at;
@property (strong,nonatomic) NSString<Optional> *updated_at;
@property (strong,nonatomic) NSNumber<Optional> *created_user;
@property (strong,nonatomic) NSNumber<Optional> *updated_user;
@property (strong,nonatomic) NSString<Optional> *title;
@property (strong,nonatomic) NSString<Optional> *sound;
@property (strong,nonatomic) NSNumber<Optional> *badge;
@property (strong,nonatomic) NSString<Optional> *click_action;
@property (strong,nonatomic) NSNumber<Optional> *role_id;

@end
//id: 7,
//body: "tin nhắn chung",
//created_at: null,
//updated_at: null,
//created_user: null,
//updated_user: null,
//title: "tin nhắn chung",
//sound: null,
//badge: null,
//click_action: null,
//role_id: 4
