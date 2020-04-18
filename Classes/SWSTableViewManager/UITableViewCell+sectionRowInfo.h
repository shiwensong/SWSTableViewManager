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

/// 要注意没有可能没有值
@property (strong, nonatomic) TableViewSectionInfo *sectionInfo;

/// 要注意可能没有值
@property (strong, nonatomic) TableViewRowInfo *rowInfo;

@end

NS_ASSUME_NONNULL_END
