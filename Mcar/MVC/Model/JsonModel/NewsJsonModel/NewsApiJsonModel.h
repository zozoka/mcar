//
//  NewsApiJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/17/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MetadataJsonModel.h"
#import "NewsJsonModel.h"

@interface NewsApiJsonModel : JSONModel
@property(strong,nonatomic) MetadataJsonModel<Optional> *metadata;
@property(strong,nonatomic) NSNumber<Optional> *status;
@property(strong,nonatomic) NSArray<NewsJsonModel*><Optional> *data;
@end


