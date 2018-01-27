//
//  RatingJsonModel.h
//  Mcar
//
//  Created by thanh tung on 10/19/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RatingJsonModel : JSONModel
@property(strong,nonatomic) NSNumber<Optional> *rating;
@end
