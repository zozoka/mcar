//
//  HomeVC.m
//  Mcar
//
//  Created by thanh tung on 9/18/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "HomeVC.h"
#import "AppDelegate.h"
@interface HomeVC ()

@end

@implementation HomeVC
NSMutableArray *marrData;
AppDelegate *appDelegate;
GarageApiJsonModel *garageApiJson;
listFilter filterby;
BOOL isSearchTap; // check user tap to search text box
BOOL isRequesting;// check status request search

#pragma mark cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    isSearchTap = NO;
    isRequesting = NO;
    self.tabBarController.delegate = self;
    marrData = [[NSMutableArray alloc] init];
//    [self configLocation];
    appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.locationManager.delegate = self;
    //NSLog(@"array location latitude: %f",appDelegate.myLocation.coordinate.latitude);
    self.navigationView.backgroundColor =[UIColor colorWithRed:237/255.0f green:47/255.0f blue:65/255.0f alpha:1.0f];
    self.viewSearch.layer.cornerRadius = 4.f;
    self.viewButtonCity.layer.cornerRadius = 4.f;
    [self setupTableview];
    // loading view config
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < 50 ; i ++) {
        NSString *nameImg = [NSString stringWithFormat:@"%d.png",i+1];
        UIImage *imageObj = [UIImage imageNamed:nameImg];
        [images addObject:imageObj];
    }
    self.loadingImageView.animationImages = images;
    self.loadingImageView.animationDuration = 3;
    [self.loadingImageView startAnimating];
    self.loadingView.frame = self.tableView.frame;
    [self.view addSubview:self.loadingView];
    self.searchTextFied.delegate = self;
    self.searchTextFied.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.cancelButton.layer.cornerRadius = 5;
    self.cancelButton.layer.masksToBounds = YES;
    [self.searchTextFied addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self loadDataGarageForTableView:NEAREST];
}

#pragma mark UI

//-(void)configLocation{
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.delegate = self;
//    locationManager.distanceFilter = kCLDistanceFilterNone;
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//
//    [locationManager requestWhenInUseAuthorization];
//    [locationManager startUpdatingLocation];
//
//    CLLocation *curPos = locationManager.location;
//
//    if (curPos.coordinate.latitude != 0 && curPos.coordinate.longitude != 0) {
//        myLatitude = curPos.coordinate.latitude;
//        myLongitude = curPos.coordinate.longitude;
//    }
//}

-(void)setupTableview{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GarageListCell" bundle:nil] forCellReuseIdentifier:@"GarageListCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MapCell" bundle:nil] forCellReuseIdentifier:@"MapCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuTabCell" bundle:nil] forCellReuseIdentifier:@"MenuTabCell"];
    
    [self.searchTableView registerNib:[UINib nibWithNibName:@"SearchCell" bundle:nil] forCellReuseIdentifier:@"SearchCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Network
- (void)loadDataGarageForTableView:(listFilter)filter andPage:(NSNumber*)page{
    if (isSearchTap) {
        return;
    }
    NSDictionary *param;
    if (filter == RECOMMENT) {
        filterby = RECOMMENT;
        param = @{
                  @"latitude":[NSString stringWithFormat:@"%f",appDelegate.myLocation.coordinate.latitude],
                  @"longitude":[NSString stringWithFormat:@"%f",appDelegate.myLocation.coordinate.longitude],                            @"province":@1,
                  @"popular":@1,
                  @"page":page
                  };
    }else if (filter == LIKE){
        filterby = LIKE;
        param = @{@"latitude":[NSString stringWithFormat:@"%f",appDelegate.myLocation.coordinate.latitude],
                  @"longitude":[NSString stringWithFormat:@"%f",appDelegate.myLocation.coordinate.longitude],                            @"province":@1,
                  @"rated":@1,
                  @"page":page
                  };
    }else if (filter == NEAREST){
        filterby = NEAREST;
        param = @{@"latitude":[NSString stringWithFormat:@"%f",appDelegate.myLocation.coordinate.latitude],
                  @"longitude":[NSString stringWithFormat:@"%f",appDelegate.myLocation.coordinate.longitude],                        @"province":@1,
                  @"page":page
                  };
    }else{
        //search
        return;
//        param = @{@"latitude":[NSString stringWithFormat:@"%f",appDelegate.myLocation.coordinate.latitude],
//                  @"longitude":[NSString stringWithFormat:@"%f",appDelegate.myLocation.coordinate.longitude],                            @"province":@1,
//                  @"search":@"h"
//                  };
    }
    [self.networkManager requestSearchGarageList:param comletion:^(NSDictionary *responseDict) {
        [self partDataGarage:responseDict andPage:page];
    }];
}
- (void)partDataGarage:(NSDictionary*) responseDict andPage:(NSNumber*)page{
    NSError *error;
    garageApiJson = [[GarageApiJsonModel alloc]initWithDictionary:responseDict error:&error];
    //[marrData addObjectsFromArray:garageApiJson.data];
    //arrData = garageApiJson.data;
    if ([page intValue] > 1) {
        
    }else{
        [marrData removeAllObjects];
    }
    
    NSArray *arrData = garageApiJson.data;
    [marrData addObjectsFromArray:arrData];
    if (isSearchTap) {
        [self.searchTableView reloadData];
    }else{
        if (marrData.count != 0)
        {dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"arrdata count: %lu", (unsigned long)marrData.count);
            // hiden loading view
            [self.loadingView removeFromSuperview];
            [self.tableView reloadData];
            });
        }
    }
    
    isRequesting = NO;
}

