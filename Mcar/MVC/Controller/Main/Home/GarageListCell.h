//
//  GarageListCell.h
//  Mcar
//
//  Created by thanh tung on 9/22/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GarageListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avataImageView;
@property (weak, nonatomic) IBOutlet UILabel *TitleGaraLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIView *poinView;
@property (weak, nonatomic) IBOutlet UILabel *poinLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;
@property (weak, nonatomic) IBOutlet UILabel *adsLabel;
@property (weak, nonatomic) IBOutlet UIView *adsView;


@end
