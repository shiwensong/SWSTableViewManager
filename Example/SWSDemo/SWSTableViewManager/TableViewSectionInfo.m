//
//  TableViewGroupInfo.m
//  TableViewManagerDemo
//
//  Created by 施文松 on 2019/3/20.
//  Copyright © 2019 施文松. All rights reserved.
//

#import "TableViewSectionInfo.h"

@implementation TableViewSectionInfo

#pragma mark - Custom

- (instancetype)init
{
    self = [super init];
    if (self) {
        _headerViewHeight = 0.00001;
        _footerViewHeight = 0.00001;
        _headerBgColor = [UIColor clearColor];
        _footerBgColor = [UIColor clearColor];
    }
    return self;
}

- (NSMutableArray *)subRowsArray
{
    if (!_subRowsArray) {
        _subRowsArray = [NSMutableArray array];
    }
    return _subRowsArray;
}

- (TableValueModel *)sectionInfoObj0
{
    if (!_sectionInfoObj0) {
        _sectionInfoObj0 = [TableValueModel new];
    }
    return _sectionInfoObj0;
}

- (TableValueModel *)sectionInfoObj1
{
    if (!_sectionInfoObj1) {
        _sectionInfoObj1 = [TableValueModel new];
    }
    return _sectionInfoObj1;
}

- (TableValueModel *)sectionInfoObj2
{
    if (!_sectionInfoObj2) {
        _sectionInfoObj2 = [TableValueModel new];
    }
    return _sectionInfoObj2;
}

- (TableValueModel *)sectionInfoObj3
{
    if (!_sectionInfoObj3) {
        _sectionInfoObj3 = [TableValueModel new];
    }
    return _sectionInfoObj3;
}

- (TableValueModel *)sectionInfoObj4
{
    if (!_sectionInfoObj4) {
        _sectionInfoObj4 = [TableValueModel new];
    }
    return _sectionInfoObj4;
}

- (TableValueModel *)sectionInfoObj5
{
    if (!_sectionInfoObj5) {
        _sectionInfoObj5 = [TableValueModel new];
    }
    return _sectionInfoObj5;
}

- (TableValueModel *)sectionInfoObj6
{
    if (!_sectionInfoObj6) {
        _sectionInfoObj6 = [TableValueModel new];
    }
    return _sectionInfoObj6;
}

- (TableValueModel *)sectionInfoObj7
{
    if (!_sectionInfoObj7) {
        _sectionInfoObj7 = [TableValueModel new];
    }
    return _sectionInfoObj7;
}

- (TableValueModel *)sectionInfoObj8
{
    if (!_sectionInfoObj8) {
        _sectionInfoObj8 = [TableValueModel new];
    }
    return _sectionInfoObj8;
}

- (TableValueModel *)sectionInfoObj9
{
    if (!_sectionInfoObj9) {
        _sectionInfoObj9 = [TableValueModel new];
    }
    return _sectionInfoObj9;
}

- (TableValueModel *)sectionInfoObj10
{
    if (!_sectionInfoObj10) {
        _sectionInfoObj10 = [TableValueModel new];
    }
    return _sectionInfoObj10;
}

- (TableValueModel *)sectionInfoObj11
{
    if (!_sectionInfoObj11) {
        _sectionInfoObj11 = [TableValueModel new];
    }
    return _sectionInfoObj11;
}

- (TableValueModel *)sectionInfoObj12
{
    if (!_sectionInfoObj12) {
        _sectionInfoObj12 = [TableValueModel new];
    }
    return _sectionInfoObj12;
}

- (TableValueModel *)sectionInfoObj13
{
    if (!_sectionInfoObj13) {
        _sectionInfoObj13 = [TableValueModel new];
    }
    return _sectionInfoObj13;
}

- (TableValueModel *)sectionInfoObj14
{
    if (!_sectionInfoObj14) {
        _sectionInfoObj14 = [TableValueModel new];
    }
    return _sectionInfoObj14;
}

- (TableValueModel *)sectionInfoObj15
{
    if (!_sectionInfoObj15) {
        _sectionInfoObj15 = [TableValueModel new];
    }
    return _sectionInfoObj15;
}

- (TableValueModel *)sectionInfoObj16
{
    if (!_sectionInfoObj16) {
        _sectionInfoObj16 = [TableValueModel new];
    }
    return _sectionInfoObj16;
}

- (TableValueModel *)sectionInfoObj17
{
    if (!_sectionInfoObj17) {
        _sectionInfoObj17 = [TableValueModel new];
    }
    return _sectionInfoObj17;
}

- (TableValueModel *)sectionInfoObj18
{
    if (!_sectionInfoObj18) {
        _sectionInfoObj18 = [TableValueModel new];
    }
    return _sectionInfoObj18;
}

