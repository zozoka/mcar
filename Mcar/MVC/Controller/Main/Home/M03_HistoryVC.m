//
//  M03_HistoryVC.m
//  Mcar
//
//  Created by thanh tung on 9/20/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "M03_HistoryVC.h"

@interface M03_HistoryVC ()

@end

BOOL isHistory;

@implementation M03_HistoryVC
NSArray *arrDataHistory;
NSMutableArray *arrScheduleHistory;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadDataSchedule];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - network
-(void)loadDataHistory{
    
    NSDictionary *param = @{@"api_token":self.session.uniqueToken};
    [self.networkManager requestGetHistory:param comletion:^(NSDictionary *responseDict) {
        NSError *error;
        HistoryApiJsonModel *historyApiJsonModel = [[HistoryApiJsonModel alloc]initWithDictionary:responseDict error:&error];
        arrDataHistory = historyApiJsonModel.data;
        [self.tableView reloadData];
    }];
}

-(void)loadDataSchedule{
    NSDictionary *param = @{@"api_token":self.session.uniqueToken};
    [self.networkManager requestGetHistorySchedule:param comletion:^(NSDictionary *responseDict) {
        NSError *error;
        HistoryScheduleApiJsonModel *historyScheduleApiJsonModel = [[HistoryScheduleApiJsonModel alloc] initWithDictionary:responseDict error:&error];
        NSArray *dataTemp = historyScheduleApiJsonModel.data;
        arrScheduleHistory = [[NSMutableArray alloc] init];
        for (int i = 0; i<dataTemp.count; i++) {
            HistoryScheduleJsonModel *historyTemp = [[HistoryScheduleJsonModel alloc] initWithDictionary:dataTemp[i] error:nil];
            if ([historyTemp.status intValue] != 2) {
                [arrScheduleHistory addObject:historyTemp];
            }
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - configUI
-(void)configUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ScheduleVC" bundle:nil] forCellReuseIdentifier:@"ScheduleVC"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HistoryCell" bundle:nil] forCellReuseIdentifier:@"HistoryCell"];
    isHistory = NO;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - uitableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isHistory) {
        return arrDataHistory.count;
    }else{
        return arrScheduleHistory.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!isHistory) {
        return 135;
    }else{
        return 60;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!isHistory) {
        
        static NSString *cellIdentifier = @"ScheduleVC";
        ScheduleVC *cell = (ScheduleVC *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = [[ScheduleVC alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.removeScheduleView.layer.cornerRadius = 5.f;
        cell.directView.layer.cornerRadius = 5.f;
        HistoryScheduleJsonModel *scheduleJsonModel = arrScheduleHistory[indexPath.row];
        //HistoryScheduleJsonModel *scheduleJsonModel = arrScheduleHistory[indexPath.row];
        cell.titleGarageScheduleLabel.text = scheduleJsonModel.garage.name;
        cell.addressLabel.text = [NSString stringWithFormat:@"Địa chỉ: %@",scheduleJsonModel.garage.address];
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [[NSDate alloc]init];
        date = [dateFormatter dateFromString:scheduleJsonModel.date];
        NSDateFormatter *dateFormatterOut= [[NSDateFormatter alloc] init];
        [dateFormatterOut setDateFormat:@"dd/MM/yyyy"];
        
        NSDateFormatter *timeFormatter= [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"HH:mm:ss"];
        NSDateFormatter *timeOutFormatter = [[NSDateFormatter alloc] init];
        [timeOutFormatter setDateFormat:@"HH:mm"];
        NSDate *timeOutDate = [[NSDate alloc]init];
        timeOutDate = [timeFormatter dateFromString:scheduleJsonModel.time_start];
        
        NSString *dateString =[NSString stringWithFormat:@"%@ ngày %@",[timeOutFormatter stringFromDate:timeOutDate],[dateFormatterOut stringFromDate:date]];
        cell.dateTimeLabel.text = dateString;
        [cell.garageImageView setImageWithURL:[NSURL URLWithString:scheduleJsonModel.garage.avatar] placeholderImage:[UIImage imageNamed:@"m03-icon-avatar-diadiem.png"]];
        cell.directMapButton.tag = indexPath.row;
        [cell.directMapButton addTarget:self action:@selector(directMapButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        cell.removeScheduleButton.tag = indexPath.row;
        [cell.removeScheduleButton addTarget:self action:@selector(removeScheduleButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        static NSString *cellIdentifier = @"HistoryCell";
        HistoryCell *cell = (HistoryCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = [[HistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        NSError *error;
        HistoryJsonModel *historyJsonModel = [[HistoryJsonModel alloc]initWithDictionary:arrDataHistory[indexPath.row] error:&error];
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        NSDateFormatter *dateFormatter2=[[NSDateFormatter alloc] init];
        NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE"];
        [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateFormatter3 setDateFormat:@"dd/MM/yyyy"];
        NSDate *date = [[NSDate alloc]init];
        date = [dateFormatter2 dateFromString:historyJsonModel.created_at];
        NSString * dateString = [dateFormatter stringFromDate:date];
        cell.dateLabel.text = dateString;
        cell.dateTimeLabel.text = [dateFormatter3 stringFromDate:date];
        if ([historyJsonModel.action isEqualToString:@"book"]) {
            NSString *contentStr = [NSString stringWithFormat:@"Đặt lịch hẹn đến %@",historyJsonModel.garage.name];
            cell.contentLabel.text =contentStr;
        }else{
            NSString *contentStr = [NSString stringWithFormat:@"Gọi điện đến %@",historyJsonModel.garage.name];
            cell.contentLabel.text =contentStr;
        }
        
        return cell;
    }
}

#pragma mark -IBAction

- (IBAction)segmentedTap:(UISegmentedControl *)sender {
    NSInteger selectedSegment = sender.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        self.lichhenLabel.textColor = [[MCGlobal shareGlobal] colorFromHexString:@"#ed3141"];
        self.gachchanLichHenView.backgroundColor = [[MCGlobal shareGlobal] colorFromHexString:@"#ed3141"];
        self.lichSuHoatDongLabel.textColor = [[MCGlobal shareGlobal] colorFromHexString:@"#414141"];
        self.gachChanLichSuView.backgroundColor = [UIColor clearColor];
        isHistory = NO;
        [self loadDataSchedule];
    }
    else{
        self.lichhenLabel.textColor = [[MCGlobal shareGlobal] colorFromHexString:@"#414141"];
        self.gachchanLichHenView.backgroundColor = [UIColor clearColor];
        self.lichSuHoatDongLabel.textColor = [[MCGlobal shareGlobal] colorFromHexString:@"#ed3141"];
        self.gachChanLichSuView.backgroundColor = [[MCGlobal shareGlobal] colorFromHexString:@"#ed3141"];
        isHistory = YES;
        [self loadDataHistory];
        [self.tableView reloadData];

    }
}

- (void)directMapButtonTap:(UIButton*)sender{
    NSInteger index = sender.tag;

    HistoryScheduleJsonModel *scheduleJsonModel = arrScheduleHistory[index];
    
    GarageDetailVC *garageDetail = [[GarageDetailVC alloc]init];
    garageDetail.garageID = scheduleJsonModel.garage_id;
    //garageDetail.distanceStr = distanceString;
    garageDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:garageDetail animated:YES];
}

- (void)removeScheduleButtonTap:(UIButton*)sender{
    
    NSInteger index = sender.tag;
    HistoryScheduleJsonModel *scheduleJsonModel = arrScheduleHistory[index];
    
    NSString *mess = [NSString stringWithFormat:@"Bạn có chắc chắn muốn huỷ lịch hẹn đến %@ không?",scheduleJsonModel.garage.name];
    [[MCGlobal shareGlobal]showMessage:mess inView:self action:^{
        NSDictionary *param = @{@"api_token":self.session.uniqueToken};
        [self.networkManager requestRemoveSchedule:scheduleJsonModel.historyScheduleId parameter:param comletion:^(NSDictionary *responseDict) {
            NSError *error;
            RemoveScheduleApiJsonModel *removeScheduleApiJsonModel = [[RemoveScheduleApiJsonModel alloc]initWithDictionary:responseDict error:&error];
            if ([removeScheduleApiJsonModel.status intValue] == 1) {
                [self loadDataSchedule];
            }
        }];
    }];
}
@end
