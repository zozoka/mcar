//
//  ScheduleTextViewCell.m
//  Mcar
//
//  Created by thanh tung on 11/10/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "ScheduleTextViewCell.h"

@implementation ScheduleTextViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textView.placeholder = @"Yêu cầu thêm (không bắt buộc)...";
    self.textView.placeholderColor = [UIColor lightGrayColor];
    
    self.textView.textColor = [UIColor blackColor];
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.borderColor = [UIColor grayColor].CGColor;
    self.textView.layer.borderWidth = 0.5;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
