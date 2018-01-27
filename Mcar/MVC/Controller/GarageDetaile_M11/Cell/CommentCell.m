//
//  CommentCell.m
//  Mcar
//
//  Created by thanh tung on 10/10/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.commentView.layer.cornerRadius = 20;
    self.commentView.layer.masksToBounds = YES;
    self.avataImageView.layer.cornerRadius = self.avataImageView.bounds.size.height/2;
    self.avataImageView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
