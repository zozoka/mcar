//
//  ScheduleDoneVC.m
//  Mcar
//
//  Created by thanh tung on 11/10/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//
#import "ScheduleDoneVC.h"


@interface ScheduleDoneVC ()

@end

@implementation ScheduleDoneVC
BOOL otherChosseTap;
NSMutableArray *choseServiceArr;
NSInteger numberOfRow;
NSString *dateString;
NSString *timeString;
NSDateFormatter *dateStringFormatter;
NSDateFormatter *timeStringFormatter;
NSDateFormatter *dateFormatter;

- (void)viewDidLoad {
    [super viewDidLoad];
    choseServiceArr = [[NSMutableArray alloc] init];
    self.arrData = self.garageDetailJsonModel.garage_services;
    // Do any additional setup after loading the view from its nib.
    otherChosseTap = NO;
    [self configUI];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm - EE,dd/MM/yyyy"];
    self.dateTimeLabel.text = [dateFormatter stringFromDate:self.dataPicker.date];
    
    dateStringFormatter = [[NSDateFormatter alloc] init];
    [dateStringFormatter setDateFormat:@"yyyy-MM-dd"];
    timeStringFormatter = [[NSDateFormatter alloc] init];
    [timeStringFormatter setDateFormat:@"HH:mm:ss"];
    dateString = [dateStringFormatter stringFromDate:self.dataPicker.date];
    timeString = [timeStringFormatter stringFromDate:self.dataPicker.date];
}

#pragma mark - UI
- (void)configUI{
    self.confirmButton.layer.cornerRadius = 5;
    self.confirmButton.layer.masksToBounds = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
     [self.tableView registerNib:[UINib nibWithNibName:@"ScheduleDoneTopCell" bundle:nil] forCellReuseIdentifier:@"ScheduleDoneTopCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ScheduleDataPickerCell" bundle:nil] forCellReuseIdentifier:@"ScheduleDataPickerCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ScheduleListServicesCell" bundle:nil] forCellReuseIdentifier:@"ScheduleListServicesCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CheckListServiceCell" bundle:nil] forCellReuseIdentifier:@"CheckListServiceCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ScheduleTextViewCell" bundle:nil] forCellReuseIdentifier:@"ScheduleTextViewCell"];
    self.heightContentViewTable.constant = 40 * self.arrData.count;
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.borderColor = [UIColor grayColor].CGColor;
    self.textView.layer.borderWidth = 0.5;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    self.heightTextViewConstraint.constant = 0.0;
    self.textView.placeholder = @"Yêu cầu thêm (không bắt buộc)...";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier1 = @"CheckListServiceCell";
    CheckListServiceCell *cell = (CheckListServiceCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (!cell)
    {
        cell = [[CheckListServiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GarageServicesJsonModel * serviceJson = [[GarageServicesJsonModel alloc] initWithDictionary:self.arrData[indexPath.row] error:nil];
    cell.serviceLabel.text = serviceJson.name;
    
    if (choseServiceArr.count == 0) {
        cell.iconImageView.image = [UIImage imageNamed:@"m05-2-icon-unselect.png"];
    }else{
        for (int i = 0; i < choseServiceArr.count; i++) {
            GarageServicesJsonModel * serviceJsonTemp = choseServiceArr[i];
            if ([serviceJson.idService intValue] == [serviceJsonTemp.idService intValue]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.iconImageView.image = [UIImage imageNamed:@"m05-2-icon-selected.png"];
                    [tableView layoutIfNeeded];
                });
                
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.iconImageView.image = [UIImage imageNamed:@"m05-2-icon-unselect.png"];
                    [tableView layoutIfNeeded];
                });
            }
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GarageServicesJsonModel * serviceJson = [[GarageServicesJsonModel alloc] initWithDictionary:self.arrData[indexPath.row] error:nil];
    if (choseServiceArr.count == 0) {
        [choseServiceArr addObject:serviceJson];

    }else{
        for (int i = 0; i < choseServiceArr.count; i++) {
            GarageServicesJsonModel * serviceJsonTemp = choseServiceArr[i];
            if ([serviceJson.idService intValue] == [serviceJsonTemp.idService intValue]) {
                [choseServiceArr removeObjectAtIndex:i];
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                return;
            }
        }
        [choseServiceArr addObject:serviceJson];
    }
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)keyboardOnScreen:(NSNotification *)notification
{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];

    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    self.heightBottomView.constant = keyboardFrame.size.height;
    NSLog(@"keyboardFrame: %@", NSStringFromCGRect(keyboardFrame));
    
    CGPoint offset = self.scrollView.contentOffset;
    CGFloat scrollViewHeight = self.scrollView.frame.size.height - keyboardFrame.size.height;
    offset.y = self.scrollView.contentSize.height - scrollViewHeight;
    [self.scrollView setContentOffset:offset animated:YES];
}

