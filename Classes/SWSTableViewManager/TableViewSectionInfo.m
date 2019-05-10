//
//  TableViewGroupInfo.m
//  TableViewManagerDemo
//
//  Created by 施文松 on 2019/3/20.
//  Copyright © 2019 施文松. All rights reserved.
//

#import "TableViewSectionInfo.h"

@implementation TableViewSectionInfo

#pragma mark - Custom

- (instancetype)init
{
	self = [super init];
	if (self) {
		_headerViewHeight = 0.000001;
		_footerViewHeight = 0.000001;
	}
	return self;
}

- (NSMutableArray *)subRowsArray{
	if (!_subRowsArray) {
		_subRowsArray = [NSMutableArray array];
	}
	return _subRowsArray;
}

@end


@implementation TableViewRowInfo

- (instancetype)init
{
	self = [super init];
	if (self) {
		_cellHeight = 44.0;
	}
	return self;
}

@end
