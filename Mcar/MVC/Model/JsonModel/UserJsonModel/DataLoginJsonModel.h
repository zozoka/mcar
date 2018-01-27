//
//  DataLoginJsonModel.h
//  Mcar
//
//  Created by thanh tung on 9/28/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "UserJsonModel.h"

@interface DataLoginJsonModel : JSONModel
@property(strong,nonatomic) NSString<Optional> *api_token;
@property(strong,nonatomic) UserJsonModel<Optional> *user;
@end
