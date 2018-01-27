//
//  TopCell.m
//  Mcar
//
//  Created by thanh tung on 10/9/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "TopCell.h"

@implementation TopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.scrollView.delegate = self;
    self.viewPoint.layer.cornerRadius = self.viewPoint.bounds.size.height/2;
    self.viewPoint.layer.masksToBounds = YES;
    self.viewCall.layer.cornerRadius = 5;
    self.viewCall.layer.masksToBounds = YES;
    self.viewAddress.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    self.viewDichVu.layer.cornerRadius = 5;
    self.viewDichVu.layer.masksToBounds = YES;
    self.viewXemThem.layer.cornerRadius = 5;
    self.viewXemThem.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)onValueChange:(UIPageControl *)sender {
    self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage*self.scrollView.bounds.size.width,0);
}


#pragma mark scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"curenPage: %f",self.scrollView.contentOffset.x);
    self.pageControl.currentPage = self.scrollView.contentOffset.x/self.scrollView.bounds.size.width;
}


@end
