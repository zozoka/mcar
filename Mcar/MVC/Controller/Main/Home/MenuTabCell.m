//
//  MenuTabCell.m
//  Mcar
//
//  Created by thanh tung on 9/22/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "MenuTabCell.h"

@implementation MenuTabCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.noibatUiimageView.image = [UIImage imageNamed:@"m00-icon-noibat"];
    self.yeuthichLabel.textColor = [UIColor colorWithRed:104/255.f green:104/255.f blue:103/255.f alpha:1];
    UIView* noibatView = [self.noibatButton superview];
    noibatView.backgroundColor = [UIColor whiteColor];
    UIView *yeuthichView = [self.yeuthichButton superview];
    yeuthichView.backgroundColor = [UIColor whiteColor];
    UIView *gannhatView = [self.gannhatButton superview];
    gannhatView.backgroundColor = [UIColor redColor];
    self.yeuthichUiimageView.image = [UIImage imageNamed:@"m00-icon-yeuthich"];
    self.gannhatUiimageView.image = [UIImage imageNamed:@"m00-icon-gannhat-white"];
    self.gannhatLabel.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)noibatButtonTap:(UIButton *)sender {
    self.noibatUiimageView.image = [UIImage imageNamed:@"m00-icon-noibat-white"];
    self.noibatLabel.textColor = [UIColor whiteColor];
    UIView* parentView = [self.noibatButton superview];
    parentView.backgroundColor = [UIColor redColor];
    UIView *yeuthichView = [self.yeuthichButton superview];
    yeuthichView.backgroundColor = [UIColor whiteColor];
    UIView *gannhatView = [self.gannhatButton superview];
    gannhatView.backgroundColor = [UIColor whiteColor];
    self.yeuthichUiimageView.image = [UIImage imageNamed:@"m00-icon-yeuthich"];
    self.gannhatUiimageView.image = [UIImage imageNamed:@"m00-icon-gannhat"];
    self.yeuthichLabel.textColor = [UIColor colorWithRed:104/255.f green:104/255.f blue:103/255.f alpha:1];
    self.gannhatLabel.textColor = [UIColor colorWithRed:104/255.f green:104/255.f blue:103/255.f alpha:1];
}
- (IBAction)yeuthichButtonTap:(UIButton *)sender {
    self.yeuthichUiimageView.image = [UIImage imageNamed:@"m00-icon-yeuthich-white"];
    self.yeuthichLabel.textColor = [UIColor whiteColor];
    UIView* parentView = [self.yeuthichButton superview];
    parentView.backgroundColor = [UIColor redColor];
    UIView *noibatView = [self.noibatButton superview];
    noibatView.backgroundColor = [UIColor whiteColor];
    UIView *gannhatView = [self.gannhatButton superview];
    gannhatView.backgroundColor = [UIColor whiteColor];
    
    self.gannhatUiimageView.image = [UIImage imageNamed:@"m00-icon-gannhat"];
    self.noibatUiimageView.image = [UIImage imageNamed:@"m00-icon-noibat"];
    self.noibatLabel.textColor = [UIColor colorWithRed:104/255.f green:104/255.f blue:103/255.f alpha:1];
    self.gannhatLabel.textColor = [UIColor colorWithRed:104/255.f green:104/255.f blue:103/255.f alpha:1];

}
- (IBAction)gannhatButtonTap:(UIButton *)sender {
    self.gannhatUiimageView.image = [UIImage imageNamed:@"m00-icon-gannhat-white"];
    self.gannhatLabel.textColor = [UIColor whiteColor];
    UIView* parentView = [self.gannhatLabel superview];
    parentView.backgroundColor = [UIColor redColor];
    UIView *noibatView = [self.noibatButton superview];
    noibatView.backgroundColor = [UIColor whiteColor];
    UIView *yeuthichView = [self.yeuthichButton superview];
    yeuthichView.backgroundColor = [UIColor whiteColor];
    
    self.yeuthichUiimageView.image = [UIImage imageNamed:@"m00-icon-yeuthich"];
    self.noibatUiimageView.image = [UIImage imageNamed:@"m00-icon-noibat"];
    self.noibatLabel.textColor = [UIColor colorWithRed:104/255.f green:104/255.f blue:103/255.f alpha:1];
    self.yeuthichLabel.textColor = [UIColor colorWithRed:104/255.f green:104/255.f blue:103/255.f alpha:1];
    
}

@end
