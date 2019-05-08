//
//  NetCell.m
//  SWSDemo
//
//  Created by 施文松 on 2019/4/30.
//  Copyright © 2019 施文松. All rights reserved.
//

#import "NetCell.h"

@implementation NetCell

- (void)awakeFromNib {
    [super awakeFromNib];

	UIView *superView = self.contentView;
	
	self.headerImageView.sd_layout
	.leftSpaceToView(superView, kGlobalSpace)
	.topSpaceToView(superView, kGlobalSpace)
	.widthIs(50)
	.heightIs(50);
	
	self.titleLabel.sd_layout
	.leftSpaceToView(self.headerImageView, kGlobalSpace)
	.topEqualToView(self.headerImageView).offset(5)
	.rightSpaceToView(superView, kGlobalSpace)
	.autoHeightRatio(0);
	
	self.timeLabel.sd_layout
	.leftEqualToView(self.titleLabel)
	.topSpaceToView(self.titleLabel, kGlobalSpace)
	.autoWidthRatio(0)
	.heightIs(kGlobalCommonLabelHeight);
	[self.timeLabel setSingleLineAutoResizeWithMaxWidth:_kWidth];
	
	
	self.commentLabel.sd_layout
	.rightSpaceToView(superView, kGlobalSpace)
	.centerYEqualToView(self.timeLabel)
	.autoWidthRatio(0)
	.heightIs(kGlobalCommonLabelHeight);
	[self.commentLabel setSingleLineAutoResizeWithMaxWidth:_kWidth];

	[self setupAutoHeightWithBottomViewsArray:@[self.headerImageView, self.timeLabel, self.commentLabel] bottomMargin:kGlobalSpace];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(NetModel *)model{
	_model = model;
	
	[self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.user.avatarUrl]];
	self.titleLabel.text = [NSString stringWithFormat:@"%@ : %@", model.user.nickname, model.content];
	@weakify(self);
//	[[RACObserve(model, time) map:^id _Nullable(id  _Nullable value) {
//		NSDate *date = [NSDate dateWithTimeIntervalSince1970:([value longLongValue]/1000)];
//		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//		return [dateFormatter stringFromDate:date];
//		@strongify(self);
//	}] subscribeNext:^(id  _Nullable x) {
//		@strongify(self);
//		self.timeLabel.text = x;
//	}];
//	RAC(self.commentLabel, text)  = [RACObserve(model, time) map:^id _Nullable(id  _Nullable value) {
//		return [value stringValue];
//	}];

	[[RACObserve(model, time) map:^id _Nullable(id  _Nullable value) {
		NSDate *date = [NSDate dateWithTimeIntervalSince1970:([value longLongValue]/1000)];
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
		return [dateFormatter stringFromDate:date];
	}] subscribeNext:^(id  _Nullable x) {
		self.timeLabel.text = x;
	}];
	
	self.commentLabel.text = model.likedCount;
	
//	RAC(self, commentLabel.text)  = [RACObserve(model, time) map:^id _Nullable(id  _Nullable value) {
//		NSDate *date = [NSDate dateWithTimeIntervalSince1970:([value longLongValue]/1000)];
//		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//		return [dateFormatter stringFromDate:date];
//	}];
//	RAC(self, timeLabel.text) = [RACObserve(model, time) map:^id _Nullable(id  _Nullable value) {
//		NSDate *date = [NSDate dateWithTimeIntervalSince1970:([value longLongValue]/1000)];
//		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//		return [dateFormatter stringFromDate:date];
//	}];
}

@end
