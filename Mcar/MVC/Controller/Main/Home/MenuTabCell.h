//
//  MenuTabCell.h
//  Mcar
//
//  Created by thanh tung on 9/22/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTabCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *noibatButton;
@property (weak, nonatomic) IBOutlet UIButton *yeuthichButton;
@property (weak, nonatomic) IBOutlet UIButton *gannhatButton;
@property (weak, nonatomic) IBOutlet UIImageView *noibatUiimageView;
@property (weak, nonatomic) IBOutlet UIImageView *yeuthichUiimageView;
@property (weak, nonatomic) IBOutlet UIImageView *gannhatUiimageView;
@property (weak, nonatomic) IBOutlet UILabel *noibatLabel;
@property (weak, nonatomic) IBOutlet UILabel *yeuthichLabel;
@property (weak, nonatomic) IBOutlet UILabel *gannhatLabel;

@end
