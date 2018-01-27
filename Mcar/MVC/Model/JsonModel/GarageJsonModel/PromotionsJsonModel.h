//
//  PromotionsJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/3/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PromotionsJsonModel : JSONModel
@property(strong,nonatomic) NSNumber<Optional> *idPromotion;
@property(strong,nonatomic) NSString<Optional> *title;
@property(strong,nonatomic) NSString<Optional> *content;
@property(strong,nonatomic) NSString<Optional> *start;
@property(strong,nonatomic) NSString<Optional> *end;
@property(strong,nonatomic) NSString<Optional> *created_at;
@property(strong,nonatomic) NSString<Optional> *updated_at;
@property(strong,nonatomic) NSString<Optional> *created_user;
@property(strong,nonatomic) NSString<Optional> *updated_user;
@property(strong,nonatomic) NSNumber<Optional> *garage_id;
@property(strong,nonatomic) NSString<Optional> *image;



//id: 3,
//title: "asdasd",
//content: "dasdasd",
//start: null,
//end: null,
//created_at: "2017-09-21 18:29:15",
//updated_at: "2017-09-21 18:29:15",
//created_user: null,
//updated_user: null,
//garage_id: 1,
//image: "_2y_10_FmTtp4IgKwPYTTN_04orlehgHJrrnUww1cdawbMxgS8jQk3hxkNGW.png"
@end
