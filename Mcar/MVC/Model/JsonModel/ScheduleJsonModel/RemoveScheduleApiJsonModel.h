//
//  RemoveScheduleApiJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/24/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MetadataJsonModel.h"

@interface RemoveScheduleApiJsonModel : JSONModel
@property(strong,nonatomic)MetadataJsonModel<Optional> *metadata;
@property(strong,nonatomic)NSString<Optional> *status;
@property(strong,nonatomic)NSString<Optional> *message;
@end

//"metadata": null,
//"status": 1,
//"message": "OK",

