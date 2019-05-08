//
//  TableViewGroupInfo.h
//  TableViewManagerDemo
//
//  Created by 施文松 on 2019/3/20.
//  Copyright © 2019 施文松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewSectionInfo : NSObject

@property (strong, nonatomic) NSMutableArray *subRowsArray;


/**
 headerView的高度
 */
@property (assign, nonatomic) CGFloat headerViewHeight;

/**
 footerView的高度
 */
@property (assign, nonatomic) CGFloat footerViewHeight;

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
 添加type字段
 */
@property (copy, nonatomic) NSString *type;

/**
 已经有headerView，直接赋值的操作
 */
@property (copy, nonatomic) void(^setHeaderViewValueBlock)(UITableViewHeaderFooterView *headerView, UITableView *tableView, NSInteger section, TableViewSectionInfo *sectionInfo);

/**
 footerView Class类型数组
 */
//@property (strong, nonatomic) NSMutableArray *footerViewTypesArray;

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

@property (strong, nonatomic) id sectionInfoValue0;
@property (strong, nonatomic) id sectionInfoValue1;
@property (strong, nonatomic) id sectionInfoValue2;
@property (strong, nonatomic) id sectionInfoValue3;
@property (strong, nonatomic) id sectionInfoValue4;
@property (strong, nonatomic) id sectionInfoValue5;
@property (strong, nonatomic) id sectionInfoValue6;
@property (strong, nonatomic) id sectionInfoValue7;
@property (strong, nonatomic) id sectionInfoValue8;
@property (strong, nonatomic) id sectionInfoValue9;
@property (strong, nonatomic) id sectionInfoValue10;
@property (strong, nonatomic) id sectionInfoValue11;
@property (strong, nonatomic) id sectionInfoValue12;
@property (strong, nonatomic) id sectionInfoValue13;
@property (strong, nonatomic) id sectionInfoValue14;
@property (strong, nonatomic) id sectionInfoValue15;
@property (strong, nonatomic) id sectionInfoValue16;
@property (strong, nonatomic) id sectionInfoValue17;
@property (strong, nonatomic) id sectionInfoValue18;
@property (strong, nonatomic) id sectionInfoValue19;

@end

@interface TableViewRowInfo : NSObject



/**
 cell的高度
 */
@property (assign, nonatomic) CGFloat cellHeight;

/**
 需要返回cell的设置
 */
@property (copy, nonatomic) UITableViewCell *(^cellBlock)(UITableView *tableView, NSIndexPath *indexPath, TableViewSectionInfo *sectionInfo, TableViewRowInfo *rowInfo);

/**
 设置cell的名称（必传）
 */
@property (copy, nonatomic) NSString *cellClass;

/**
 添加type字段
 */
@property (copy, nonatomic) NSString *type;


/**
 已经有cell，直接赋值的操作
 */
@property (copy, nonatomic) void(^setCellValueBlock)(id _Nonnull cell, UITableView *tableView, NSIndexPath *indexPath, TableViewSectionInfo *sectionInfo, TableViewRowInfo *rowInfo);

/**
 返回cell高度, 默认返回44.0
 */
@property (copy, nonatomic) CGFloat(^cellHeightBlock)(UITableView *tableView, NSIndexPath *indexPath, TableViewSectionInfo *sectionInfo, TableViewRowInfo *rowInfo);

/**
 cell的点击事件
 */
@property (copy, nonatomic) void(^didSelectBlock)(UITableView *tableView, NSIndexPath *indexPath, TableViewSectionInfo *sectionInfo, TableViewRowInfo *rowInfo);

@property (strong, nonatomic) id rowInfoValue0;
@property (strong, nonatomic) id rowInfoValue1;
@property (strong, nonatomic) id rowInfoValue2;
@property (strong, nonatomic) id rowInfoValue3;
@property (strong, nonatomic) id rowInfoValue4;
@property (strong, nonatomic) id rowInfoValue5;
@property (strong, nonatomic) id rowInfoValue6;
@property (strong, nonatomic) id rowInfoValue7;
@property (strong, nonatomic) id rowInfoValue8;
@property (strong, nonatomic) id rowInfoValue9;
@property (strong, nonatomic) id rowInfoValue10;
@property (strong, nonatomic) id rowInfoValue11;
@property (strong, nonatomic) id rowInfoValue12;
@property (strong, nonatomic) id rowInfoValue13;
@property (strong, nonatomic) id rowInfoValue14;
@property (strong, nonatomic) id rowInfoValue15;
@property (strong, nonatomic) id rowInfoValue16;
@property (strong, nonatomic) id rowInfoValue17;
@property (strong, nonatomic) id rowInfoValue18;
@property (strong, nonatomic) id rowInfoValue19;

@end


NS_ASSUME_NONNULL_END
