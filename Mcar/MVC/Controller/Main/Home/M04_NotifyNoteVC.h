//
//  M04_NotifyNoteVC.h
//  Mcar
//
//  Created by thanh tung on 9/20/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBaseVC.h"
#import "NotifyCell.h"
#import "NewsApiJsonModel.h"
@interface M04_NotifyNoteVC :MCBaseVC<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
