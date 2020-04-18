//
//  UITableViewCell+sectionRowInfo.h
//  SWSDemo
//
//  Created by 施文松 on 2020年4月17日 Friday.
//  Copyright © 2020 施文松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewSectionInfo.h"
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (sectionRowInfo)

- (void)setCellValue;

//@property (strong, nonatomic) TableViewSectionInfo *sectionInfo;
//
//@property (strong, nonatomic) TableViewRowInfo *rowInfo;

/// 要注意没有可能没有值
- (void)setSectionInfo:(TableViewSectionInfo * _Nonnull)sectionInfo;
/// 要注意可能没有值
- (void)setRowInfo:(TableViewRowInfo * _Nonnull)rowInfo;

- (TableViewRowInfo * _Nonnull)rowInfo;

- (TableViewSectionInfo * _Nonnull)sectionInfo;

@end

NS_ASSUME_NONNULL_END
