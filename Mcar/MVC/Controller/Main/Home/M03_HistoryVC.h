//
//  M03_HistoryVC.h
//  Mcar
//
//  Created by thanh tung on 9/20/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBaseVC.h"
#import "ScheduleVC.h"
#import "HistoryCell.h"
#import "HistoryApiJsonModel.h"
#import "HistoryScheduleApiJsonModel.h"
#import "RemoveScheduleApiJsonModel.h"
#import "GarageDetailVC.h"

@interface M03_HistoryVC : MCBaseVC<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lichhenLabel;
@property (weak, nonatomic) IBOutlet UIView *gachchanLichHenView;
@property (weak, nonatomic) IBOutlet UILabel *lichSuHoatDongLabel;
@property (weak, nonatomic) IBOutlet UIView *gachChanLichSuView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
