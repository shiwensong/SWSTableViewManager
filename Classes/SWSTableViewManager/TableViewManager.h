//
//  TableViewManager.h
//  TableViewManagerDemo
//
//  Created by 施文松 on 2019/3/20.
//  Copyright © 2019 施文松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewSectionInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableViewManager : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;


/**
 分组信息
 */
@property (strong, nonatomic) NSMutableArray *groupSectionArray;

/**
 添加type字段
 */
@property (copy, nonatomic) NSString *type;

/**
统一返回Cell的回调
 */
@property (copy, nonatomic) UITableViewCell *(^cellBlock)(UITableView *tableView, NSIndexPath *indexPath, TableViewSectionInfo *sectionInfo, TableViewRowInfo *rowInfo);

/**
 统一设置cell value的回调
 */
@property (copy, nonatomic) void(^setCellValueBlock)(UITableViewCell *cell, UITableView *tableView, NSIndexPath *indexPath, TableViewSectionInfo *sectionInfo, TableViewRowInfo *rowInfo);

/**
 返回cell高度, 默认返回44.0
 */
@property (copy, nonatomic) CGFloat(^cellHeightBlock)(UITableView *tableView, NSIndexPath *indexPath, TableViewSectionInfo *sectionInfo, TableViewRowInfo *rowInfo);

/**
 cell的点击事件
 */
@property (copy, nonatomic) void(^didSelectBlock)(UITableView *tableView, NSIndexPath *indexPath, TableViewSectionInfo *sectionInfo, TableViewRowInfo *rowInfo);

/**
 返回section header高度, 默认返回0.0001
 */
@property (copy, nonatomic) CGFloat(^headerHeightBlock)(UITableView *tableView, NSInteger section, TableViewSectionInfo *sectionInfo);

/**
 返回section footer高度, 默认返回0.0001
 */
@property (copy, nonatomic) CGFloat(^footerHeightBlock)(UITableView *tableView, NSInteger section, TableViewSectionInfo *sectionInfo);

/**
 需要返回headerView的设置
 */
@property (copy, nonatomic) UITableViewHeaderFooterView *(^headerViewBlock)(UITableView *tableView, NSInteger section, TableViewSectionInfo *sectionInfo);

/**
 设置headerView的名称
 */
@property (copy, nonatomic) NSString *headerViewClass;


/**
 已经有cell，直接赋值的操作
 */
@property (copy, nonatomic) void(^setHeaderViewValueBlock)(UITableViewHeaderFooterView *headerView, UITableView *tableView, NSInteger section, TableViewSectionInfo *sectionInfo);

/**
 需要返回footerView的设置
 */
@property (copy, nonatomic) UITableViewHeaderFooterView *(^footerViewBlock)(UITableView *tableView, NSInteger section, TableViewSectionInfo *sectionInfo);

/**
 设置footerView的名称
 */
@property (copy, nonatomic) NSString *footerViewClass;

/**
 已经有cell，直接赋值的操作
 */
@property (copy, nonatomic) void(^setfooterViewValueBlock)(UITableViewHeaderFooterView *footerView, UITableView *tableView, NSInteger section, TableViewSectionInfo *sectionInfo);


#pragma mark - UIScrollViewDelegate

@property (copy, nonatomic) void(^scrollViewDidScroll)(UIScrollView *scrollView);
@property (copy, nonatomic) void(^scrollViewDidZoom)(UIScrollView *scrollView);
@property (copy, nonatomic) void(^scrollViewWillBeginDragging)(UIScrollView *scrollView);
@property (copy, nonatomic) void(^scrollViewWillEndDragging)(UIScrollView *scrollView, CGPoint velocity, CGPoint targetContentOffset);
@property (copy, nonatomic) void(^scrollViewDidEndDragging)(UIScrollView *scrollView, BOOL decelerate);
@property (copy, nonatomic) void(^scrollViewWillBeginDecelerating)(UIScrollView *scrollView);
@property (copy, nonatomic) void(^scrollViewDidEndDecelerating)(UIScrollView *scrollView);
@property (copy, nonatomic) void(^scrollViewDidEndScrollingAnimation)(UIScrollView *scrollView);
@property (copy, nonatomic) UIView *(^viewForZoomingInScrollView)(UIScrollView *scrollView);
@property (copy, nonatomic) void(^scrollViewWillBeginZooming)(UIScrollView *scrollView, UIView *view);
@property (copy, nonatomic) void(^scrollViewDidEndZooming)(UIScrollView *scrollView, UIView *view, CGFloat scale);
@property (copy, nonatomic) BOOL(^scrollViewShouldScrollToTop)(UIScrollView *scrollView);
@property (copy, nonatomic) void(^scrollViewDidScrollToTop)(UIScrollView *scrollView);
@property (copy, nonatomic) void(^scrollViewDidChangeAdjustedContentInset)(UIScrollView *scrollView);