#pragma mark - Action
- (IBAction)menuButtonTap:(UIButton *)sender {
    if (![MCSession sharedSession].isAuthenticated) {
        LoginVC *loginVC = [[LoginVC alloc]init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }else{
        UserVC *userVC = [[UserVC alloc]init];
        [self presentViewController:userVC animated:YES completion:nil];
    }
}
#pragma mark - TabbarControllerDelegate


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:       (UIViewController *)viewController
{
    //add your check here
    if (viewController == [tabBarController.viewControllers objectAtIndex:2]) {
        if (!self.session.isAuthenticated) {
            LoginVC *loginVC = [[LoginVC alloc]init];
            [self presentViewController:loginVC animated:YES completion:nil];
            return NO;
        }else{
            return YES;
        }
        
    }else{
        return YES;
    }
}

#pragma mark - Search TextFieldDeledate;
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.tableView.hidden = YES;
    self.searchTableView.hidden = NO;
    self.cancelButton.hidden = NO;
    self.viewButtonCity.hidden = YES;
    isSearchTap = YES;
    return YES;
}

-(void)textFieldDidChange:(UITextField*)textField{
    NSString *textSearchString = textField.text;
    NSDictionary *param = @{@"latitude":[NSString       stringWithFormat:@"%f",appDelegate.myLocation.coordinate.latitude],
                            @"longitude":[NSString stringWithFormat:@"%f",appDelegate.myLocation.coordinate.longitude],                            @"province":@1,
                            @"allow_blank_search":@"no",
                            @"search":textSearchString
                            };

    if (!isRequesting) {
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.networkManager requestSearchGarageList:param comletion:^(NSDictionary *responseDict) {
                [self partDataGarage:responseDict andPage:[NSNumber numberWithInt:1]];
            }];
        });
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    NSString *textSearchString = textField.text;
    NSDictionary *param = @{@"latitude":[NSString       stringWithFormat:@"%f",appDelegate.myLocation.coordinate.latitude],
                            @"longitude":[NSString stringWithFormat:@"%f",appDelegate.myLocation.coordinate.longitude],                            @"province":@1,
                            @"allow_blank_search":@"no",
                            @"search":textSearchString
                            };
    
    if (!isRequesting) {
        [self.networkManager requestSearchGarageList:param comletion:^(NSDictionary *responseDict) {
            [self partDataGarage:responseDict andPage:[NSNumber numberWithInt:1]];
        }];
    }
    return YES;
}

#pragma mark - UItableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isSearchTap) {
        return 50;
    }else{
        if (indexPath.row == 0) {
            return 300;
        }else if (indexPath.row == 1){
            return 40;
        }else{
            return 100;
        }
    }
}

