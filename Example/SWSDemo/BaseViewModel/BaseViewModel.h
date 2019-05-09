//
//  BaseViewModel.h
//  SWSDemo
//
//  Created by 施文松 on 2019/5/8.
//  Copyright © 2019 施文松. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewModel : NSObject

- (instancetype)initWithVC:(UIViewController *)viewController withTableView:(UITableView *)tableView;

@property (assign, nonatomic) BOOL isHeader;
@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) NSInteger pageSize;
@property (strong, nonatomic) NSMutableArray *modelsArray;

@property (weak, nonatomic, readonly) UIViewController *viewController;
@property (weak, nonatomic, readonly) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
