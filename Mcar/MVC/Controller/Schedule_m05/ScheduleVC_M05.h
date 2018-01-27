
//
//  ScheduleVC_M05.h
//  Mcar
//
//  Created by thanh tung on 11/6/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GarageDetailJsonModel.h"
#import "TopCell_M05.h"
#import "MidCell_M05.h"
#import "BottomCell_M05.h"
#import "MCBaseVC.h"
#import "ApiGetAllCarOfUserJsonModel.h"
#import "EditInfoUserVC_M05.h"
#import "ScheduleDoneVC.h"

@interface ScheduleVC_M05 : MCBaseVC<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) GarageDetailJsonModel *garageDetailJson;
@property(strong,nonatomic) NSArray *arrData;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightControlBottomView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UIView *choseCarView;
@property (weak, nonatomic) IBOutlet UIView *backBackgroundView;
@property (strong, nonatomic) ApiGetAllCarOfUserJsonModel *apiCarJson;
@end
