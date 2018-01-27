//
//  M02_ParkingVC.h
//  Mcar
//
//  Created by thanh tung on 9/20/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBaseVC.h"
#import "ParkingCell.h"
#import "ParkingApiJsonModel.h"
#import "DirectParkingMapVC.h"
@import GoogleMaps;

@interface M02_ParkingVC : MCBaseVC<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