/**
 创建实例

 @param vc 当前的控制器或者view
 @param tableView 当前的tableView
 @return 当前实例
 */
+ (instancetype)createTableViewManager:(NSObject *)vc tableView:(UITableView *)tableView;

/**
 刷新列表

 @param sectionInfos 传入sectionInfos
 @param animation 刷新动画
 */
- (void)reloadSectionData:(NSArray <TableViewSectionInfo *>*)sectionInfos withRowAnimation:(UITableViewRowAnimation)animation;


/**
 批量注册cell

 @param tableView 当前tableView
 @param cellTypes cellClass数组
 */
+ (void)registerClass:(UITableView *)tableView withCellTypes:(NSArray *)cellTypes;

/**
 批量注册nib cell
 
 @param tableView 当前tableView
 @param cellNibTypes nib cell数组
 */
+ (void)registerNib:(UITableView *)tableView withCellNibTypes:(NSArray *)cellNibTypes;

/**
 批量注册headerFooterView
 
 @param tableView 当前tableView
 @param headerFooterViewTypes headerFooterViewClass数组
 */
+ (void)registerHeaderFooterViewClass:(UITableView *)tableView withHeaderFooterViewTypes:(NSArray *)headerFooterViewTypes;

/**
 批量注册nib headerFooterView
 
 @param tableView 当前tableView
 @param headerFooterViewNibTypes headerFooterView cell数组
 */
+ (void)registerHeaderFooterViewNib:(UITableView *)tableView withHeaderFooterViewNibTypes:(NSArray *)headerFooterViewNibTypes;


/**
 批量注册cell
 
 @param cellTypes cellClass数组
 */
- (void)registerClassWithCellTypes:(NSArray *)cellTypes;

/**
 批量注册nib cell
 
 @param cellNibTypes nib cell数组
 */
- (void)registerNibWithNibTypes:(NSArray *)cellNibTypes;

/**
 批量注册headerFooterView
 
 @param headerFooterViewTypes headerFooterViewClass数组
 */
- (void)registerHeaderFooterViewWithClassTypes:(NSArray *)headerFooterViewTypes;

/**
 批量注册nib headerFooterView
 
 @param headerFooterViewNibTypes headerFooterView cell数组
 */
- (void)registerHeaderFooterViewNibWithNibTypes:(NSArray *)headerFooterViewNibTypes;



@property (strong, nonatomic) id tableViewManagerValue0;
@property (strong, nonatomic) id tableViewManagerValue1;
@property (strong, nonatomic) id tableViewManagerValue2;
@property (strong, nonatomic) id tableViewManagerValue3;
@property (strong, nonatomic) id tableViewManagerValue4;
@property (strong, nonatomic) id tableViewManagerValue5;
@property (strong, nonatomic) id tableViewManagerValue6;
@property (strong, nonatomic) id tableViewManagerValue7;
@property (strong, nonatomic) id tableViewManagerValue8;
@property (strong, nonatomic) id tableViewManagerValue9;
@property (strong, nonatomic) id tableViewManagerValue10;
@property (strong, nonatomic) id tableViewManagerValue11;
@property (strong, nonatomic) id tableViewManagerValue12;
@property (strong, nonatomic) id tableViewManagerValue13;
@property (strong, nonatomic) id tableViewManagerValue14;
@property (strong, nonatomic) id tableViewManagerValue15;
@property (strong, nonatomic) id tableViewManagerValue16;
@property (strong, nonatomic) id tableViewManagerValue17;
@property (strong, nonatomic) id tableViewManagerValue18;
@property (strong, nonatomic) id tableViewManagerValue19;

@end

@interface NSObject (TableViewManager)

@property (strong, nonatomic) TableViewManager *tableManager;

@end

NS_ASSUME_NONNULL_END