//
//  UpdateInfoUserApiJsonModel.h
//  Mcar
//
//  Created by thanh tung on 11/3/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MetadataJsonModel.h"
#import "UserJsonModel.h"

@interface UpdateInfoUserApiJsonModel : JSONModel
@property(strong,nonatomic)MetadataJsonModel<Optional> *metadata;
@property(strong,nonatomic)NSNumber<Optional> *status;
@property(strong,nonatomic)NSString<Optional> *message;
@property(strong,nonatomic)UserJsonModel<Optional> *data;
@end

//"metadata": null,
//"status": 1,
//"message": "OK",
//"data": {

