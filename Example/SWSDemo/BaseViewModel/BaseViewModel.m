//
//  BaseViewModel.m
//  SWSDemo
//
//  Created by 施文松 on 2019/5/8.
//  Copyright © 2019 施文松. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (instancetype)initWithVC:(UIViewController *)viewController withTableView:(UITableView *)tableView{
	self = [super init];
	if (self) {
		_viewController = viewController;
		_tableView = tableView;
		
		_isHeader = YES;
		_modelsArray = [NSMutableArray array];
		_page = 1;
		_pageSize = 20;
	}
	return self;
}

@end
