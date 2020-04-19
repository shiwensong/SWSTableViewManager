//
//  UITableViewCell+sectionRowInfo.m
//  SWSDemo
//
//  Created by 施文松 on 2020年4月17日 Friday.
//  Copyright © 2020 施文松. All rights reserved.
//

#import "UITableViewCell+sectionRowInfo.h"

static char const * const kSectionInfoKey = "kSectionInfoKey";
static char const * const kRowInfoKey = "kRowInfoKey";


@implementation UITableViewCell (sectionRowInfo)

- (void)sws_setCellValue{
    
}

- (void)setSectionInfo:(TableViewSectionInfo *)sectionInfo{
    objc_setAssociatedObject(self, kSectionInfoKey, sectionInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TableViewSectionInfo *)sectionInfo{
    return objc_getAssociatedObject(self, kSectionInfoKey);
}

- (void)setRowInfo:(TableViewRowInfo *)rowInfo{
    objc_setAssociatedObject(self, kRowInfoKey, rowInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TableViewRowInfo *)rowInfo{
    return objc_getAssociatedObject(self, kRowInfoKey);
}

@end
