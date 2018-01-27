//
//  TopCell_M05.h
//  Mcar
//
//  Created by thanh tung on 11/6/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopCell_M05 : UITableViewCell<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avataImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameGarageLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
