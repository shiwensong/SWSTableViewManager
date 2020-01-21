//
//  PresSectionHeaderCell.m
//  SWSDemo
//
//  Created by 施文松 on 2019/5/5.
//  Copyright © 2019 施文松. All rights reserved.
//

#import "PresSectionHeaderCell.h"

@implementation PresSectionHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
	
	UIView *superView = self.contentView;
	
	self.greenView.sd_layout
	.leftSpaceToView(superView, 0)
	.topSpaceToView(superView, kGlobalCommonLabelHeight)
	.widthIs(5)
	.heightIs(kGlobalCommonLabelHeight);
	
	self.titleLabel.sd_layout
	.leftSpaceToView(self.greenView, kGlobalSpace)
	.centerYEqualToView(self.greenView)
	.rightSpaceToView(superView, kGlobalSpace)
	.heightIs(kGlobalCommonLabelHeight);
	
	[self setupAutoHeightWithBottomViewsArray:@[self.greenView, self.titleLabel] bottomMargin:kGlobalCommonLabelHeight];
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
