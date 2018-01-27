//
//  GarageDetailVC.m
//  Mcar
//
//  Created by thanh tung on 10/9/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "GarageDetailVC.h"
@interface GarageDetailVC ()

@end
@implementation GarageDetailVC
NSArray *arrComment;
NSArray *arrServices;
NSArray *arrPromotions;
NSArray *arrCarBrands;
BOOL liked;
GarageDetailJsonModel *garageDetailModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    [self configUI];
    //[self loadDataJson];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadDataJson];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark getDataFromJson
- (void)loadDataJson{
    NSDictionary * param = @{@"api_token":self.session.uniqueToken};
    [self.networkManager requestGetDetailGarage:[self.garageID intValue] param:param comletion:^(NSDictionary *responseDict) {
        NSError *error;
        GarageDetailApiJsonModel *garageDetailApiJson = [[GarageDetailApiJsonModel alloc]initWithDictionary:responseDict error:&error];
        garageDetailModel = garageDetailApiJson.data;
        arrComment = garageDetailModel.comments;
        arrServices = garageDetailModel.garage_services;
        arrPromotions = garageDetailModel.promotions;
        arrCarBrands = garageDetailModel.car_brands;
        self.titleGarageLabel.text = garageDetailModel.name;
        [self.tableView reloadData];
        [self.promotionTableView reloadData];
        [self.serviceTableView reloadData];
        if ([garageDetailModel.bookmarked intValue] == 1) {
            self.likeImageView.image = [UIImage imageNamed:@"m11-icon-liked.png"];
        }else{
            self.likeImageView.image = [UIImage imageNamed:@"m00-icon-yeuthich-white.png"];
        }
    }];
}


#pragma mark UIconfig
- (void)configUI{
    self.viewComment.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
}
- (void)configTableView{
    //self.tableView.estimatedRowHeight = 80;
    self.tableView.tag = 1;
    self.serviceTableView.tag = 2;
    self.promotionTableView.tag = 3;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"TopCell" bundle:nil] forCellReuseIdentifier:@"TopCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:@"CommentCell"];
    [self.serviceTableView registerNib:[UINib nibWithNibName:@"ServiceCell" bundle:nil] forCellReuseIdentifier:@"ServiceCell"];
    [self.serviceTableView registerNib:[UINib nibWithNibName:@"CarBrandCell" bundle:nil] forCellReuseIdentifier:@"CarBrandCell"];
    [self.promotionTableView registerNib:[UINib nibWithNibName:@"PromotionCell" bundle:nil] forCellReuseIdentifier:@"PromotionCell"];
    
    
    self.serviceTableView.delegate = self;
    self.serviceTableView.dataSource = self;
    self.promotionTableView.delegate = self;
    self.promotionTableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

