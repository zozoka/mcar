//
//  ScheduleVC_M05.m
//  Mcar
//
//  Created by thanh tung on 11/6/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "ScheduleVC_M05.h"

@interface ScheduleVC_M05 ()

@end

@implementation ScheduleVC_M05
NSArray *arrDataCar;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadCarsOfUser];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardDidHideNotification object:nil];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UI
- (void)configUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.arrData = [[NSArray alloc]init];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"TopCell_M05" bundle:nil] forCellReuseIdentifier:@"TopCell_M05"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MidCell_M05" bundle:nil] forCellReuseIdentifier:@"MidCell_M05"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BottomCell_M05" bundle:nil] forCellReuseIdentifier:@"BottomCell_M05"];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}

#pragma mark - Network
- (void)loadCarsOfUser{
    
    NSDictionary *param = @{@"api_token" : self.session.uniqueToken};
    [self.networkManager requestGetCarsOfUSer:param comletion:^(NSDictionary *responseDict) {
        NSError *error;
        self.apiCarJson = [[ApiGetAllCarOfUserJsonModel alloc] initWithDictionary:responseDict error:&error];
        arrDataCar = self.apiCarJson.data;
        
//        CarJsonModel *carJson = [[CarJsonModel alloc] initWithDictionary:arrDataCar[0] error:nil];
//        //arrDataCar[0];
//        NSLog(@"%@",carJson.name);
        
        if (arrDataCar.count >0) {
            if ([self.session.userCarName isEqualToString:@""] || self.session.userCarName.length == 0 || self.session.userCarName == nil) {
                CarJsonModel *carJson = [[CarJsonModel alloc] initWithDictionary:arrDataCar[0] error:&error]; ;
                self.session.userCarName = carJson.name;
                self.session.yearOfManufactureCar = carJson.manufacture_year;
                self.session.carNumber = carJson.car_number;
                self.session.user_car_id = carJson.idCar;
                [self.session save];
                [self.tableView reloadData];
            }
        }
        
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TabelViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *cellIdentifier = @"TopCell_M05";
        TopCell_M05 *cell = (TopCell_M05 *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = [[TopCell_M05 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        NSArray *imageArray = self.garageDetailJson.images;
        
        float widthImage = [UIScreen mainScreen].bounds.size.width;
        float heightImage = cell.scrollView.bounds.size.height;
        NSInteger imageNumber = imageArray.count;
        
        cell.scrollView.pagingEnabled = YES;
        cell.pageControl.numberOfPages = imageNumber;
        cell.pageControl.backgroundColor = [UIColor clearColor];
        if (imageArray.count == 0) {
            cell.scrollView.contentSize = CGSizeMake(widthImage, heightImage);
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(0, 0, widthImage, heightImage);
            imageView.image =  [UIImage imageNamed:@"m11-imageThumb.png"];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [cell.scrollView addSubview:imageView];
        }else{
            cell.scrollView.contentSize = CGSizeMake(widthImage * imageNumber, heightImage);
            for (int i = 0; i < imageNumber ; i++) {
                NSError *error;
                ImagesJsonModel *imageJson = [[ImagesJsonModel alloc]initWithDictionary:imageArray[i] error:&error];
                NSString * fileName = imageJson.name;
                UIImageView *imageView = [[UIImageView alloc] init];
                [imageView setImageWithURL:[NSURL URLWithString:fileName] placeholderImage:[UIImage imageNamed:@"m11-imageThumb.png"]];
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                imageView.frame = CGRectMake(i*widthImage, 0, widthImage, heightImage);
                [cell.scrollView addSubview:imageView];
            }
        }
        cell.nameGarageLabel.text = self.garageDetailJson.name;
        cell.addressLabel.text = self.garageDetailJson.address;
        cell.phoneLabel.text = self.garageDetailJson.phone;
        cell.descriptionLabel.text = self.garageDetailJson.referral_information;
        return cell;
    }else if (indexPath.row == 1){
        static NSString *cellIdentifier = @"MidCell_M05";
        MidCell_M05 *cell = (MidCell_M05 *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = [[MidCell_M05 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        [cell.editButton addTarget:self action:@selector(editInfoUser:) forControlEvents:UIControlEventTouchUpInside];
        if (self.session.userFullName == nil || [self.session.userFullName isEqualToString:@""] || self.session.userFullName.length == 0 || [self.session.userFullName isEqualToString:@"nil"]) {
            cell.userNameLabel.text = @"Chưa cập nhật";
        }else{
            cell.userNameLabel.text = self.session.userFullName;
        }
        
        if (self.session.userPhone == nil || [self.session.userPhone isEqualToString:@""] || self.session.userPhone.length == 0 || [self.session.userPhone isEqualToString:@"nil"]) {
            cell.phoneNumberLabel.text = @"Chưa cập nhật";
        }else{
            cell.phoneNumberLabel.text = self.session.userPhone;
        }
        if (self.session.userEmail == nil || [self.session.userEmail isEqualToString:@""] || self.session.userEmail.length == 0 || [self.session.userEmail isEqualToString:@"nil"]) {
            cell.emailLabel.text = @"Chưa cập nhật";
        }else{
            cell.emailLabel.text = self.session.userEmail;
        }
        
        return cell;
    }else{
        static NSString *cellIdentifier = @"BottomCell_M05";
        BottomCell_M05 *cell = (BottomCell_M05 *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = [[BottomCell_M05 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (self.session.userCarName == nil || [self.session.userCarName isEqualToString:@""] || [self.session.userCarName isEqualToString:@"nil"]) {
            cell.nameCar.text = @"Chưa cập nhật";
        }else{
            cell.nameCar.text = self.session.userCarName;
        }
        
        if (self.session.yearOfManufactureCar == nil || [self.session.yearOfManufactureCar isEqualToString:@""] || [self.session.yearOfManufactureCar isEqualToString:@"nil"]) {
            cell.dateLabel.text = @"Chưa cập nhật";
        }else{
            cell.dateLabel.text = self.session.yearOfManufactureCar;
        }
        
        if (self.session.carNumber == nil || [self.session.carNumber isEqualToString:@""] || [self.session.carNumber isEqualToString:@"nil"]) {
            cell.iDCarLabel.text = @"Chưa cập nhật";
        }else{
            cell.iDCarLabel.text = self.session.carNumber;
        }
        
        [cell.editButton addTarget:self action:@selector(editCarButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }

}



#pragma mark NotifyCenter
-(void)keyboardOnScreen:(NSNotification *)notification
{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    self.heightControlBottomView.constant = keyboardFrame.size.height;
    NSLog(@"keyboardFrame: %@", NSStringFromCGRect(keyboardFrame));
}

-(void)keyboardHidden:(NSNotification *)notification{
    self.heightControlBottomView.constant = 0.0;
}


#pragma mark - PickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.apiCarJson.data.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    CarJsonModel *carJson = [[CarJsonModel alloc] initWithDictionary:arrDataCar[row] error:nil];
    NSString *nameCarStr = [NSString stringWithFormat:@"%@ %@",carJson.brand.name,carJson.name];
    return nameCarStr;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    CarJsonModel *carJson = [[CarJsonModel alloc] initWithDictionary:arrDataCar[row] error:nil];
    NSString *nameCarStr = [NSString stringWithFormat:@"%@ %@",carJson.brand.name,carJson.name];
    self.session.userCarName = nameCarStr;
    self.session.yearOfManufactureCar = carJson.manufacture_year;
    self.session.carNumber = carJson.car_number;
    self.session.user_car_id = carJson.idCar;
    [self.session save];
    [self.tableView reloadData];
}
#pragma mark - IBAction
- (IBAction)backButtonTap:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)editCarButtonTap:(UIButton *)sender{
    [self.choseCarView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
    [self.view addSubview:self.choseCarView];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.choseCarView setFrame:self.view.frame];
    } completion:^(BOOL finished) {
        self.backBackgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    }];
}
- (IBAction)choseCarDoneButtonTap:(UIButton *)sender {
    self.backBackgroundView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.5 animations:^{
        [self.choseCarView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
        
    }completion:^(BOOL finished) {
        [self.choseCarView removeFromSuperview];
    }];
}

- (void)editInfoUser:(UIButton*)sender{
    EditInfoUserVC_M05 *editUserVC = [[EditInfoUserVC_M05 alloc] init];
    [self.navigationController pushViewController:editUserVC animated:YES];
}

- (IBAction)nextButtonTap:(UIButton *)sender {
    ScheduleDoneVC *scheduleDoneVC = [[ScheduleDoneVC alloc] init];
    scheduleDoneVC.garageDetailJsonModel = self.garageDetailJson;
    [self.navigationController pushViewController:scheduleDoneVC animated:YES];
    
}

@end
