//
//  ImagesJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/11/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ImagesJsonModel : JSONModel
@property(strong,nonatomic)NSNumber<Optional> *idImage;
@property(strong,nonatomic)NSString<Optional> *name;
@property(strong,nonatomic)NSString<Optional> *created_at;
@property(strong,nonatomic)NSString<Optional> *updated_at;
@property(strong,nonatomic)NSNumber<Optional> *created_user;
@property(strong,nonatomic)NSNumber<Optional> *updated_user;
@property(strong,nonatomic)NSNumber<Optional> *garage_id;

@end

