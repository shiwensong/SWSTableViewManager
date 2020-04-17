//
//  PresAddressCell.m
//  SWSDemo
//
//  Created by 施文松 on 2019/5/5.
//  Copyright © 2019 施文松. All rights reserved.
//

#import "PresAddressCell.h"

@implementation PresAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
	UIView *superView = self.contentView;
	
	self.peopleLabel.sd_layout
	.leftSpaceToView(superView, kGlobalSpace)
	.rightSpaceToView(superView, kGlobalSpace)
	.topSpaceToView(superView, kGlobalSpace)
	.autoHeightRatio(0);
	
	self.addressLabel.sd_layout
	.leftEqualToView(self.peopleLabel)
	.rightEqualToView(self.peopleLabel)
	.topSpaceToView(self.peopleLabel, kGlobalSpace)
	.autoHeightRatio(0);
	
	[self setupAutoHeightWithBottomViewsArray:@[self.addressLabel] bottomMargin:kGlobalSpace];
}

- (void)setCellValue{
    RAC(self.peopleLabel, text) = [[RACObserve(self.rowInfo.rowInfoObj0, infoValue) takeUntil:self.rac_prepareForReuseSignal] map:^id _Nullable(id  _Nullable value) {
       return value[@"title"];
    }];
    RAC(self.addressLabel, text) = [[RACObserve(self.rowInfo.rowInfoObj0, infoValue) takeUntil:self.rac_prepareForReuseSignal] map:^id _Nullable(id  _Nullable value) {
       return value[@"address"];
    }];
}

@end
