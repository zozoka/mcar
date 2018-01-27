//
//  HistoryApiJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/23/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MetadataJsonModel.h"
#import "HistoryJsonModel.h"

@interface HistoryApiJsonModel : JSONModel
@property(strong,nonatomic)MetadataJsonModel<Optional> *metadata;
@property(strong,nonatomic)NSNumber<Optional> *status;
@property(strong,nonatomic)NSString<Optional> *message;
@property(strong,nonatomic)NSArray<HistoryApiJsonModel*><Optional> *data;
@end
//metadata: null,
//status: 1,
//message: "OK",

