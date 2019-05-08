//
//  TableViewManager.m
//  TableViewManagerDemo
//
//  Created by 施文松 on 2019/3/20.
//  Copyright © 2019 施文松. All rights reserved.
//

static char const * const kTableManagerKey = "kTableManagerKey";

#import "TableViewManager.h"
#import<objc/runtime.h>

@interface TableViewManager()


@end

@implementation TableViewManager

#pragma mark - LifeCycle

+ (instancetype)createTableViewManager:(NSObject *)vc tableView:(UITableView *)tableView{
	vc.tableManager = [TableViewManager new];
	tableView.dataSource = vc.tableManager;
	tableView.delegate = vc.tableManager;
	vc.tableManager.tableView = tableView;
	return vc.tableManager;
}

/**
 刷新列表
 
 @param sectionInfos 传入sectionInfos
 @param animation 刷新动画
 */
- (void)reloadSectionData:(NSArray <TableViewSectionInfo *>*)sectionInfos withRowAnimation:(UITableViewRowAnimation)animation{
	NSMutableArray *reloadIndexPaths = [NSMutableArray array];
	for(int i = 0; i < self.groupSectionArray.count; i ++ ){
		TableViewSectionInfo *sectionInfo = self.groupSectionArray[i];
		if ([sectionInfos containsObject:sectionInfo]) {
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
			[reloadIndexPaths addObject:indexPath];
		}
	}
	if (reloadIndexPaths.count > 0 && self.tableView) {
		[self.tableView reloadRowsAtIndexPaths:reloadIndexPaths withRowAnimation:animation];
	}
}

+ (instancetype)createTableViewManager{
	return [TableViewManager new];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return self.groupSectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	TableViewSectionInfo *sectionInfo = self.groupSectionArray[section];
	return sectionInfo.subRowsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	TableViewSectionInfo *sectionInfo = self.groupSectionArray[indexPath.section];
	TableViewRowInfo *rowInfo = sectionInfo.subRowsArray[indexPath.row];
	
	if (rowInfo.cellBlock) {
		return rowInfo.cellBlock(tableView, indexPath, sectionInfo, rowInfo);
	}else{
		if (self.cellBlock) {
			return self.cellBlock(tableView, indexPath, sectionInfo, rowInfo);
		}else{
			
			NSAssert(rowInfo.cellClass.length > 0, @"cellClass 必须传入，否则请实现TableViewRowInfo或者TableViewManager的cellBlock回调！");
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rowInfo.cellClass forIndexPath:indexPath];
			if (rowInfo.setCellValueBlock) {
				rowInfo.setCellValueBlock(cell, tableView , indexPath, sectionInfo, rowInfo);
			}else{
				if (self.setCellValueBlock) {
					self.setCellValueBlock(cell, tableView, indexPath, sectionInfo, rowInfo);
				}
			}
			cell.tintColor = [UIColor colorWithRed:0.07 green:0.62 blue:0.30 alpha:1.00];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
		}
	}
	
	return nil;
}