#pragma mark - UItableViewDatasoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isSearchTap) {
        return marrData.count;
    }else{
        return (2 + marrData.count);
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isSearchTap) {
        static NSString *cellIdentifier2 = @"SearchCell";
        SearchCell *cell = (SearchCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (!cell)
        {
            cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (marrData.count != 0) {
            NSError *error;
            GarageJsonModel *garageJson = [[GarageJsonModel alloc] initWithDictionary:marrData[indexPath.row] error:&error];
            [cell.avataImageView setImageWithURL:[NSURL URLWithString:garageJson.avatar] placeholderImage:[UIImage imageNamed:@"logo-mcar-icon.png"]];
            cell.titleLabel.text = garageJson.name;
            cell.addressLabel.text = garageJson.address;
            float distance = [garageJson.distance floatValue];
            cell.distanceLabel.text = [NSString stringWithFormat:@"%0.1fkm",distance/1000];
        }
        return cell;
    }else{
        if (indexPath.row == 0) {
            static NSString *cellIdentifier = @"MapCell";
            MapCell *cell = (MapCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell)
            {
                cell = [[MapCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            [cell.mapView clear];
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:appDelegate.myLocation.coordinate.latitude
                                                                    longitude:appDelegate.myLocation.coordinate.longitude
                                                                         zoom:15];
            cell.mapView.camera = camera;
            cell.mapView.myLocationEnabled = YES;
            cell.mapView.settings.myLocationButton = YES;
            cell.mapView.delegate = self;
            if (marrData.count != 0) {
                for (int i=0;i<marrData.count;i++) {
                    NSError *error;
                    GarageJsonModel *garageJson = [[GarageJsonModel alloc] initWithDictionary:marrData[i] error:&error];
                    GMSMarker *marker = [[GMSMarker alloc] init];
                    CLLocationCoordinate2D position = CLLocationCoordinate2DMake([garageJson.latitude floatValue],[garageJson.longitude floatValue]);
                    marker.position = position;
                    marker.title = garageJson.name;
                    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 28)];
                    iconView.image = [UIImage imageNamed:@"logo-mcar-maps.png"];
                    marker.iconView = iconView;
                    marker.appearAnimation = kGMSMarkerAnimationPop;
                    marker.map = cell.mapView;
                    marker.snippet = garageJson.address;
                    marker.opacity = 1;
                    marker.accessibilityLabel = [NSString stringWithFormat:@"%d",i];
                }
            }
            
            return cell;
        }
        else if (indexPath.row == 1){
            static NSString *cellIdentifier1 = @"MenuTabCell";
            MenuTabCell *cell = (MenuTabCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            if (!cell)
            {
                cell = [[MenuTabCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
                //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            [cell.noibatButton addTarget:self action:@selector(buttonNoiBatTap:) forControlEvents:UIControlEventTouchUpInside];
            [cell.yeuthichButton addTarget:self action:@selector(buttonYeuThichTap:) forControlEvents:UIControlEventTouchUpInside];
            [cell.gannhatButton addTarget:self action:@selector(buttonGanNhatTap:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        else{
            
            static NSString *cellIdentifier2 = @"GarageListCell";
            GarageListCell *cell = (GarageListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
            if (!cell)
            {
                cell = [[GarageListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
                //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (marrData.count != 0) {
                NSError *error;
                GarageJsonModel *garageJson = [[GarageJsonModel alloc] initWithDictionary:marrData[indexPath.row-2] error:&error];
                cell.poinView.layer.cornerRadius = cell.poinView.frame.size.height/2;
                
                [cell.avataImageView setImageWithURL:[NSURL URLWithString:garageJson.avatar] placeholderImage:[UIImage imageNamed:@"logo-mcar-icon.png"]];
                cell.serviceLabel.text = garageJson.referral_information;
                cell.TitleGaraLabel.text = garageJson.name;
                cell.addressLabel.text = garageJson.address;
                float distance = [garageJson.distance floatValue];
                cell.distanceLabel.text = [NSString stringWithFormat:@"%0.1fkm",distance/1000];
                if ([garageJson.rating floatValue] == 0) {
                    cell.poinLabel.text = @"_._";
                }else{
                    cell.poinLabel.text = [NSString stringWithFormat:@"%0.1f",[garageJson.rating floatValue]];
                }
                
                NSArray *arrPromotion = garageJson.promotions;
                if (arrPromotion.count == 0) {
                    cell.adsLabel.hidden = YES;
                }else{
                    cell.adsLabel.hidden = NO;
                    NSError *error;
                    PromotionsJsonModel *promotionJson = [[PromotionsJsonModel alloc]initWithDictionary:arrPromotion[0] error:&error];
                    cell.adsLabel.text =[NSString stringWithFormat:@"KM: %@",promotionJson.title];
                }
            }
            return cell;
        }
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    int total = [garageApiJson.metadata.pagination.total intValue];
    if (total == indexPath.row - 2 + 1) {
    }else{
        if ([garageApiJson.metadata.pagination.to intValue] == indexPath.row - 2 + 1) {
            NSNumber *page = [NSNumber numberWithInt:([garageApiJson.metadata.pagination.page intValue] + 1)];
            [self loadDataGarageForTableView:filterby andPage:page];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSError *error;
    GarageJsonModel *garageJson;
    if (isSearchTap) {
        garageJson = [[GarageJsonModel alloc] initWithDictionary:marrData[indexPath.row] error:&error];
        [self.view endEditing:YES];
    }else{
        garageJson = [[GarageJsonModel alloc] initWithDictionary:marrData[indexPath.row-2] error:&error];
    }
    
    float distance = [garageJson.distance floatValue];
    NSString *distanceString = [NSString stringWithFormat:@"%0.1f km",distance/1000];
    GarageDetailVC *garageDetail = [[GarageDetailVC alloc]init];
    garageDetail.garageID = garageJson.garageID;
    garageDetail.distanceStr = distanceString;
    garageDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:garageDetail animated:YES];
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation * currentLocation = [locations lastObject];
    //self.myLocation = [[CLLocation alloc]init];
    static dispatch_once_t once;
    dispatch_once(&once, ^
                  {
                      appDelegate.myLocation = currentLocation;
                      [self loadDataGarageForTableView:NEAREST andPage:[NSNumber numberWithInt:1]];
                  });
    appDelegate.myLocation = currentLocation;
}

#pragma mark - GoogleMapDelegate
-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{
    int index = [marker.accessibilityLabel intValue];
    NSLog(@"index tap: %d",index);
    NSError *error;
    GarageJsonModel *garageJson = [[GarageJsonModel alloc] initWithDictionary:marrData[index] error:&error];
    float distance = [garageJson.distance floatValue];
    NSString *distanceString = [NSString stringWithFormat:@"%0.1f km",distance/1000];
    GarageDetailVC *garageDetail = [[GarageDetailVC alloc]init];
    garageDetail.garageID = garageJson.garageID;
    garageDetail.distanceStr = distanceString;
    garageDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:garageDetail animated:YES];
}
-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
    marker.tracksInfoWindowChanges = YES;
    int index = [marker.accessibilityLabel intValue];
    NSError *error;
    GarageJsonModel *garageJson = [[GarageJsonModel alloc] initWithDictionary:marrData[index] error:&error];
    [self.markerAvataImageView setImageWithURL:[NSURL URLWithString:garageJson.avatar] placeholderImage:[UIImage imageNamed:@"m00-anh-garage-daidien.png"]];
    self.markerAvataImageView.layer.cornerRadius = 5;
    self.markerAvataImageView.layer.masksToBounds = YES;
    self.marketGaraLabel.text = garageJson.name;
    self.marketAddressLabel.text = garageJson.address;
    CGRect frameMaker = self.makerView.frame;
    self.makerView.frame = CGRectMake(frameMaker.origin.x, frameMaker.origin.y, [[UIScreen mainScreen]bounds].size.width*0.85, 60);
    self.marketContentView.layer.cornerRadius = 5;
    self.marketContentView.layer.masksToBounds = YES;
    return self.makerView;
}


#pragma mark IBAction
- (IBAction)cityButtonTap:(UIButton *)sender {
//    GarageDetailVC *detailVC = [[GarageDetailVC alloc]init];
//    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)buttonNoiBatTap:(UIButton *)sender{
    //listFilter = RECOMMENT;
    [self.tableView reloadData];
    marrData = [[NSMutableArray alloc] init];
    [self loadDataGarageForTableView:RECOMMENT andPage:[NSNumber numberWithInt:1]];
}

- (void)buttonYeuThichTap:(UIButton *)sender{
    [self.tableView reloadData];
    marrData = [[NSMutableArray alloc] init];
    [self loadDataGarageForTableView:LIKE andPage:[NSNumber numberWithInt:1]];
}

-(void)buttonGanNhatTap:(UIButton *)sender{
    [self.tableView reloadData];
    marrData = [[NSMutableArray alloc] init];
    [self loadDataGarageForTableView:NEAREST andPage:[NSNumber numberWithInt:1]];
}
- (IBAction)cancelButtonTap:(UIButton *)sender {
    isSearchTap = NO;
    self.searchTextFied.text = @"";
    [self.view endEditing:YES];
    self.cancelButton.hidden = YES;
    self.viewButtonCity.hidden = NO;
    self.searchTableView.hidden = YES;
    self.tableView.hidden = NO;
    [marrData removeAllObjects];
    [self loadDataGarageForTableView:NEAREST andPage:[NSNumber numberWithInt:1]];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
