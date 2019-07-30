//
//  SWSAboutUsCell.m
//  BoLing
//
//  Created by pp-mac on 2019/7/19.
//  Copyright © 2019 SWS. All rights reserved.
//

#import "SWSAboutUsCell.h"

@implementation SWSAboutUsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *superView = self.contentView;
    
    self.detailLabel.sd_layout
    .rightSpaceToView(superView, 15)
    .topSpaceToView(superView, 15)
    .heightIs(kGlobalCommonLabelHeight);
    [self.detailLabel setSingleLineAutoResizeWithMaxWidth:_kWidth];
    
    self.titleLabel.sd_layout
    .leftSpaceToView(superView, 15)
    .centerYEqualToView(self.detailLabel)
    .rightSpaceToView(self.detailLabel, kGlobalSpace)
    .heightIs(kGlobalCommonLabelHeight);
    
    [self setupAutoHeightWithBottomViewsArray:@[self.titleLabel, self.detailLabel] bottomMargin:15];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
