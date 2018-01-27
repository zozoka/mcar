//
//  PaginationJsonModel.h
//  Mcar
//
//  Created by thanh tung on 9/28/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PaginationJsonModel : JSONModel
@property(strong,nonatomic)NSNumber<Optional> *total;
@property(strong,nonatomic)NSNumber<Optional> *limit;
@property(strong,nonatomic)NSNumber<Optional> *page;
@property(strong,nonatomic)NSNumber<Optional> *last;
@property(strong,nonatomic)NSNumber<Optional> *from;
@property(strong,nonatomic)NSNumber<Optional> *to;

@end
