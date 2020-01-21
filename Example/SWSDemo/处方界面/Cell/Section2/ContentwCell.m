//
//  ContentwCell.m
//  SWSDemo
//
//  Created by 施文松 on 2019/5/5.
//  Copyright © 2019 施文松. All rights reserved.
//

#import "ContentwCell.h"

@implementation ContentwCell

- (void)awakeFromNib {
    [super awakeFromNib];
	UIView *superView = self.contentView;
	
	self.contentLabel.sd_layout
	.leftSpaceToView(superView, kGlobalSpace)
	.rightSpaceToView(superView, kGlobalSpace)
	.topSpaceToView(superView, kGlobalSpace)
	.autoHeightRatio(0);
	
	[self setupAutoHeightWithBottomViewsArray:@[self.contentLabel] bottomMargin:kGlobalSpace];
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
