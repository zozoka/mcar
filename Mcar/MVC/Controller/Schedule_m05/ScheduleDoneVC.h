//
//  ScheduleDoneVC.h
//  Mcar
//
//  Created by thanh tung on 11/10/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleDoneTopCell.h"
#import "ScheduleDataPickerCell.h"
#import "ScheduleListServicesCell.h"
#import "CheckListServiceCell.h"
#import "ScheduleTextViewCell.h"
#import "GarageDetailJsonModel.h"
#import "MCBaseVC.h"
#import <UITextView+Placeholder/UITextView+Placeholder.h>
#import "ResponseBookingJsonModel.h"

@interface ScheduleDoneVC : MCBaseVC<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContentViewTable;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTextViewConstraint;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSArray *arrData;
@property (weak, nonatomic) IBOutlet UIImageView *noteImgView;
@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;
@property (strong, nonatomic) GarageDetailJsonModel *garageDetailJsonModel;
@end
