//
//  GarageDetailVC.h
//  Mcar
//
//  Created by thanh tung on 10/9/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopCell.h"
#import "CommentCell.h"
#import "MCBaseVC.h"
#import "GarageDetailApiJsonModel.h"
#import "ServiceCell.h"
#import "CarBrandCell.h"
#import "PromotionCell.h"
#import "DirectGarageMapVC.h"
#import "CommentVC.h"
#import "BookMarkApiJsonModel.h"
#import "ScheduleVC_M05.h"
@import GoogleMaps;

@interface GarageDetailVC : MCBaseVC<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSNumber *garageID;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *viewComment;
@property (strong,nonatomic) NSString *distanceStr;
@property (weak, nonatomic) IBOutlet UILabel *hearderTitleTableViewLabel;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *detailServiceView;
@property (weak, nonatomic) IBOutlet UITableView *serviceTableView;
@property (weak, nonatomic) IBOutlet UIView *blackView;
//view promotion
@property (weak, nonatomic) IBOutlet UIView *promotionBlackView;
@property (weak, nonatomic) IBOutlet UITableView *promotionTableView;
@property (strong, nonatomic) IBOutlet UIView *promotionView;
@property (strong, nonatomic) IBOutlet UIView *sectionDichVuView;
@property (weak, nonatomic) IBOutlet UILabel *titleSectionDichVuLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleGarageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *likeImageView;

@end