#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	/// cell被点击
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	TableViewSectionInfo *sectionInfo = self.groupSectionArray[indexPath.section];
	TableViewRowInfo *rowInfo = sectionInfo.subRowsArray[indexPath.row];
	
	if (rowInfo.didSelectBlock) {
		rowInfo.didSelectBlock(tableView, indexPath, sectionInfo, rowInfo);
	}else{
		if (self.didSelectBlock) {
			self.didSelectBlock(tableView, indexPath, sectionInfo, rowInfo);
		}else{
			// 一种实现方式都没有
		}
	}
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	TableViewSectionInfo *sectionInfo = self.groupSectionArray[indexPath.section];
	TableViewRowInfo *rowInfo = sectionInfo.subRowsArray[indexPath.row];
	if (rowInfo.cellHeightBlock) {
		return rowInfo.cellHeightBlock(tableView, indexPath, sectionInfo, rowInfo);
	}else{
		if (self.cellHeightBlock) {
			return self.cellHeightBlock(tableView, indexPath, sectionInfo, rowInfo);
		}else{
			// 都没有返回高度，使用默认高度：44
		}
	}
	return rowInfo.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	TableViewSectionInfo *sectionInfo = self.groupSectionArray[section];
	if (sectionInfo.headerHeightBlock) {
		return sectionInfo.headerHeightBlock(tableView, section, sectionInfo);
	}else{
		if (self.headerHeightBlock) {
			return self.headerHeightBlock(tableView, section, sectionInfo);
		}else{
			// 都没有实现，使用默认高度0.0001；
		}
	}
	return sectionInfo.headerViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	TableViewSectionInfo *sectionInfo = self.groupSectionArray[section];
	if (sectionInfo.footerHeightBlock) {
		return sectionInfo.footerHeightBlock(tableView, section, sectionInfo);
	}else{
		if (self.footerHeightBlock) {
			return self.footerHeightBlock(tableView, section, sectionInfo);
		}else{
			// 都没有实现，使用默认高度0.0001；
		}
	}
	return sectionInfo.footerViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	
	TableViewSectionInfo *sectionInfo = self.groupSectionArray[section];
	if (sectionInfo.headerViewBlock) {
		return sectionInfo.headerViewBlock(tableView, section, sectionInfo);
	}else{
		if (self.headerViewBlock) {
			return self.headerViewBlock(tableView, section, sectionInfo);
		}else{
			if (sectionInfo.headerViewClass.length > 0) {
				UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionInfo.headerViewClass];
				if (sectionInfo.setHeaderViewValueBlock) {
					sectionInfo.setHeaderViewValueBlock(headerView, tableView, section, sectionInfo);
				}else{
					if (self.setHeaderViewValueBlock) {
						self.setHeaderViewValueBlock(headerView, tableView , section, sectionInfo);
					}
				}
				return headerView;
			}else{
				// 没有传入headerView Class，return nil;
			}
		}
	}
	return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
	TableViewSectionInfo *sectionInfo = self.groupSectionArray[section];
	if (sectionInfo.footerViewBlock) {
		return sectionInfo.footerViewBlock(tableView, section, sectionInfo);
	}else{
		if (self.footerViewBlock) {
			return self.footerViewBlock(tableView, section, sectionInfo);
		}else{
			if (sectionInfo.footerViewClass.length > 0) {
				UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionInfo.footerViewClass];
				if (sectionInfo.setfooterViewValueBlock) {
					sectionInfo.setfooterViewValueBlock(footerView, tableView, section, sectionInfo);
				}else{
					if (self.setfooterViewValueBlock) {
						self.setfooterViewValueBlock(footerView, tableView , section, sectionInfo);
					}
				}
				return footerView;
			}else{
				// 没有传入footerView Class，return nil;
			}
		}
	}
	return nil;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (self.scrollViewDidScroll) {
		self.scrollViewDidScroll(scrollView);
	}
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
	if (self.scrollViewDidZoom) {
		self.scrollViewDidZoom(scrollView);
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	if (self.scrollViewWillBeginDragging) {
		self.scrollViewWillBeginDragging(scrollView);
	}
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
	if (self.scrollViewWillEndDragging) {
		self.scrollViewWillEndDragging(scrollView, velocity, *targetContentOffset);
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (self.scrollViewDidEndDragging) {
		self.scrollViewDidEndDragging(scrollView, decelerate);
	}
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
	if (self.scrollViewWillBeginDecelerating) {
		self.scrollViewWillBeginDecelerating(scrollView);
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	if (self.scrollViewDidEndDecelerating) {
		self.scrollViewDidEndDecelerating(scrollView);
	}
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
	if (self.scrollViewDidEndScrollingAnimation) {
		self.scrollViewDidEndScrollingAnimation(scrollView);
	}
}


- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
	if (self.viewForZoomingInScrollView) {
		return self.viewForZoomingInScrollView(scrollView);
	}
	return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {
	if (self.scrollViewWillBeginZooming) {
		self.scrollViewWillBeginZooming(scrollView, view);
	}
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
	if (self.scrollViewDidEndZooming) {
		self.scrollViewDidEndZooming(scrollView, view, scale);
	}
}


- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
	if (self.scrollViewShouldScrollToTop) {
		return self.scrollViewShouldScrollToTop(scrollView);
	}
	return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
	if (self.scrollViewDidScrollToTop) {
		self.scrollViewDidScrollToTop(scrollView);
	}
}

- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView{
	if (self.scrollViewDidChangeAdjustedContentInset) {
		self.scrollViewDidChangeAdjustedContentInset(scrollView);
	}
}

#pragma mark - Custom

- (NSMutableArray *)groupSectionArray{
	if (!_groupSectionArray) {
		_groupSectionArray = [NSMutableArray array];
	}
	return _groupSectionArray;
}


#pragma mark - Public

/**
 批量注册cell
 
 @param tableView 当前tableView
 @param cellTypes cellClass数组
 */
+ (void)registerClass:(UITableView *)tableView withCellTypes:(NSArray *)cellTypes{
	for (NSString *cellName in cellTypes) {
		[tableView registerClass:NSClassFromString(cellName) forCellReuseIdentifier:cellName];
	}
}

/**
 批量注册nib cell
 
 @param tableView 当前tableView
 @param cellNibTypes nib cell数组
 */
+ (void)registerNib:(UITableView *)tableView withCellNibTypes:(NSArray *)cellNibTypes{
	for (NSString *cellNibName in cellNibTypes) {
		[tableView registerNib:[UINib nibWithNibName:cellNibName bundle:nil] forCellReuseIdentifier:cellNibName];
	}
}

/**
 批量注册headerFooterView
 
 @param tableView 当前tableView
 @param headerFooterViewTypes headerFooterViewClass数组
 */
+ (void)registerHeaderFooterViewClass:(UITableView *)tableView withHeaderFooterViewTypes:(NSArray *)headerFooterViewTypes{
	for (NSString *headerFooterViewNibName in headerFooterViewTypes) {
		[tableView registerClass:NSClassFromString(headerFooterViewNibName) forHeaderFooterViewReuseIdentifier:headerFooterViewNibName];
	}
}

/**
 批量注册nib headerFooterView
 
 @param tableView 当前tableView
 @param headerFooterViewNibTypes headerFooterView cell数组
 */
+ (void)registerHeaderFooterViewNib:(UITableView *)tableView withHeaderFooterViewNibTypes:(NSArray *)headerFooterViewNibTypes{
	for (NSString *headerFooterViewNibName in headerFooterViewNibTypes) {
		[tableView registerNib:[UINib nibWithNibName:headerFooterViewNibName bundle:nil] forHeaderFooterViewReuseIdentifier:headerFooterViewNibName];
	}
}




@end


@implementation NSObject (TableViewManager)

- (void)setTableManager:(TableViewManager *)tableManager{
	objc_setAssociatedObject(self, kTableManagerKey, tableManager, OBJC_ASSOCIATION_RETAIN);
}

- (TableViewManager *)tableManager{
	return objc_getAssociatedObject(self, kTableManagerKey);
}

@end
