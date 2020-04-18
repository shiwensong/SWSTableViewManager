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

//#define manager [TableViewManager createTableViewManager]

@interface TableViewManager : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) UITableView *tableView;

/**
 分组信息
 */
@property (strong, nonatomic) NSMutableArray *groupSectionArray;


/**
 titles
 */
@property (strong, nonatomic) NSArray *titles;

/**
 添加type字段
 */
@property (copy, nonatomic) NSString *type;

/**
统一返回Cell的回调
 */
@property (copy, nonatomic) UITableViewCell * (^ cellBlock)(UITableView *tableView, NSIndexPath *indexPath, TableViewSectionInfo *sectionInfo, TableViewRowInfo *rowInfo);

/**
 统一设置cell value的回调
 */
@property (copy, nonatomic) void (^ setCellValueBlock)(UITableViewCell *cell, UITableView *tableView, NSIndexPath *indexPath, TableViewSectionInfo *sectionInfo, TableViewRowInfo *rowInfo);

/**
 返回cell高度, 默认返回44.0
 */
@property (copy, nonatomic) CGFloat (^ cellHeightBlock)(UITableView *tableView, NSIndexPath *indexPath, TableViewSectionInfo *sectionInfo, TableViewRowInfo *rowInfo);

/**
 titles点击事件
 */
@property (copy, nonatomic) NSInteger (^ sectionForSectionIndexTitleBlock)(UITableView *tableView, NSString *title, NSInteger index);
/**
 cell的点击事件
 */
@property (copy, nonatomic) void (^ didSelectBlock)(UITableView *tableView, NSIndexPath *indexPath, TableViewSectionInfo *sectionInfo, TableViewRowInfo *rowInfo);

/**
 返回section header高度, 默认返回0.0001
 */
@property (copy, nonatomic) CGFloat (^ headerHeightBlock)(UITableView *tableView, NSInteger section, TableViewSectionInfo *sectionInfo);

/**
 返回section footer高度, 默认返回0.0001
 */
@property (copy, nonatomic) CGFloat (^ footerHeightBlock)(UITableView *tableView, NSInteger section, TableViewSectionInfo *sectionInfo);

/**
 需要返回headerView的设置
 */
@property (copy, nonatomic) UITableViewHeaderFooterView * (^ headerViewBlock)(UITableView *tableView, NSInteger section, TableViewSectionInfo *sectionInfo);

/**
 设置headerView的名称
 */
@property (copy, nonatomic) NSString *headerViewClass;

/**
 已经有cell，直接赋值的操作
 */
@property (copy, nonatomic) void (^ setHeaderViewValueBlock)(UITableViewHeaderFooterView *headerView, UITableView *tableView, NSInteger section, TableViewSectionInfo *sectionInfo);

/**
 需要返回footerView的设置
 */
@property (copy, nonatomic) UITableViewHeaderFooterView * (^ footerViewBlock)(UITableView *tableView, NSInteger section, TableViewSectionInfo *sectionInfo);

/**
 设置footerView的名称
 */
@property (copy, nonatomic) NSString *footerViewClass;

/**
 已经有cell，直接赋值的操作
 */
@property (copy, nonatomic) void (^ setfooterViewValueBlock)(UITableViewHeaderFooterView *footerView, UITableView *tableView, NSInteger section, TableViewSectionInfo *sectionInfo);

#pragma mark - UIScrollViewDelegate

@property (copy, nonatomic) void (^ scrollViewDidScroll)(UIScrollView *scrollView);
@property (copy, nonatomic) void (^ scrollViewDidZoom)(UIScrollView *scrollView);
@property (copy, nonatomic) void (^ scrollViewWillBeginDragging)(UIScrollView *scrollView);
@property (copy, nonatomic) void (^ scrollViewWillEndDragging)(UIScrollView *scrollView, CGPoint velocity, CGPoint targetContentOffset);
@property (copy, nonatomic) void (^ scrollViewDidEndDragging)(UIScrollView *scrollView, BOOL decelerate);
@property (copy, nonatomic) void (^ scrollViewWillBeginDecelerating)(UIScrollView *scrollView);
@property (copy, nonatomic) void (^ scrollViewDidEndDecelerating)(UIScrollView *scrollView);
@property (copy, nonatomic) void (^ scrollViewDidEndScrollingAnimation)(UIScrollView *scrollView);
@property (copy, nonatomic) UIView * (^ viewForZoomingInScrollView)(UIScrollView *scrollView);
@property (copy, nonatomic) void (^ scrollViewWillBeginZooming)(UIScrollView *scrollView, UIView *view);
@property (copy, nonatomic) void (^ scrollViewDidEndZooming)(UIScrollView *scrollView, UIView *view, CGFloat scale);
@property (copy, nonatomic) BOOL (^ scrollViewShouldScrollToTop)(UIScrollView *scrollView);
@property (copy, nonatomic) void (^ scrollViewDidScrollToTop)(UIScrollView *scrollView);
@property (copy, nonatomic) void (^ scrollViewDidChangeAdjustedContentInset)(UIScrollView *scrollView);

