//
//  TopCell_M05.m
//  Mcar
//
//  Created by thanh tung on 11/6/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "TopCell_M05.h"

@implementation TopCell_M05

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.scrollView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"curenPage: %f",self.scrollView.contentOffset.x);
    self.pageControl.currentPage = self.scrollView.contentOffset.x/self.scrollView.bounds.size.width;
}
- (IBAction)PageControlValueChange:(UIPageControl *)sender {
     self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage*self.scrollView.bounds.size.width,0);
}

@end
