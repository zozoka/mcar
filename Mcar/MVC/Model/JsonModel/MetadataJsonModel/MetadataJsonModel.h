//
//  MetadataJsonModel.h
//  Mcar
//
//  Created by thanh tung on 9/28/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "PaginationJsonModel.h"

@interface MetadataJsonModel : JSONModel
@property(strong,nonatomic) PaginationJsonModel<Optional> *pagination;
@end
