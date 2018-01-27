//
//  CommentJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/11/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "UserJsonModel.h"

@interface CommentJsonModel : JSONModel
@property(strong,nonatomic)NSNumber<Optional> *idComment;
@property(strong,nonatomic)NSString<Optional> *content;

@property(strong,nonatomic)NSNumber<Optional> *user_id;
@property(strong,nonatomic)NSNumber<Optional> *garage_id;

@property(strong,nonatomic)NSString<Optional> *created_at;
@property(strong,nonatomic)NSString<Optional> *updated_at;
@property(strong,nonatomic)NSNumber<Optional> *status;
@property(strong,nonatomic)UserJsonModel<Optional> *user;

@end

