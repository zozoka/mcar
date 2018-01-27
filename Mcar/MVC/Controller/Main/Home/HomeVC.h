//
//  HomeVC.h
//  Mcar
//
//  Created by thanh tung on 9/18/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBaseVC.h"
#import "UserVC.h"
#import "GarageListCell.h"
#import "MapCell.h"
#import "MenuTabCell.h"
#import "LoginVC.h"
#import "GarageApiJsonModel.h"
#import "GarageDetailVC.h"
#import "SearchCell.h"


@interface HomeVC : MCBaseVC<UITableViewDelegate,UITableViewDataSource,GMSMapViewDelegate,CLLocationManagerDelegate,UITabBarDelegate,UITabBarControllerDelegate,UITextFieldDelegate>



@property (strong, nonatomic) IBOutlet UIView *makerView;

@property (weak, nonatomic) IBOutlet UIView *marketContentView;
@property (weak, nonatomic) IBOutlet UIImageView *markerAvataImageView;
@property (weak, nonatomic) IBOutlet UILabel *marketGaraLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketAddressLabel;

@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIView *viewSearch;
@property (weak, nonatomic) IBOutlet UIView *viewButtonCity;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIImageView *loadingImageView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextFied;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end
