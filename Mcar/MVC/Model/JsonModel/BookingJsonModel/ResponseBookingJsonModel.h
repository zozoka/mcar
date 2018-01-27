//
//  ResponseBookingJsonModel.h
//  Mcar
//
//  Created by thanh tung on 11/23/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MetadataJsonModel.h"

@interface ResponseBookingJsonModel : JSONModel
@property(strong,nonatomic) MetadataJsonModel<Optional> *metadata;
@property(strong,nonatomic) NSNumber<Optional> *status;
@property(strong,nonatomic) NSString<Optional> *message;
@end

//{
//    "metadata": null,
//    "status": 1,
//    "message": "OK",
//    "data": {
//        "id": 27
//    }
//}
