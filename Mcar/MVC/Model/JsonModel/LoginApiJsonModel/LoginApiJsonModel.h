//
//  LoginApiJsonModel.h
//  Mcar
//
//  Created by thanh tung on 9/28/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MetadataJsonModel.h"
#import "DataLoginJsonModel.h"

@interface LoginApiJsonModel : JSONModel

@property(strong,nonatomic) MetadataJsonModel<Optional> *metadata;
@property(strong,nonatomic) NSNumber<Optional> *status;
@property(strong,nonatomic) NSString<Optional> *message;
@property(strong,nonatomic) DataLoginJsonModel<Optional> *data;
@end
