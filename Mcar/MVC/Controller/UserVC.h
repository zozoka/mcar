//
//  UserVC.h
//  Mcar
//
//  Created by thanh tung on 9/26/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userCell.h"
#import "MenuUserModel.h"
#import "MCBaseVC.h"

@interface UserVC : MCBaseVC <UITableViewDelegate,UITableViewDataSource,UINavigationBarDelegate,UIImagePickerControllerDelegate,UIPickerViewDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avataImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *arrDataTable;
@property (weak, nonatomic) IBOutlet UIView *viewCuuHo;
@property (weak, nonatomic) IBOutlet UIImageView *sosImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *poinLabel;

@end