/**
 创建实例

 @param vc 当前的控制器或者view
 @param tableView 当前的tableView
 @return 当前实例
 */
+ (instancetype)createTableViewManager:(NSObject *)vc tableView:(UITableView *)tableView;


/**
 刷新section

 @param sectionInfos 传入sectionInfos
 @param animation 刷新动画
 */
- (void)reloadSectionData:(NSArray <TableViewSectionInfo *> *)sectionInfos
         withRowAnimation:(UITableViewRowAnimation)animation;

/**
 刷新rowInfos

 @param rowInfos 传入rowInfos
 @param sectionInfo sectionInfo
 @param animation 刷新动画
 */
- (void)reloadRowData:(NSArray <TableViewRowInfo *> *)rowInfos
      withSectionInfo:(TableViewSectionInfo *)sectionInfo
     withRowAnimation:(UITableViewRowAnimation)animation;


/// 根据identifier查找tableViewSectionInfo(多个sectionInfo)
/// @param identifier 标识
- (NSArray<TableViewSectionInfo *> *)getMoreSectionInfoWithIdentifier:(NSString *)identifier;

/// 根据identifier查找tableViewSectionInfo(单个sectionInfo)
/// @param identifier 标识
- (TableViewSectionInfo *)getSectionInfoWithIdentifier:(NSString *)identifier;

/// 根据predicate查找tableViewSectionInfo (多个sectionInfo)
/// @param predicate 谓词
- (NSArray<TableViewSectionInfo *> *)getMoreSectionInfoWithPredicate:(NSPredicate *)predicate;

/// 根据predicate查找tableViewSectionInfo (单个sectionInfo)
/// @param predicate 标识
- (TableViewSectionInfo *)getSectionInfoWithPredicate:(NSPredicate *)predicate;

/// 根据identifier查找tableViewRowInfo(多个rowInfo)
/// @param identifier 标识
/// @param sectionInfo 数据源
- (NSArray<TableViewRowInfo *> *)getMoreRowInfoWithIdentifier:(NSString *)identifier
                                              withSectionInfo:(TableViewSectionInfo *)sectionInfo;

/// 根据identifier查找tableViewRowInfo(单个RowInfos)
/// @param identifier 标识
/// @param sectionInfo 数据源
- (TableViewRowInfo *)getRowInfoWithIdentifier:(NSString *)identifier
                               withSectionInfo:(TableViewSectionInfo *)sectionInfo;

/// 根据predicate查找tableViewRowInfo(多个RowInfos)
/// @param predicate 谓词
/// @param sectionInfo 数据源
- (NSArray<TableViewRowInfo *> *)getMoreRowInfoWithPredicate:(NSPredicate *)predicate
                                             withSectionInfo:(TableViewSectionInfo *)sectionInfo;
/// 根据predicate查找tableViewRowInfo(单个RowInfos)
/// @param predicate 谓词
/// @param sectionInfo 数据源
- (TableViewRowInfo *)getRowInfoWithPredicate:(NSPredicate *)predicate
                              withSectionInfo:(TableViewSectionInfo *)sectionInfo;

/// 查找sectionInfo的index
/// @param sectionInfo 对应的组信息
- (NSInteger)indexOfSectionInfos:(TableViewSectionInfo *)sectionInfo;

/// 查找rowInfo的index
/// @param rowInfo 对应的行信息
/// @param sectionInfo 对应的组信息
- (NSInteger)indexOfRowInfos:(TableViewRowInfo *)rowInfo
             withSectionInfo:(TableViewSectionInfo *)sectionInfo;

/**
 创建实例

 @return 当前实例
 */
+ (instancetype)createTableViewManager;

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

@property (strong, nonatomic) TableValueModel *tableViewManagerObj0;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj1;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj2;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj3;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj4;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj5;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj6;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj7;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj8;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj9;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj10;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj11;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj12;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj13;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj14;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj15;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj16;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj17;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj18;
@property (strong, nonatomic) TableValueModel *tableViewManagerObj19;

@end

@interface NSObject (TableViewManager)

@property (strong, nonatomic) TableViewManager *tableManager;

@end

NS_ASSUME_NONNULL_END
