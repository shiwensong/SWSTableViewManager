//
//  InfoCell.m
//  SWSDemo
//
//  Created by 施文松 on 2019/5/5.
//  Copyright © 2019 施文松. All rights reserved.
//

#import "InfoCell.h"

@implementation InfoCell

- (void)awakeFromNib {
    [super awakeFromNib];

	UIView *superView = self.contentView;
	
	self.titlelabel.sd_layout
	.leftSpaceToView(superView, kGlobalSpace)
	.topSpaceToView(superView, kGlobalSpace)
	.heightIs(kGlobalCommonLabelHeight)
	.autoWidthRatio(0);
	[self.titlelabel setSingleLineAutoResizeWithMaxWidth:_kWidth];
	
	self.subTitleLabel.sd_layout
	.leftSpaceToView(self.titlelabel, kGlobalSpace)
	.rightSpaceToView(superView, kGlobalSpace)
	.centerYEqualToView(self.titlelabel)
	.heightRatioToView(self.titlelabel, 1);
	
	[self setupAutoHeightWithBottomViewsArray:@[self.titlelabel, self.subTitleLabel] bottomMargin:kGlobalSpace];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
