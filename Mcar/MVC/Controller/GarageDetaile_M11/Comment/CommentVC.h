//
//  CommentVC.h
//  Mcar
//
//  Created by thanh tung on 10/19/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBaseVC.h"
#import "CommentApiJsonModel.h"
#import "GarageDetailJsonModel.h"
#import "RatingApiJsonModel.h"

@interface CommentVC : MCBaseVC
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBottomView;
@property (strong, nonatomic) GarageDetailJsonModel *garageJsonModel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIView *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *garaTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@end
