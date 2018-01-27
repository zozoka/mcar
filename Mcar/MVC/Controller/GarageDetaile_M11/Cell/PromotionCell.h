//
//  PromotionCell.h
//  Mcar
//
//  Created by thanh tung on 10/13/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromotionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageThumbView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTitle;

@end
