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

@class TableValueModel;
@interface TableViewSectionInfo : NSObject

/** 标识 */
@property (copy, nonatomic) NSString *identifier;

/** 标识 */
@property (copy, nonatomic) NSString *identifier1;

/** 标识 */
@property (copy, nonatomic) NSString *identifier2;

/**
 隐藏当前section
 */
@property (assign, nonatomic) BOOL hidden;

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
 添加type字段
 */
@property (copy, nonatomic) NSString *type;

/**
 已经有headerView，直接赋值的操作
 */
@property (copy, nonatomic) void (^ setHeaderViewValueBlock)(UITableViewHeaderFooterView *headerView, UITableView *tableView, NSInteger section, TableViewSectionInfo *sectionInfo);

/**
 footerView Class类型数组
 */
//@property (strong, nonatomic) NSMutableArray *footerViewTypesArray;

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

@property (strong, nonatomic) TableValueModel *sectionInfoObj0;
@property (strong, nonatomic) TableValueModel *sectionInfoObj1;
@property (strong, nonatomic) TableValueModel *sectionInfoObj2;
@property (strong, nonatomic) TableValueModel *sectionInfoObj3;
@property (strong, nonatomic) TableValueModel *sectionInfoObj4;
@property (strong, nonatomic) TableValueModel *sectionInfoObj5;
@property (strong, nonatomic) TableValueModel *sectionInfoObj6;
@property (strong, nonatomic) TableValueModel *sectionInfoObj7;
@property (strong, nonatomic) TableValueModel *sectionInfoObj8;
@property (strong, nonatomic) TableValueModel *sectionInfoObj9;
@property (strong, nonatomic) TableValueModel *sectionInfoObj10;
@property (strong, nonatomic) TableValueModel *sectionInfoObj11;
@property (strong, nonatomic) TableValueModel *sectionInfoObj12;
@property (strong, nonatomic) TableValueModel *sectionInfoObj13;
@property (strong, nonatomic) TableValueModel *sectionInfoObj14;
@property (strong, nonatomic) TableValueModel *sectionInfoObj15;
@property (strong, nonatomic) TableValueModel *sectionInfoObj16;
@property (strong, nonatomic) TableValueModel *sectionInfoObj17;
@property (strong, nonatomic) TableValueModel *sectionInfoObj18;
@property (strong, nonatomic) TableValueModel *sectionInfoObj19;

@end

@interface TableViewRowInfo : NSObject

/** 标识 */
@property (copy, nonatomic) NSString *identifier;

/** 标识 */
@property (copy, nonatomic) NSString *identifier1;

/** 标识 */
@property (copy, nonatomic) NSString *identifier2;

/**
 隐藏当前section
 */
@property (assign, nonatomic) BOOL hidden;

/**
 cell的高度
 */
@property (assign, nonatomic) CGFloat cellHeight;

/**
 需要返回cell的设置
 */
@property (copy, nonatomic) UITableViewCell * (^ cellBlock)(UITableView *tableView, NSIndexPath *indexPath, TableViewSectionInfo *sectionInfo, TableViewRowInfo *rowInfo);

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
@property (copy, nonatomic) void (^ setCellValueBlock)(id _Nonnull cell, UITableView *tableView, NSIndexPath *indexPath, TableViewSectionInfo *sectionInfo, TableViewRowInfo *rowInfo);

/**
 返回cell高度, 默认返回44.0
 */
@property (copy, nonatomic) CGFloat (^ cellHeightBlock)(UITableView *tableView, NSIndexPath *indexPath, TableViewSectionInfo *sectionInfo, TableViewRowInfo *rowInfo);

/**
 cell的点击事件
 */
@property (copy, nonatomic) void (^ didSelectBlock)(UITableView *tableView, NSIndexPath *indexPath, TableViewSectionInfo *sectionInfo, TableViewRowInfo *rowInfo);

@property (strong, nonatomic) TableValueModel *rowInfoObj0;
@property (strong, nonatomic) TableValueModel *rowInfoObj1;
@property (strong, nonatomic) TableValueModel *rowInfoObj2;
@property (strong, nonatomic) TableValueModel *rowInfoObj3;
@property (strong, nonatomic) TableValueModel *rowInfoObj4;
@property (strong, nonatomic) TableValueModel *rowInfoObj5;
@property (strong, nonatomic) TableValueModel *rowInfoObj6;
@property (strong, nonatomic) TableValueModel *rowInfoObj7;
@property (strong, nonatomic) TableValueModel *rowInfoObj8;
@property (strong, nonatomic) TableValueModel *rowInfoObj9;
@property (strong, nonatomic) TableValueModel *rowInfoObj10;
@property (strong, nonatomic) TableValueModel *rowInfoObj11;
@property (strong, nonatomic) TableValueModel *rowInfoObj12;
@property (strong, nonatomic) TableValueModel *rowInfoObj13;
@property (strong, nonatomic) TableValueModel *rowInfoObj14;
@property (strong, nonatomic) TableValueModel *rowInfoObj15;
@property (strong, nonatomic) TableValueModel *rowInfoObj16;
@property (strong, nonatomic) TableValueModel *rowInfoObj17;
@property (strong, nonatomic) TableValueModel *rowInfoObj18;
@property (strong, nonatomic) TableValueModel *rowInfoObj19;

@end

@interface TableValueModel : NSObject

/**
 对应值或者model
 */
@property (strong, nonatomic) id infoValue;

/**
 值的描述
 */
@property (copy, nonatomic) NSString *valueDescription;

/**
 添加一个备注字段
 */
@property (copy, nonatomic) NSString *noteString;

@end

NS_ASSUME_NONNULL_END