- (TableValueModel *)sectionInfoObj19
{
    if (!_sectionInfoObj19) {
        _sectionInfoObj19 = [TableValueModel new];
    }
    return _sectionInfoObj19;
}

@end

@implementation TableViewRowInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cellHeight = 44.0;
    }
    return self;
}

- (TableValueModel *)rowInfoObj0
{
    if (!_rowInfoObj0) {
        _rowInfoObj0 = [TableValueModel new];
    }
    return _rowInfoObj0;
}

- (TableValueModel *)rowInfoObj1
{
    if (!_rowInfoObj1) {
        _rowInfoObj1 = [TableValueModel new];
    }
    return _rowInfoObj1;
}

- (TableValueModel *)rowInfoObj2
{
    if (!_rowInfoObj2) {
        _rowInfoObj2 = [TableValueModel new];
    }
    return _rowInfoObj2;
}

- (TableValueModel *)rowInfoObj3
{
    if (!_rowInfoObj3) {
        _rowInfoObj3 = [TableValueModel new];
    }
    return _rowInfoObj3;
}

- (TableValueModel *)rowInfoObj4
{
    if (!_rowInfoObj4) {
        _rowInfoObj4 = [TableValueModel new];
    }
    return _rowInfoObj4;
}

- (TableValueModel *)rowInfoObj5
{
    if (!_rowInfoObj5) {
        _rowInfoObj5 = [TableValueModel new];
    }
    return _rowInfoObj5;
}

- (TableValueModel *)rowInfoObj6
{
    if (!_rowInfoObj6) {
        _rowInfoObj6 = [TableValueModel new];
    }
    return _rowInfoObj6;
}

- (TableValueModel *)rowInfoObj7
{
    if (!_rowInfoObj7) {
        _rowInfoObj7 = [TableValueModel new];
    }
    return _rowInfoObj7;
}

- (TableValueModel *)rowInfoObj8
{
    if (!_rowInfoObj8) {
        _rowInfoObj8 = [TableValueModel new];
    }
    return _rowInfoObj8;
}

- (TableValueModel *)rowInfoObj9
{
    if (!_rowInfoObj9) {
        _rowInfoObj9 = [TableValueModel new];
    }
    return _rowInfoObj9;
}

- (TableValueModel *)rowInfoObj10
{
    if (!_rowInfoObj10) {
        _rowInfoObj10 = [TableValueModel new];
    }
    return _rowInfoObj10;
}

- (TableValueModel *)rowInfoObj11
{
    if (!_rowInfoObj11) {
        _rowInfoObj11 = [TableValueModel new];
    }
    return _rowInfoObj11;
}

- (TableValueModel *)rowInfoObj12
{
    if (!_rowInfoObj12) {
        _rowInfoObj12 = [TableValueModel new];
    }
    return _rowInfoObj12;
}

- (TableValueModel *)rowInfoObj13
{
    if (!_rowInfoObj13) {
        _rowInfoObj13 = [TableValueModel new];
    }
    return _rowInfoObj13;
}

- (TableValueModel *)rowInfoObj14
{
    if (!_rowInfoObj14) {
        _rowInfoObj14 = [TableValueModel new];
    }
    return _rowInfoObj14;
}

- (TableValueModel *)rowInfoObj15
{
    if (!_rowInfoObj15) {
        _rowInfoObj15 = [TableValueModel new];
    }
    return _rowInfoObj15;
}

- (TableValueModel *)rowInfoObj16
{
    if (!_rowInfoObj16) {
        _rowInfoObj16 = [TableValueModel new];
    }
    return _rowInfoObj16;
}

- (TableValueModel *)rowInfoObj17
{
    if (!_rowInfoObj17) {
        _rowInfoObj17 = [TableValueModel new];
    }
    return _rowInfoObj17;
}

- (TableValueModel *)rowInfoObj18
{
    if (!_rowInfoObj18) {
        _rowInfoObj18 = [TableValueModel new];
    }
    return _rowInfoObj18;
}

- (TableValueModel *)rowInfoObj19
{
    if (!_rowInfoObj19) {
        _rowInfoObj19 = [TableValueModel new];
    }
    return _rowInfoObj19;
}

@end

@implementation TableValueModel

- (NSString *)description{
	NSString *noteStr = @"";
	if (self.noteString.length > 0) {
		noteStr = [NSString stringWithFormat:@"\nnoteString: %@", self.noteString];
	}
	NSString *str = [NSString stringWithFormat:@"infoValue: %@ \nvalueDescription: %@%@", self.infoValue, self.valueDescription, noteStr];
	return str;
}

@end

@implementation SWSHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame:self.frame];
        self.backgroundView = view;
    }
    return self;
}

@end