-(void)keyboardHidden:(NSNotification *)notification{
    self.heightBottomView.constant = 0.0;
}

- (IBAction)confirmButtonTap:(UIButton *)sender {
    NSString *additionalString;
    if (otherChosseTap) {
        if (self.textView.text.length != 0) {
            additionalString = self.textView.text;
        }else{
            additionalString = @"";
        }
    }else{
        additionalString = @"";
    }
    if (choseServiceArr.count == 0 && !otherChosseTap) {
        [[MCGlobal shareGlobal] showMessage:@"bạn cần chọn ít nhất một dịch vụ" inView:self];
        return;
    }
    
    if (dateString == nil || timeString == nil) {
        [[MCGlobal shareGlobal] showMessage:@"Bạn phải chọn thời gian đặt hẹn" inView:self];
        return;
    }
    NSMutableArray *arrServiceIds = [[NSMutableArray alloc]init];
    for (GarageServicesJsonModel *serviceObject in choseServiceArr) {
        NSDictionary *objTemp = @{@"id":serviceObject.idService};
        [arrServiceIds addObject:objTemp];
    }
    
    NSDictionary *param;
    
    if (otherChosseTap && arrServiceIds.count == 0) {
        param = @{@"api_token":self.session.uniqueToken,
                  @"user_car_id":self.session.user_car_id,
                  @"date":dateString,
                  @"time_start":timeString,
                  @"time_end":@"00:00:00",
                  @"garage_services":@{@"id":@0},
                  @"additional_request":additionalString
                  };
    }else{
        param = @{@"api_token":self.session.uniqueToken,
                  @"user_car_id":self.session.user_car_id,
                  @"date":dateString,
                  @"time_start":timeString,
                  @"time_end":@"00:00:00",
                  @"garage_services":arrServiceIds,
                  @"additional_request":additionalString
                  };
    }
    
    [self.networkManager PostBookingGarage:param andIdGara:self.garageDetailJsonModel.idGarage comletion:^(NSDictionary *responseDict) {
        ResponseBookingJsonModel *response = [[ResponseBookingJsonModel alloc] initWithDictionary:responseDict error:nil];
        if ([response.status intValue] == 1) {
            NSString *mess = [NSString stringWithFormat:@"Yêu cầu đặt hẹn của bạn đã được gửi đến %@",self.garageDetailJsonModel.name];
            
            [[MCGlobal shareGlobal] showMessage:mess inView:self action:^{
                [self.tabBarController setSelectedIndex:2];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
            
        }else{
            [[MCGlobal shareGlobal] showMessage:@"Có lỗi trong quá trình xử lý. mời bạn thử lại sau." inView:self];
        }
    }];
}

- (IBAction)datePickerChanged:(UIDatePicker *)sender {
    NSDate *dateChosse = [sender date];

    self.dateTimeLabel.text = [dateFormatter stringFromDate:dateChosse];
    
    
    dateString = [dateStringFormatter stringFromDate:dateChosse];
    timeString = [timeStringFormatter stringFromDate:dateChosse];
}

- (IBAction)backButtonTap:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)otherButtonTap:(UIButton *)sender {
    if (!otherChosseTap) {
        otherChosseTap = YES;
        self.noteImgView.image = [UIImage imageNamed:@"m05-2-icon-selected.png"];
        self.heightTextViewConstraint.constant = 120.0;
        CGPoint offset = self.scrollView.contentOffset;
        CGFloat scrollViewHeight = self.scrollView.frame.size.height - 120.0;
        offset.y = self.scrollView.contentSize.height - scrollViewHeight;
        [self.scrollView setContentOffset:offset animated:YES];
    }else{
        otherChosseTap = NO;
        self.noteImgView.image = [UIImage imageNamed:@"m05-2-icon-unselect.png"];
        [self.textView endEditing:YES];
        [UIView animateWithDuration:0.5 animations:^{
            self.heightTextViewConstraint.constant = 120.0;
        } completion:^(BOOL finished) {
            self.heightTextViewConstraint.constant = 0.0;
        }];
    }
}


@end