//- (void)setupSlideImageWithNumberImage:(int)imageNumber{
//    //config scrollview slide image
//    self.scrollView.delegate = self;
//    self.scrollView.backgroundColor = [UIColor clearColor];
//    CGSize size = [UIScreen mainScreen].bounds.size;
//    //NSLog(@"size: %f-%f",size.width,size.height);
//    widthImage = size.width;
//    heightImage = size.height;
//    self.scrollView.contentSize = CGSizeMake(widthImage * imageNumber, 200);
//    self.scrollView.pagingEnabled = YES;
//    self.pageControl.numberOfPages = imageNumber;
//    self.pageControl.backgroundColor = [UIColor clearColor];
//    for (int i = 0; i < imageNumber ; i++) {
//        NSString * fileName = @"m11-thumb.png";
//        UIImage *image = [UIImage imageNamed:fileName];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        imageView.frame = CGRectMake(i*widthImage, 0, widthImage, 200);
//        [self.scrollView addSubview:imageView];
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark tableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == 1) {
        return 1;
    }else if (tableView.tag == 2){
        //service table
        return 2;
    }else if (tableView.tag == 3){
        //promotion table
        return 1;
    }else{
        return 1;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 1) {
        return 1+arrComment.count;
    }else if(tableView.tag == 2){
        //service table
        if (section == 0){
            return arrServices.count;
        }else{
            if(arrCarBrands.count%3 == 0){
                return arrCarBrands.count/3;
            }else{
                return arrCarBrands.count/3 + 1;
            }
        }
    }else if(tableView.tag == 3){
        //promotion table
        return arrPromotions.count;
    }else{
        return 0;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return UITableViewAutomaticDimension;
    }else{
        return UITableViewAutomaticDimension;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 2) {
        return 30;
    }else{
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 2) {
        if (section ==  0) {
            if (arrServices.count == 0) {
                self.titleSectionDichVuLabel.text = @"Dịch vụ đang chờ cập nhật";
            }else{
                self.titleSectionDichVuLabel.text = @"Dịch vụ";
            }
            //return @"Dịch vụ";
            return self.sectionDichVuView;
        }else{
            if (arrCarBrands.count == 0) {
                self.hearderTitleTableViewLabel.text = @"Các dòng xe hỗ trợ đang chờ cập nhật";
            }else{
                self.hearderTitleTableViewLabel.text = @"Các dòng xe hỗ trợ";
            }
            return self.headerView;
        }
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1) {
        if (indexPath.row == 0) {
            return UITableViewAutomaticDimension;
        }else{
            return UITableViewAutomaticDimension;
        }
    }else if (tableView.tag == 2){
        return 40;
    }else if (tableView.tag == 3){
        return 100;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1) {
        if (indexPath.row ==0) {
            static NSString *cellIdentifier1 = @"TopCell";
            TopCell *cell = (TopCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            if (!cell)
            {
                cell = [[TopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
                //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //cell.scrollView.delegate = self;
            cell.scrollView.backgroundColor = [UIColor clearColor];
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.mapView clear];
                GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[garageDetailModel.latitude floatValue]
                                                                        longitude:[garageDetailModel.longitude floatValue]
                                                                             zoom:17];
                cell.mapView.camera = camera;
                GMSMarker *marker = [[GMSMarker alloc] init];
                CLLocationCoordinate2D position = CLLocationCoordinate2DMake([garageDetailModel.latitude floatValue],[garageDetailModel.longitude floatValue]);
                marker.position = position;
                UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 28)];
                iconView.image = [UIImage imageNamed:@"logo-mcar-maps.png"];
                marker.iconView = iconView;
                marker.appearAnimation = kGMSMarkerAnimationPop;
                marker.map = cell.mapView;
                marker.opacity = 1;
                cell.mapView.settings.scrollGestures = NO;
            });
            cell.countCommentLabel.text = [NSString stringWithFormat:@"%lu",arrComment.count] ;
            cell.countServiceLabel.text = [NSString stringWithFormat:@"%lu", garageDetailModel.garage_services.count];
            cell.countBookingLabel.text =[NSString stringWithFormat:@"%d",[garageDetailModel.booking_total intValue]];
            cell.ratingPointLabel.text = [NSString stringWithFormat:@"%0.1f",[garageDetailModel.rating floatValue]];
            // check time open or close
            
            NSArray *arrTimeOpen = garageDetailModel.opentimes;
            if (arrTimeOpen.count >0) {
                NSError *error;
                OpentimesJsonModel *openTimeJsonModel = [[OpentimesJsonModel alloc]initWithDictionary:arrTimeOpen[0] error:&error];
                NSScanner* timeScannerOpen = [NSScanner scannerWithString:openTimeJsonModel.time_start];
                int hoursOpen,minutesOpen,secondOpen;
                [timeScannerOpen scanInt:&hoursOpen];
                [timeScannerOpen scanString:@":" intoString:nil]; //jump over :
                [timeScannerOpen scanInt:&minutesOpen];
                [timeScannerOpen scanString:@":" intoString:nil];
                [timeScannerOpen scanInt:&secondOpen];
                
                NSScanner *timeScannerClose = [NSScanner scannerWithString:openTimeJsonModel.time_end];
                int hoursClose,minuteClose,secondClose;
                [timeScannerClose scanInt:&hoursClose];
                [timeScannerClose scanString:@":" intoString:nil];
                [timeScannerClose scanInt:&minuteClose];
                [timeScannerClose scanString:@":" intoString:nil];
                [timeScannerClose scanInt:&secondClose];
                
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
                NSInteger currentHour = [components hour];
                NSInteger currentMinute = [components minute];
                NSInteger currentSecond = [components second];
                
                if ((currentHour > hoursOpen && currentHour < hoursClose) ||  (currentHour == hoursClose && currentMinute < minuteClose)
                    || (currentHour == hoursClose && currentMinute == minuteClose && currentSecond == secondClose)
                    || (currentHour == hoursOpen && (currentMinute > minutesOpen || currentSecond >secondOpen))) {
                    cell.timeStatusLabel.text = @"Đang mở cửa";
                    cell.timeStatusLabel.textColor = [UIColor greenColor];
                }else{
                    cell.timeStatusLabel.text = @"Đang đóng cửa";
                    cell.timeStatusLabel.textColor = [UIColor grayColor];
                }
                
                cell.timeLabel.text = [NSString stringWithFormat:@"%d:%d - %d:%d",hoursOpen,minutesOpen,hoursClose,minuteClose];
            }
            
            
           
            cell.garageNameLabel.text = garageDetailModel.name;
            cell.addressLabel.text = garageDetailModel.address;
            cell.distanceLabel.text = self.distanceStr;
            cell.descriptionLabel.text = garageDetailModel.referral_information;
            NSMutableString *textPromotion = [[NSMutableString alloc]init];
            NSArray *arrPromotion = garageDetailModel.promotions;
            if(arrPromotion.count == 0){
                cell.servicesLabel.text = @"Chưa có chương trình khuyến mãi";
            }else{
                for (int i = 0; i < arrPromotion.count; i++) {
                    NSError *error;
                    PromotionsJsonModel *promotionJson = [[PromotionsJsonModel alloc]initWithDictionary:arrPromotion[i] error:&error];
                    if (i == 0) {
                        [textPromotion appendString:[NSString stringWithFormat:@"- %@", promotionJson.title]];
                    }else{
                        [textPromotion appendString:[NSString stringWithFormat:@"\n- %@", promotionJson.title]];
                    }
                }
                cell.servicesLabel.text = textPromotion;
            }
            if (arrComment.count == 0) {
                cell.countCmLabel.text = @"Chưa có bình luận nào";
            }else{
                cell.countCmLabel.text = [NSString stringWithFormat:@"%lu bình luận",arrComment.count];
            }
            NSArray *imageArray = garageDetailModel.images;
            
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
            NSLog(@"with image: %f - height image: %f",widthImage,heightImage);
            
            [cell.callButton addTarget:self action:@selector(callButtonTap) forControlEvents:UIControlEventTouchUpInside];
            [cell.buttonXemThem addTarget:self action:@selector(buttonXemThemTap) forControlEvents:UIControlEventTouchUpInside];
            [cell.dichVuButton addTarget:self action:@selector(buttonServiceTap) forControlEvents:UIControlEventTouchUpInside];
            [cell.mapButton addTarget:self action:@selector(buttonMapTap) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{
            static NSString *cellIdentifier1 = @"CommentCell";
            CommentCell *cell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            if (!cell)
            {
                cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
                //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSError *error;
            CommentJsonModel *commentModel = [[CommentJsonModel alloc]initWithDictionary:arrComment[indexPath.row-1] error:&error];
            cell.commentLabel.text = commentModel.content;
            cell.userNameLabel.text = commentModel.user.name;
            [cell.avataImageView setImageWithURL:[NSURL URLWithString:commentModel.user.avatar] placeholderImage:[UIImage imageNamed:@"m01-avata.png"]];
            
            
            
            
            
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *dateComment = [[NSDate alloc]init];
            dateComment = [dateFormatter dateFromString:commentModel.created_at];

            
            
            cell.timeLabel.text = [[MCGlobal shareGlobal] timeAgoStringFromDate:dateComment];
            return cell;
        }
    }else if (tableView.tag == 2){
        if (indexPath.section == 0) {
            static NSString *cellIdentifier1 = @"ServiceCell";
            ServiceCell *cell = (ServiceCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            if (!cell)
            {
                cell = [[ServiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
                //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSError *error;
            GarageServicesJsonModel *serviceJson = [[GarageServicesJsonModel alloc]initWithDictionary:arrServices[indexPath.row] error:&error];
            cell.titleNameLabel.text = serviceJson.name;
            return cell;
        }else{
            static NSString *cellIdentifier1 = @"CarBrandCell";
            CarBrandCell *cell = (CarBrandCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            if (!cell)
            {
                cell = [[CarBrandCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
                //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
           
            NSInteger index = indexPath.row*3;
            if (index < arrCarBrands.count) {
                NSError *error;
               
                CarBrandsJsonModel *cardBrandJson = [[CarBrandsJsonModel alloc]initWithDictionary:arrCarBrands[index] error:&error];
                cell.labelTitle1.text = cardBrandJson.name;
            }
            if (index+1 < arrCarBrands.count){
                //cell.labelTitle2.text = arrCarBrands[i+1];
                NSError *error;
                NSLog(@"index i+1 : %ld",index+1);
                CarBrandsJsonModel *cardBrandJson = [[CarBrandsJsonModel alloc]initWithDictionary:arrCarBrands[index+1] error:&error];
                cell.labelTitle2.text = cardBrandJson.name;
            }
            if (index+2 < arrCarBrands.count) {
                //cell.labelTitle3.text = arrCarBrands[i+2];
                NSError *error;
                NSLog(@"index i+2 : %ld",index+2);
                CarBrandsJsonModel *cardBrandJson = [[CarBrandsJsonModel alloc]initWithDictionary:arrCarBrands[index+2] error:&error];
                cell.labelTitle3.text = cardBrandJson.name;
            }
            
            return cell;
        }
        
    }else if (tableView.tag == 3){
        static NSString *cellIdentifier1 = @"PromotionCell";
        PromotionCell *cell = (PromotionCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (!cell)
        {
            cell = [[PromotionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSError *error;
        PromotionsJsonModel *promotionJson = [[PromotionsJsonModel alloc]initWithDictionary:arrPromotions[indexPath.row] error:&error];
        [cell.imageThumbView setImageWithURL:[NSURL URLWithString:promotionJson.image] placeholderImage:[UIImage imageNamed:@"m11-thumb.png"]];
        cell.titleLabel.text = promotionJson.title;
        cell.contentLabel.text = promotionJson.content;
        //date
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        NSDateFormatter *dateFormatterOut = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateFormatterOut setDateFormat:@"dd-MM-yyyy"];
        NSDate *dateStart = [[NSDate alloc]init];
        dateStart = [dateFormatter dateFromString:promotionJson.start];
        NSString * dateOpenString = [dateFormatterOut stringFromDate:dateStart];
        NSDate *dateClose = [[NSDate alloc]init];
        dateClose = [dateFormatter dateFromString:promotionJson.end];
        NSString *dateCloseString = [dateFormatterOut stringFromDate:dateClose];
        
        cell.dateTitle.text = [NSString stringWithFormat:@"%@ - %@",dateOpenString,dateCloseString];
        //
        
        return cell;
    }else{
        static NSString *CellIdentifier = @"Cell";
        // Reuse and create cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        return cell;
    }
}

#pragma mark IBACtion

//- (IBAction)onPageChange:(UIPageControl *)sender {
//    self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage*widthImage,0);
//}
- (IBAction)backButtonTap:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonMapTap{
    DirectGarageMapVC *directVC = [[DirectGarageMapVC alloc]init];
    directVC.garageModel = garageDetailModel;
    [self presentViewController:directVC animated:YES completion:nil];
//    MapVC *map = [[MapVC alloc]init];
//    [self.navigationController pushViewController:map animated:YES];
}

- (void)callButtonTap{
    if ([[MCGlobal shareGlobal] stringIsNilOrEmpty:garageDetailModel.phone]) {
        [[MCGlobal shareGlobal]showMessage:@"Số điện thoại chưa được cập nhật" inView:self];
    }else{
        NSString *urlString = [NSString stringWithFormat:@"tel://%@",[[MCGlobal shareGlobal] formatNumber:garageDetailModel.phone]];
        NSURL *URL = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:URL];
    }
}

-(void)buttonServiceTap{
    self.blackView.backgroundColor = [UIColor clearColor];
    self.detailServiceView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:self.detailServiceView];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.detailServiceView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
        self.blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    }];
}

- (IBAction)dismissViewButton:(UIButton *)sender {
    self.blackView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.5 animations:^{
        self.detailServiceView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

    }completion:^(BOOL finished) {
        [self.detailServiceView removeFromSuperview];
    }];
}
// chuong trinh khuyen mai

-(void)buttonXemThemTap{
    self.promotionBlackView.backgroundColor = [UIColor clearColor];
    self.promotionView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:self.promotionView];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.promotionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
        self.promotionBlackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    }];
}

- (IBAction)dismissViewPromotionButton:(id)sender {
    self.promotionBlackView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.5 animations:^{
        self.promotionView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }completion:^(BOOL finished) {
        [self.promotionView removeFromSuperview];
    }];
}
- (IBAction)commentButton:(UIButton *)sender {
    CommentVC *commentVc = [[CommentVC alloc]init];
    commentVc.garageJsonModel = garageDetailModel;
    [self.navigationController pushViewController:commentVc animated:YES];
}

- (IBAction)likeButtonTap:(UIButton *)sender {
    if (self.session.isAuthenticated) {
        if (liked) {
            //delete bookmark
            self.likeImageView.image = [UIImage imageNamed:@"m00-icon-yeuthich-white.png"];
            liked = NO;
        }else{
            NSDictionary *param = @{@"api_token":self.session.uniqueToken};
            [self.networkManager requestPostBookMark:self.garageID parameter:param comletion:^(NSDictionary *responseDict) {
                NSError *error;
                BookMarkApiJsonModel *bookmarkApiJsonModel = [[BookMarkApiJsonModel alloc]initWithDictionary:responseDict error:&error];
                if ([bookmarkApiJsonModel.status intValue] == 1) {
                    [[MCGlobal shareGlobal] showMessage:@"Đã thêm vào danh sách garage yêu thích của bạn." inView:self];
                    self.likeImageView.image = [UIImage imageNamed:@"m11-icon-liked.png"];
                    liked = YES;
                }
            }];
        }
    }else{
        LoginVC *loginVc = [[LoginVC alloc] init];
        [self presentViewController:loginVc animated:YES completion:^{
        }];
    }
}

- (IBAction)shareButtonTap:(UIButton *)sender {
    [[MCGlobal shareGlobal] ShareWithFriend:self andButtonSender:sender];
}
- (IBAction)ScheduleButtonTap:(UIButton *)sender {
    if (self.session.isAuthenticated) {
        ScheduleVC_M05 *scheduleVC = [[ScheduleVC_M05 alloc]init];
        scheduleVC.garageDetailJson = garageDetailModel;
        [self.navigationController pushViewController:scheduleVC animated:YES];
    }else{
        LoginVC *loginVc = [[LoginVC alloc] init];
        [self presentViewController:loginVc animated:YES completion:^{
            
        }];
    }
    
}

@end
