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


/**
 初始化

 @param viewController 当前控制器
 @param tableView tableView
 @return 返回当前创建的实例
 */
- (instancetype)initWithVC:(UIViewController *)viewController withTableView:(UITableView *)tableView;


/**
 结束上拉或者下拉刷新
 */
- (void)headerAndFooterEndFresh;


/**
 yes: 下拉  no:上拉
 */
@property (assign, nonatomic) BOOL isHeader;

/**
 页
 */
@property (assign, nonatomic) NSInteger page;

/**
 每页的数据量
 */
@property (assign, nonatomic) NSInteger pageSize;


/**
 保存数据对象
 */
@property (strong, nonatomic) NSMutableArray *modelsArray;


/**
 请求参数
 */
@property (strong, nonatomic) NSMutableDictionary *requestParamter;

/**
 当前控制器, 只读
 */
@property (weak, nonatomic, readonly) UIViewController *viewController;

/**
 当前tableView, 只读
 */
@property (weak, nonatomic, readonly) UITableView *tableView;




@end

NS_ASSUME_NONNULL_END
