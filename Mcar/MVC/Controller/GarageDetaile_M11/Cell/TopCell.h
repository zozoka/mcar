//
//  TopCell.h
//  Mcar
//
//  Created by thanh tung on 10/9/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;

@interface TopCell : UITableViewCell<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIView *viewPoint;
@property (weak, nonatomic) IBOutlet UIView *viewCall;
@property (weak, nonatomic) IBOutlet UIView *viewAddress;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *countServiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countBookingLabel;
@property (weak, nonatomic) IBOutlet UILabel *countCommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *garageNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *servicesLabel;
@property (weak, nonatomic) IBOutlet UILabel *countCmLabel;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIView *viewDichVu;
@property (weak, nonatomic) IBOutlet UIView *viewXemThem;
@property (weak, nonatomic) IBOutlet UIButton *buttonXemThem;
@property (weak, nonatomic) IBOutlet UIButton *dichVuButton;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UILabel *timeStatusLabel;

@end
