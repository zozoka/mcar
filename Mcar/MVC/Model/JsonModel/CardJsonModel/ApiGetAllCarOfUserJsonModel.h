//
//  ApiGetAllCarOfUserJsonModel.h
//  Mcar
//
//  Created by thanh tung on 11/8/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MetadataJsonModel.h"
#import "CarJsonModel.h"

@interface ApiGetAllCarOfUserJsonModel : JSONModel
@property (strong,nonatomic) MetadataJsonModel<Optional> *metadata;
@property (strong,nonatomic) NSNumber<Optional> *status;
@property (strong,nonatomic) NSString<Optional> *message;
@property (strong,nonatomic) NSArray<CarJsonModel*><Optional>*data;

@end

//"metadata": {
//    "pagination": {
//        "total": 3,
//        "limit": 20,
//        "page": 1,
//        "last": 1,
//        "from": 1,
//        "to": 3
//    }
//},
//"status": 1,
//"message": "OK",
//"data": [
//         {
//             "id": 6,

