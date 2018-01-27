//
//  ScheduleVC.h
//  Mcar
//
//  Created by thanh tung on 9/30/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleVC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *removeScheduleView;
@property (weak, nonatomic) IBOutlet UIView *directView;
@property (weak, nonatomic) IBOutlet UILabel *titleGarageScheduleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *removeScheduleButton;
@property (weak, nonatomic) IBOutlet UIButton *directMapButton;
@property (weak, nonatomic) IBOutlet UIImageView *garageImageView;


@end
