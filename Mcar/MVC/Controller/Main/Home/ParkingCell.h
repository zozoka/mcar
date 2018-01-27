//
//  ParkingCell.h
//  Mcar
//
//  Created by thanh tung on 9/30/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParkingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *parkingName;

@property (weak, nonatomic) IBOutlet UILabel *parkingTitle;
@property (weak, nonatomic) IBOutlet UILabel *parkingDistance;

@end
