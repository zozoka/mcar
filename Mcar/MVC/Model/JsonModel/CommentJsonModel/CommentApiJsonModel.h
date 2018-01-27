//
//  CommentApiJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/19/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MetadataJsonModel.h"
#import "CommentJsonModel.h"

@interface CommentApiJsonModel : JSONModel
@property(strong,nonatomic) MetadataJsonModel<Optional> *metadata;
@property(strong,nonatomic) NSNumber<Optional> *status;
@property(strong,nonatomic) NSString<Optional> *message;
@property(strong,nonatomic) CommentJsonModel<Optional> *data;
@end

//{
//    "metadata": null,
//    "status": 1,
//    "message": "OK",
//    "data": {
//        "id": 4,
//        "content": "dasdasdasd"
//    }
//}

