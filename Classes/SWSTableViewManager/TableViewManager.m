//
//  TableViewManager.m
//  TableViewManagerDemo
//
//  Created by 施文松 on 2019/3/20.
//  Copyright © 2019 施文松. All rights reserved.
//

static char const *const kTableManagerKey = "kTableManagerKey";

#import "TableViewManager.h"
#import<objc/runtime.h>

@interface TableViewManager ()

@property (strong, nonatomic) NSPredicate *sectionPredicate;
@property (strong, nonatomic) NSPredicate *rowPredicate;

@end

@implementation TableViewManager

#pragma mark - LifeCycle

+ (instancetype)createTableViewManager:(NSObject *)vc tableView:(UITableView *)tableView
{
    vc.tableManager = [TableViewManager new];
    tableView.dataSource = vc.tableManager;
    tableView.delegate = vc.tableManager;
    vc.tableManager.tableView = tableView;
    [tableView registerClass:[SWSHeaderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SWSHeaderFooterView class])];
    return vc.tableManager;
}

/**
 刷新Section

 @param sectionInfos 传入sectionInfos
 @param animation 刷新动画
 */
- (void)reloadSectionData:(NSArray <TableViewSectionInfo *> *)sectionInfos withRowAnimation:(UITableViewRowAnimation)animation
{
    NSAssert(sectionInfos.count > 0, @"sectionInfos不能为空!");
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for (int i = 0; i < self.groupSectionArray.count; i++) {
        TableViewSectionInfo *sectionInfo = self.groupSectionArray[i];
        if ([sectionInfos containsObject:sectionInfo]) {
            [indexSet addIndex:i];
        }
    }
    if (indexSet.count > 0 && self.tableView) {
        [self.tableView reloadSections:indexSet withRowAnimation:animation];
    }
}

/**
 刷新rowInfos

 @param rowInfos 传入rowInfos
 @param sectionInfo sectionInfo
 @param animation 刷新动画
 */
