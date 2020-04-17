//
//  PrescriptionHeaderCell.m
//  SWSDemo
//
//  Created by 施文松 on 2019/5/5.
//  Copyright © 2019 施文松. All rights reserved.
//

#import "PrescriptionHeaderCell.h"

@implementation PrescriptionHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];

	UIView *superView = self.contentView;
	self.statusLabel.sd_layout
	.leftSpaceToView(superView, kGlobalSpace)
	.rightSpaceToView(superView, kGlobalSpace)
	.topSpaceToView(superView, 100)
	.heightIs(20);
    
    [self setupAutoHeightWithBottomViewsArray:@[self.statusLabel] bottomMargin:100];
    RAC(self.statusLabel, text) = [RACObserve(self, rowInfo.rowInfoObj0.infoValue) takeUntil:self.rac_prepareForReuseSignal];
}

@end
