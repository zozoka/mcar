//
//  M02_ParkingVC.m
//  Mcar
//
//  Created by thanh tung on 9/20/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "M02_ParkingVC.h"
#import "AppDelegate.h"

@interface M02_ParkingVC ()

@end

@implementation M02_ParkingVC
AppDelegate *appDelegate;
NSArray *arrDataParking;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    // Do any additional setup after loading the view from its nib.
    [self loadDataFromJson];
    [self settupUI];
    
}

#pragma mark UI
-(void)configMap{
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:appDelegate.myLocation.coordinate.latitude
                                                            longitude:appDelegate.myLocation.coordinate.longitude
                                                                 zoom:16];
    [self.mapView clear];
    self.mapView.camera = camera;
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.myLocationButton = YES;
    if (arrDataParking.count >0) {
        for (int i = 0 ; i < arrDataParking.count; i++) {
            NSError *error;
            ParkingJsonModel* parkingJson = [[ParkingJsonModel alloc]initWithDictionary:arrDataParking[i] error:&error];
            GMSMarker *marker = [[GMSMarker alloc] init];
            CLLocationCoordinate2D position = CLLocationCoordinate2DMake([parkingJson.latitude floatValue],[parkingJson.longitude floatValue]);
            marker.position = position;
            marker.title = parkingJson.name;
            UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 28)];
            iconView.image = [UIImage imageNamed:@"logo-mcar-maps.png"];
            marker.iconView = iconView;
            marker.snippet = parkingJson.address;
            marker.appearAnimation = kGMSMarkerAnimationPop;
            marker.map = self.mapView;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self settupUI];
}

-(void)settupUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ParkingCell" bundle:nil] forCellReuseIdentifier:@"ParkingCell"];

}

#pragma mark network
-(void)loadDataFromJson{
    appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSDictionary *param = @{@"latitude":[NSString stringWithFormat:@"%f",appDelegate.myLocation.coordinate.latitude],
                            @"longitude":[NSString stringWithFormat:@"%f",appDelegate.myLocation.coordinate.longitude]
                            };
    [self.networkManager requestGeParking:param comletion:^(NSDictionary *responseDict) {
        NSError *error;
        ParkingApiJsonModel *parkingApiJson = [[ParkingApiJsonModel alloc]initWithDictionary:responseDict error:&error];
        arrDataParking = parkingApiJson.data;
        [self configMap];
        [self.tableView reloadData];
    }];
}

#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrDataParking.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ParkingCell";
    ParkingCell *cell = (ParkingCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[ParkingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSError *error;
    ParkingJsonModel* parkingJson = [[ParkingJsonModel alloc]initWithDictionary:arrDataParking[indexPath.row] error:&error];
    cell.parkingTitle.text = parkingJson.address;
    cell.parkingDistance.text = [NSString stringWithFormat:@"%0.1f km",[parkingJson.distance floatValue]/1000];
    cell.parkingName.text = parkingJson.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSError *error;
    ParkingJsonModel* parkingJson = [[ParkingJsonModel alloc]initWithDictionary:arrDataParking[indexPath.row] error:&error];
    DirectParkingMapVC *directParkingVc = [[DirectParkingMapVC alloc]init];
    directParkingVc.parkingJson = parkingJson;
    [self presentViewController:directParkingVc animated:YES completion:nil];
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