- (void)reloadRowData:(NSArray <TableViewRowInfo *> *)rowInfos withSectionInfo:(TableViewSectionInfo *)sectionInfo withRowAnimation:(UITableViewRowAnimation)animation
{
    NSAssert(rowInfos.count > 0, @"rowInfos不能为空!");
    NSAssert(sectionInfo, @"sectionInfo不能为空!");
    
    NSInteger section = [self.groupSectionArray indexOfObject:sectionInfo];
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (int i = 0; i < sectionInfo.subRowsArray.count; i ++) {
        TableViewRowInfo *rowInfo = sectionInfo.subRowsArray[i];
        if ([rowInfos containsObject:rowInfo]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
            [indexPaths addObject:indexPath];
        }
    }
    if (indexPaths.count > 0 && self.tableView) {
        [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    }
}

/// 根据identifier查找tableViewSectionInfo(多个sectionInfo)
/// @param identifier 标识
- (NSArray<TableViewSectionInfo *> *)getMoreSectionInfoWithIdentifier:(NSString *)identifier{
    NSAssert(identifier.length != 0, @"标识不能为空");
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", identifier];
    NSArray *sectionArray = [self.groupSectionArray filteredArrayUsingPredicate:predicate];
    NSAssert(sectionArray.count > 0, @"根据identifier无法查询到对应的sectionInfos!");
    return sectionArray;
}

/// 根据identifier查找tableViewSectionInfo(单个sectionInfo)
/// @param identifier 标识
- (TableViewSectionInfo *)getSectionInfoWithIdentifier:(NSString *)identifier{
    NSArray *sectionArray = [self getMoreSectionInfoWithIdentifier:identifier];
    return sectionArray.firstObject;
}

/// 根据predicate查找tableViewSectionInfo (多个sectionInfo)
/// @param predicate 谓词
- (NSArray<TableViewSectionInfo *> *)getMoreSectionInfoWithPredicate:(NSPredicate *)predicate{
    NSAssert(predicate, @"标识不能为空");
    NSArray *sectionArray = [self.groupSectionArray filteredArrayUsingPredicate:predicate];
    NSAssert(sectionArray.count > 0, @"根据predicate无法查询到对应的sectionInfos!");
    return sectionArray;
}

/// 根据predicate查找tableViewSectionInfo (单个sectionInfo)
/// @param predicate 标识
- (TableViewSectionInfo *)getSectionInfoWithPredicate:(NSPredicate *)predicate{
    NSArray *sectionArray = [self getMoreSectionInfoWithPredicate:predicate];
    return sectionArray.firstObject;
}

/// 根据identifier查找tableViewRowInfo(多个rowInfo)
/// @param identifier 标识
/// @param sectionInfo 数据源
- (NSArray<TableViewRowInfo *> *)getMoreRowInfoWithIdentifier:(NSString *)identifier
                                              withSectionInfo:(TableViewSectionInfo *)sectionInfo{
    NSAssert(identifier.length != 0, @"标识不能为空");
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", identifier];
    NSArray *subRowInfos = [sectionInfo.subRowsArray filteredArrayUsingPredicate:predicate];
    NSAssert(subRowInfos.count > 0, @"根据identifier无法查询到对应的rowInfos!");
    return subRowInfos;
}

/// 根据identifier查找tableViewRowInfo(单个RowInfos)
/// @param identifier 标识
/// @param sectionInfo 数据源
- (TableViewRowInfo *)getRowInfoWithIdentifier:(NSString *)identifier
                                              withSectionInfo:(TableViewSectionInfo *)sectionInfo{
    NSArray *sectionArray = [self getMoreRowInfoWithIdentifier:identifier withSectionInfo:sectionInfo];
    return sectionArray.firstObject;
}

/// 根据predicate查找tableViewRowInfo(多个RowInfos)
/// @param predicate 谓词
/// @param sectionInfo 数据源
- (NSArray<TableViewRowInfo *> *)getMoreRowInfoWithPredicate:(NSPredicate *)predicate
                                             withSectionInfo:(TableViewSectionInfo *)sectionInfo{
    NSAssert(predicate, @"标识不能为空");
    NSArray *subRowInfos = [sectionInfo.subRowsArray filteredArrayUsingPredicate:predicate];
    NSAssert(subRowInfos.count > 0, @"根据predicate无法查询到对应的rowInfos!");
    return subRowInfos;
}
/// 根据predicate查找tableViewRowInfo(单个RowInfos)
/// @param predicate 谓词
/// @param sectionInfo 数据源
- (TableViewRowInfo *)getRowInfoWithPredicate:(NSPredicate *)predicate
                                             withSectionInfo:(TableViewSectionInfo *)sectionInfo{
    NSArray *subRowInfos = [self getMoreRowInfoWithPredicate:predicate withSectionInfo:sectionInfo];
    return subRowInfos.firstObject;
}


/// 查找sectionInfo的index
/// @param sectionInfo 对应的组信息
- (NSInteger)indexOfSectionInfos:(TableViewSectionInfo *)sectionInfo{
    NSAssert(sectionInfo, @"sectionInfo不能为空!");
    NSInteger index = -1;
    for (int i = 0; i < self.groupSectionArray.count; i++) {
        TableViewSectionInfo *tempSectionInfo = self.groupSectionArray[i];
        if ([sectionInfo isEqual:tempSectionInfo]) {
            index = i;
            break;
        }
    }
    NSAssert(index >= 0, @"没有找到TableViewSectionInfo的index");
    return index;
}

/// 查找rowInfo的index
/// @param rowInfo 对应的行信息
/// @param sectionInfo 对应的组信息
- (NSInteger)indexOfRowInfos:(TableViewRowInfo *)rowInfo
             withSectionInfo:(TableViewSectionInfo *)sectionInfo{
    NSAssert(rowInfo, @"sectionInfo不能为空!");
    NSInteger index = -1;
    for (int i = 0; i < sectionInfo.subRowsArray.count; i++) {
        TableViewSectionInfo *tempRowInfo = sectionInfo.subRowsArray[i];
        if ([rowInfo isEqual:tempRowInfo]) {
            index = i;
            break;
        }
    }
    NSAssert(index >= 0, @"没有找到TableViewRowInfo的index");
    return index;
}

+ (instancetype)createTableViewManager
{
    return [TableViewManager new];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray *sectionInfoArray = [self.groupSectionArray filteredArrayUsingPredicate:self.sectionPredicate];
    return sectionInfoArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionInfoArray = [self.groupSectionArray filteredArrayUsingPredicate:self.sectionPredicate];
    TableViewSectionInfo *sectionInfo = sectionInfoArray[section];
    NSArray *rowInfoArray = [sectionInfo.subRowsArray filteredArrayUsingPredicate:self.rowPredicate];
    return rowInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionInfoArray = [self.groupSectionArray filteredArrayUsingPredicate:self.sectionPredicate];
    TableViewSectionInfo *sectionInfo = sectionInfoArray[indexPath.section];
    NSArray *rowInfoArray = [sectionInfo.subRowsArray filteredArrayUsingPredicate:self.rowPredicate];
    TableViewRowInfo *rowInfo = rowInfoArray[indexPath.row];
    
    if (rowInfo.cellBlock) {
        return rowInfo.cellBlock(tableView, indexPath, sectionInfo, rowInfo);
    } else {
        if (self.cellBlock) {
            return self.cellBlock(tableView, indexPath, sectionInfo, rowInfo);
        } else {
            NSAssert(rowInfo.cellClass.length > 0, @"cellClass 必须传入，否则请实现TableViewRowInfo或者TableViewManager的cellBlock回调！");
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rowInfo.cellClass forIndexPath:indexPath];
            if (rowInfo.setCellValueBlock) {
                rowInfo.setCellValueBlock(cell, tableView, indexPath, sectionInfo, rowInfo);
            } else {
                if (self.setCellValueBlock) {
                    self.setCellValueBlock(cell, tableView, indexPath, sectionInfo, rowInfo);
                }
            }
            cell.tintColor = [UIColor colorWithRed:0.07 green:0.62 blue:0.30 alpha:1.00];
            //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }

    return nil;
}


- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (self.titles.count > 0) {
        return self.titles;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    if (self.sectionForSectionIndexTitleBlock) {
        return self.sectionForSectionIndexTitleBlock(tableView, title, index);
    } else {
        // 一种实现方式都没有
        return index;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /// cell被点击
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSArray *sectionInfoArray = [self.groupSectionArray filteredArrayUsingPredicate:self.sectionPredicate];
    TableViewSectionInfo *sectionInfo = sectionInfoArray[indexPath.section];
    NSArray *rowInfoArray = [sectionInfo.subRowsArray filteredArrayUsingPredicate:self.rowPredicate];
    TableViewRowInfo *rowInfo = rowInfoArray[indexPath.row];

    if (rowInfo.didSelectBlock) {
        rowInfo.didSelectBlock(tableView, indexPath, sectionInfo, rowInfo);
    } else {
        if (self.didSelectBlock) {
            self.didSelectBlock(tableView, indexPath, sectionInfo, rowInfo);
        } else {
            // 一种实现方式都没有
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionInfoArray = [self.groupSectionArray filteredArrayUsingPredicate:self.sectionPredicate];
    TableViewSectionInfo *sectionInfo = sectionInfoArray[indexPath.section];
    NSArray *rowInfoArray = [sectionInfo.subRowsArray filteredArrayUsingPredicate:self.rowPredicate];
    TableViewRowInfo *rowInfo = rowInfoArray[indexPath.row];
    if (rowInfo.hidden) {
        return 0.000001;
    }else{
        if (rowInfo.cellHeightBlock) {
            return rowInfo.cellHeightBlock(tableView, indexPath, sectionInfo, rowInfo);
        } else {
            if (self.cellHeightBlock) {
                return self.cellHeightBlock(tableView, indexPath, sectionInfo, rowInfo);
            } else {
                // 都没有返回高度，使用默认高度：44
            }
        }
        return rowInfo.cellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSArray *sectionInfoArray = [self.groupSectionArray filteredArrayUsingPredicate:self.sectionPredicate];
    TableViewSectionInfo *sectionInfo = sectionInfoArray[section];
    if (sectionInfo.hidden) {
        return 0.000001;
    }else{
        if (sectionInfo.headerHeightBlock) {
            return sectionInfo.headerHeightBlock(tableView, section, sectionInfo);
        } else {
            if (self.headerHeightBlock) {
                return self.headerHeightBlock(tableView, section, sectionInfo);
            } else {
                // 都没有实现，使用默认高度0.0001；
            }
        }
        return sectionInfo.headerViewHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSArray *sectionInfoArray = [self.groupSectionArray filteredArrayUsingPredicate:self.sectionPredicate];
    TableViewSectionInfo *sectionInfo = sectionInfoArray[section];
    if (sectionInfo.hidden) {
        return 0.000001;
    }else{
        if (sectionInfo.footerHeightBlock) {
            return sectionInfo.footerHeightBlock(tableView, section, sectionInfo);
        } else {
            if (self.footerHeightBlock) {
                return self.footerHeightBlock(tableView, section, sectionInfo);
            } else {
                // 都没有实现，使用默认高度0.0001；
            }
        }
        return sectionInfo.footerViewHeight;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *sectionInfoArray = [self.groupSectionArray filteredArrayUsingPredicate:self.sectionPredicate];
    TableViewSectionInfo *sectionInfo = sectionInfoArray[section];
    if (sectionInfo.hidden) {
        SWSHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SWSHeaderFooterView class])];
        headerFooterView.backgroundView.backgroundColor = sectionInfo.headerBgColor;
        return headerFooterView;
    }else{
        if (sectionInfo.headerViewBlock) {
            return sectionInfo.headerViewBlock(tableView, section, sectionInfo);
        } else {
            if (self.headerViewBlock) {
                return self.headerViewBlock(tableView, section, sectionInfo);
            } else {
                if (sectionInfo.headerViewClass.length > 0) {
                    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionInfo.headerViewClass];
                    if (sectionInfo.setHeaderViewValueBlock) {
                        sectionInfo.setHeaderViewValueBlock(headerView, tableView, section, sectionInfo);
                    } else {
                        if (self.setHeaderViewValueBlock) {
                            self.setHeaderViewValueBlock(headerView, tableView, section, sectionInfo);
                        }
                    }
                    return headerView;
                } else {
                    // 没有传入headerView Class，return nil;
                }
            }
        }
        
        SWSHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SWSHeaderFooterView class])];
        headerFooterView.backgroundView.backgroundColor = sectionInfo.headerBgColor;
        return headerFooterView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSArray *sectionInfoArray = [self.groupSectionArray filteredArrayUsingPredicate:self.sectionPredicate];
    TableViewSectionInfo *sectionInfo = sectionInfoArray[section];
    if (sectionInfo.hidden) {
        SWSHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SWSHeaderFooterView class])];
        headerFooterView.backgroundView.backgroundColor = sectionInfo.footerBgColor;
        return headerFooterView;
    }else{
        if (sectionInfo.footerViewBlock) {
            return sectionInfo.footerViewBlock(tableView, section, sectionInfo);
        } else {
            if (self.footerViewBlock) {
                return self.footerViewBlock(tableView, section, sectionInfo);
            } else {
                if (sectionInfo.footerViewClass.length > 0) {
                    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionInfo.footerViewClass];
                    if (sectionInfo.setfooterViewValueBlock) {
                        sectionInfo.setfooterViewValueBlock(footerView, tableView, section, sectionInfo);
                    } else {
                        if (self.setfooterViewValueBlock) {
                            self.setfooterViewValueBlock(footerView, tableView, section, sectionInfo);
                        }
                    }
                    return footerView;
                } else {
                    // 没有传入footerView Class，return nil;
                }
            }
        }
        SWSHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SWSHeaderFooterView class])];
        headerFooterView.backgroundView.backgroundColor = sectionInfo.footerBgColor;
        return headerFooterView;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollViewDidScroll) {
        self.scrollViewDidScroll(scrollView);
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (self.scrollViewDidZoom) {
        self.scrollViewDidZoom(scrollView);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.scrollViewWillBeginDragging) {
        self.scrollViewWillBeginDragging(scrollView);
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (self.scrollViewWillEndDragging) {
        self.scrollViewWillEndDragging(scrollView, velocity, *targetContentOffset);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.scrollViewDidEndDragging) {
        self.scrollViewDidEndDragging(scrollView, decelerate);
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (self.scrollViewWillBeginDecelerating) {
        self.scrollViewWillBeginDecelerating(scrollView);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.scrollViewDidEndDecelerating) {
        self.scrollViewDidEndDecelerating(scrollView);
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (self.scrollViewDidEndScrollingAnimation) {
        self.scrollViewDidEndScrollingAnimation(scrollView);
    }
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (self.viewForZoomingInScrollView) {
        return self.viewForZoomingInScrollView(scrollView);
    }
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view
{
    if (self.scrollViewWillBeginZooming) {
        self.scrollViewWillBeginZooming(scrollView, view);
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
    if (self.scrollViewDidEndZooming) {
        self.scrollViewDidEndZooming(scrollView, view, scale);
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    if (self.scrollViewShouldScrollToTop) {
        return self.scrollViewShouldScrollToTop(scrollView);
    }
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    if (self.scrollViewDidScrollToTop) {
        self.scrollViewDidScrollToTop(scrollView);
    }
}

- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView
{
    if (self.scrollViewDidChangeAdjustedContentInset) {
        self.scrollViewDidChangeAdjustedContentInset(scrollView);
    }
}

#pragma mark - Custom

- (NSPredicate *)sectionPredicate{
    if (!_sectionPredicate) {
        _sectionPredicate = [NSPredicate predicateWithFormat:@"hidden == 0"];
    }
    return _sectionPredicate;
}

- (NSPredicate *)rowPredicate{
    if (!_rowPredicate) {
        _rowPredicate = [NSPredicate predicateWithFormat:@"hidden == 0"];
    }
    return _rowPredicate;
}

- (NSMutableArray *)groupSectionArray
{
    if (!_groupSectionArray) {
        _groupSectionArray = [NSMutableArray array];
    }
    return _groupSectionArray;
}


- (TableValueModel *)tableViewManagerObj0
{
    if (!_tableViewManagerObj0) {
        _tableViewManagerObj0 = [TableValueModel new];
    }
    return _tableViewManagerObj0;
}

- (TableValueModel *)tableViewManagerObj1
{
    if (!_tableViewManagerObj1) {
        _tableViewManagerObj1 = [TableValueModel new];
    }
    return _tableViewManagerObj1;
}

- (TableValueModel *)tableViewManagerObj2
{
    if (!_tableViewManagerObj2) {
        _tableViewManagerObj2 = [TableValueModel new];
    }
    return _tableViewManagerObj2;
}

- (TableValueModel *)tableViewManagerObj3
{
    if (!_tableViewManagerObj3) {
        _tableViewManagerObj3 = [TableValueModel new];
    }
    return _tableViewManagerObj3;
}

- (TableValueModel *)tableViewManagerObj4
{
    if (!_tableViewManagerObj4) {
        _tableViewManagerObj4 = [TableValueModel new];
    }
    return _tableViewManagerObj4;
}

- (TableValueModel *)tableViewManagerObj5
{
    if (!_tableViewManagerObj5) {
        _tableViewManagerObj5 = [TableValueModel new];
    }
    return _tableViewManagerObj5;
}

- (TableValueModel *)tableViewManagerObj6
{
    if (!_tableViewManagerObj6) {
        _tableViewManagerObj6 = [TableValueModel new];
    }
    return _tableViewManagerObj6;
}

- (TableValueModel *)tableViewManagerObj7
{
    if (!_tableViewManagerObj7) {
        _tableViewManagerObj7 = [TableValueModel new];
    }
    return _tableViewManagerObj7;
}

- (TableValueModel *)tableViewManagerObj8
{
    if (!_tableViewManagerObj8) {
        _tableViewManagerObj8 = [TableValueModel new];
    }
    return _tableViewManagerObj8;
}

- (TableValueModel *)tableViewManagerObj9
{
    if (!_tableViewManagerObj9) {
        _tableViewManagerObj9 = [TableValueModel new];
    }
    return _tableViewManagerObj9;
}

- (TableValueModel *)tableViewManagerObj10
{
    if (!_tableViewManagerObj10) {
        _tableViewManagerObj10 = [TableValueModel new];
    }
    return _tableViewManagerObj10;
}

- (TableValueModel *)tableViewManagerObj11
{
    if (!_tableViewManagerObj11) {
        _tableViewManagerObj11 = [TableValueModel new];
    }
    return _tableViewManagerObj11;
}

- (TableValueModel *)tableViewManagerObj12
{
    if (!_tableViewManagerObj12) {
        _tableViewManagerObj12 = [TableValueModel new];
    }
    return _tableViewManagerObj12;
}

- (TableValueModel *)tableViewManagerObj13
{
    if (!_tableViewManagerObj13) {
        _tableViewManagerObj13 = [TableValueModel new];
    }
    return _tableViewManagerObj13;
}

- (TableValueModel *)tableViewManagerObj14
{
    if (!_tableViewManagerObj14) {
        _tableViewManagerObj14 = [TableValueModel new];
    }
    return _tableViewManagerObj14;
}

- (TableValueModel *)tableViewManagerObj15
{
    if (!_tableViewManagerObj15) {
        _tableViewManagerObj15 = [TableValueModel new];
    }
    return _tableViewManagerObj15;
}

- (TableValueModel *)tableViewManagerObj16
{
    if (!_tableViewManagerObj16) {
        _tableViewManagerObj16 = [TableValueModel new];
    }
    return _tableViewManagerObj16;
}

- (TableValueModel *)tableViewManagerObj17
{
    if (!_tableViewManagerObj17) {
        _tableViewManagerObj17 = [TableValueModel new];
    }
    return _tableViewManagerObj17;
}

- (TableValueModel *)tableViewManagerObj18
{
    if (!_tableViewManagerObj18) {
        _tableViewManagerObj18 = [TableValueModel new];
    }
    return _tableViewManagerObj18;
}

- (TableValueModel *)tableViewManagerObj19
{
    if (!_tableViewManagerObj19) {
        _tableViewManagerObj19 = [TableValueModel new];
    }
    return _tableViewManagerObj19;
}



#pragma mark - Public

/**
 批量注册cell

 @param tableView 当前tableView
 @param cellTypes cellClass数组
 */
+ (void)registerClass:(UITableView *)tableView withCellTypes:(NSArray *)cellTypes
{
    for (NSString *cellName in cellTypes) {
        [tableView registerClass:NSClassFromString(cellName) forCellReuseIdentifier:cellName];
    }
}

/**
 批量注册nib cell

 @param tableView 当前tableView
 @param cellNibTypes nib cell数组
 */
+ (void)registerNib:(UITableView *)tableView withCellNibTypes:(NSArray *)cellNibTypes
{
    for (NSString *cellNibName in cellNibTypes) {
        [tableView registerNib:[UINib nibWithNibName:cellNibName bundle:nil] forCellReuseIdentifier:cellNibName];
    }
}

/**
 批量注册headerFooterView

 @param tableView 当前tableView
 @param headerFooterViewTypes headerFooterViewClass数组
 */
+ (void)registerHeaderFooterViewClass:(UITableView *)tableView withHeaderFooterViewTypes:(NSArray *)headerFooterViewTypes
{
    for (NSString *headerFooterViewNibName in headerFooterViewTypes) {
        [tableView registerClass:NSClassFromString(headerFooterViewNibName) forHeaderFooterViewReuseIdentifier:headerFooterViewNibName];
    }
}

/**
 批量注册nib headerFooterView

 @param tableView 当前tableView
 @param headerFooterViewNibTypes headerFooterView cell数组
 */
+ (void)registerHeaderFooterViewNib:(UITableView *)tableView withHeaderFooterViewNibTypes:(NSArray *)headerFooterViewNibTypes
{
    for (NSString *headerFooterViewNibName in headerFooterViewNibTypes) {
        [tableView registerNib:[UINib nibWithNibName:headerFooterViewNibName bundle:nil] forHeaderFooterViewReuseIdentifier:headerFooterViewNibName];
    }
}

@end

@implementation NSObject (TableViewManager)

- (void)setTableManager:(TableViewManager *)tableManager
{
    objc_setAssociatedObject(self, kTableManagerKey, tableManager, OBJC_ASSOCIATION_RETAIN);
}

- (TableViewManager *)tableManager
{
    return objc_getAssociatedObject(self, kTableManagerKey);
}

@end
