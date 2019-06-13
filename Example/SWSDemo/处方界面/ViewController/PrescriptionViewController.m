//
//  PrescriptionViewController.m
//  SWSDemo
//
//  Created by 施文松 on 2019/5/5.
//  Copyright © 2019 施文松. All rights reserved.
//

#import "PrescriptionViewController.h"
#import "PrescriptionHeaderCell.h"
#import "PresSectionHeaderCell.h"
#import "PresAddressCell.h"
#import "InfoCell.h"
#import "ContentwCell.h"

@interface PrescriptionViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) TableViewRowInfo *row00;
@property (strong, nonatomic) TableViewSectionInfo *section0;

@end

@implementation PrescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.navigationController.navigationBar.translucent = YES;
	[self createTableViewInfo];
}

- (void)createTableViewInfo{
	self.tableView.separatorInset = UIEdgeInsetsZero;
	
	[TableViewManager createTableViewManager:self tableView:self.tableView];
	[TableViewManager registerNib:self.tableView withCellNibTypes:@[NSStringFromClass([PrescriptionHeaderCell class])]];
	[TableViewManager registerNib:self.tableView withCellNibTypes:@[NSStringFromClass([PresSectionHeaderCell class])]];
	[TableViewManager registerNib:self.tableView withCellNibTypes:@[NSStringFromClass([PresAddressCell class])]];
	[TableViewManager registerNib:self.tableView withCellNibTypes:@[NSStringFromClass([InfoCell class])]];
	[TableViewManager registerNib:self.tableView withCellNibTypes:@[NSStringFromClass([ContentwCell class])]];

	self.tableManager.setCellValueBlock = ^(UITableViewCell * _Nonnull cell, UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, TableViewSectionInfo * _Nonnull sectionInfo, TableViewRowInfo * _Nonnull rowInfo) {
		if ([cell isKindOfClass:[PresSectionHeaderCell class]]) {
			PresSectionHeaderCell *presCell = (PresSectionHeaderCell *)cell;
			presCell.titleLabel.text = rowInfo.rowInfoObj0.infoValue;
		}else if ([cell isKindOfClass:[ContentwCell class]]){
			ContentwCell *contentCell = (ContentwCell *)cell;
			contentCell.contentLabel.text = rowInfo.rowInfoObj0.infoValue;
			contentCell.contentLabel.textColor = rowInfo.rowInfoObj1.infoValue;
		}
	};
	
	self.tableManager.cellHeightBlock = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, TableViewSectionInfo * _Nonnull sectionInfo, TableViewRowInfo * _Nonnull rowInfo) {
		if ([rowInfo.cellClass isEqualToString:NSStringFromClass([PresSectionHeaderCell class])]) {
			CGFloat height = [tableView cellHeightForIndexPath:indexPath cellClass:[PresSectionHeaderCell class] cellContentViewWidth:_kWidth cellDataSetting:^(UITableViewCell *cell) {
				
			}];
			return height;
		}else if ([rowInfo.cellClass isEqualToString:NSStringFromClass([ContentwCell class])]) {
			return [tableView cellHeightForIndexPath:indexPath cellClass:[ContentwCell class] cellContentViewWidth:_kWidth cellDataSetting:^(UITableViewCell *cell) {
				ContentwCell *contentCell = (ContentwCell *)cell;
				contentCell.contentLabel.text = rowInfo.rowInfoObj0.infoValue;
			}];
		}

		return rowInfo.cellHeight;
	};
	
	
	//MARK: - 第0组
	TableViewSectionInfo *section0 = [TableViewSectionInfo new];
	TableViewRowInfo *row00 = [TableViewRowInfo new];
	self.row00 = row00;
	self.section0 = section0;
	row00.rowInfoObj0.infoValue = @"已付款";
	row00.cellClass = NSStringFromClass([PrescriptionHeaderCell class]);
	row00.setCellValueBlock = ^(PrescriptionHeaderCell *cell, UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, TableViewSectionInfo * _Nonnull sectionInfo, TableViewRowInfo * _Nonnull rowInfo) {
		cell.statusLabel.text = rowInfo.rowInfoObj0.infoValue;
	};
	row00.cellHeightBlock = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, TableViewSectionInfo * _Nonnull sectionInfo, TableViewRowInfo * _Nonnull rowInfo) {
		return [tableView cellHeightForIndexPath:indexPath cellClass:[PrescriptionHeaderCell class] cellContentViewWidth:_kWidth cellDataSetting:^(UITableViewCell *cell) {
			
		}];
	};
	
	TableViewRowInfo *row01 = [TableViewRowInfo new];
	row01.cellClass = NSStringFromClass([PresSectionHeaderCell class]);
	row01.rowInfoObj0.infoValue = @"收货信息";
	
	TableViewRowInfo *row02 = [TableViewRowInfo new];
	row02.cellClass = NSStringFromClass([PresAddressCell class]);
	row02.setCellValueBlock = ^(PresAddressCell *addressCell, UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, TableViewSectionInfo * _Nonnull sectionInfo, TableViewRowInfo * _Nonnull rowInfo) {
		addressCell.peopleLabel.text = @"收货人: 施文松  19923286028";
		addressCell.addressLabel.text=  @"重庆市沙坪坝区金阳牛津街";
	};
	row02.cellHeightBlock = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, TableViewSectionInfo * _Nonnull sectionInfo, TableViewRowInfo * _Nonnull rowInfo) {
		CGFloat height = [tableView cellHeightForIndexPath:indexPath cellClass:[PresAddressCell class] cellContentViewWidth:_kWidth cellDataSetting:^(UITableViewCell *cell) {
			PresAddressCell *addressCell = (PresAddressCell *)cell;
			addressCell.peopleLabel.text = @"收货人: 施文松  19923286028";
			addressCell.addressLabel.text=  @"重庆市沙坪坝区金阳牛津街";
		}];
		return height;
	};
	
	[section0.subRowsArray addObject:row00];
	[section0.subRowsArray addObject:row01];
	[section0.subRowsArray addObject:row02];
	
	//MARK: - 第1组
	TableViewSectionInfo *section1 = [TableViewSectionInfo new];
	section1.headerHeightBlock = ^CGFloat(UITableView * _Nonnull tableView, NSInteger section, TableViewSectionInfo * _Nonnull sectionInfo) {
		return 10;
	};
	
	TableViewRowInfo *row10 = [TableViewRowInfo new];
	row10.cellClass = NSStringFromClass([PresSectionHeaderCell class]);
	row10.rowInfoObj0.infoValue = @"患者信息";
	
	[section1.subRowsArray addObject:row10];

	NSArray *infoList = @[@"患者姓名", @"性别", @"年龄", @"门诊科室", @"开放时间"];
	NSArray *info1List = @[@"施文松", @"男", @"25", @"骨科", @"2019-01-08 14:10:21"];
	for (int i = 0; i < infoList.count; i ++) {
		TableViewRowInfo *row11 = [TableViewRowInfo new];
		row11.cellClass = NSStringFromClass([InfoCell class]);
		row11.rowInfoObj0.infoValue = infoList[i];
		row11.rowInfoObj1.infoValue = info1List[i];
		row11.setCellValueBlock = ^(InfoCell *cell, UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, TableViewSectionInfo * _Nonnull sectionInfo, TableViewRowInfo * _Nonnull rowInfo) {
			cell.titlelabel.text = rowInfo.rowInfoObj0.infoValue;
			cell.subTitleLabel.text = rowInfo.rowInfoObj1.infoValue;
		};
		row11.cellHeightBlock = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, TableViewSectionInfo * _Nonnull sectionInfo, TableViewRowInfo * _Nonnull rowInfo) {
			return [tableView cellHeightForIndexPath:indexPath cellClass:[InfoCell class] cellContentViewWidth:_kWidth cellDataSetting:^(UITableViewCell *cell) {
				
			}];
		};
		[section1.subRowsArray addObject:row11];
	}
	
	
	
	//MARK: - 第2组
	TableViewSectionInfo *section2 = [TableViewSectionInfo new];
	section2.headerHeightBlock = ^CGFloat(UITableView * _Nonnull tableView, NSInteger section, TableViewSectionInfo * _Nonnull sectionInfo) {
		return 10;
	};
	
	TableViewRowInfo *row20 = [TableViewRowInfo new];
	row20.cellClass = NSStringFromClass([PresSectionHeaderCell class]);
	row20.rowInfoObj0.infoValue = @"诊断";
	
	[section2.subRowsArray addObject:row20];

	TableViewRowInfo *row21 = [TableViewRowInfo new];
	row21.cellClass = NSStringFromClass([ContentwCell class]);
	row21.rowInfoObj0.infoValue = @"感冒发烧了,建议多喝热水!";
	row21.rowInfoObj1.infoValue = [UIColor blackColor];
	[section2.subRowsArray addObject:row21];

	
	//MARK: - 第3组
	TableViewSectionInfo *section3 = [TableViewSectionInfo new];
	section3.headerHeightBlock = ^CGFloat(UITableView * _Nonnull tableView, NSInteger section, TableViewSectionInfo * _Nonnull sectionInfo) {
		return 10;
	};
	
	TableViewRowInfo *row30 = [TableViewRowInfo new];
	row30.cellClass = NSStringFromClass([PresSectionHeaderCell class]);
	row30.rowInfoObj0.infoValue = @"R";
	
	[section3.subRowsArray addObject:row30];
	
	//MARK: - 第4组
	TableViewSectionInfo *section4 = [TableViewSectionInfo new];
	section4.headerHeightBlock = ^CGFloat(UITableView * _Nonnull tableView, NSInteger section, TableViewSectionInfo * _Nonnull sectionInfo) {
		return 10;
	};

	TableViewRowInfo *row40 = [TableViewRowInfo new];
	row40.cellClass = NSStringFromClass([PresSectionHeaderCell class]);
	row40.rowInfoObj0.infoValue = @"药品费用";

	[section4.subRowsArray addObject:row40];

	TableViewRowInfo *row41 = [TableViewRowInfo new];
	row41.cellClass = NSStringFromClass([ContentwCell class]);
	row41.rowInfoObj0.infoValue = @"$0.01";
	row41.rowInfoObj1.infoValue = [UIColor redColor];
	[section4.subRowsArray addObject:row41];
	
	//MARK: - 第5组
	TableViewSectionInfo *section5 = [TableViewSectionInfo new];
	section5.headerHeightBlock = ^CGFloat(UITableView * _Nonnull tableView, NSInteger section, TableViewSectionInfo * _Nonnull sectionInfo) {
		return 10;
	};

	TableViewRowInfo *row50 = [TableViewRowInfo new];
	row50.cellClass = NSStringFromClass([PresSectionHeaderCell class]);
	row50.rowInfoObj0.infoValue = @"医生签名";

	[section5.subRowsArray addObject:row50];

	TableViewRowInfo *row51 = [TableViewRowInfo new];
	row51.cellClass = NSStringFromClass([ContentwCell class]);
	row51.rowInfoObj0.infoValue = @"医事通测试额,勿点";
	row51.rowInfoObj1.infoValue = [UIColor blackColor];
	[section5.subRowsArray addObject:row51];

	//MARK: - 第6组
	TableViewSectionInfo *section6 = [TableViewSectionInfo new];
	section6.headerViewHeight = 10;

	TableViewRowInfo *row60 = [TableViewRowInfo new];
	row60.cellClass = NSStringFromClass([PresSectionHeaderCell class]);
	row60.rowInfoObj0.infoValue = @"药师签名";

	[section6.subRowsArray addObject:row60];

	TableViewRowInfo *row61 = [TableViewRowInfo new];
	row61.cellClass = NSStringFromClass([ContentwCell class]);
	row61.rowInfoObj0.infoValue = @"药师审方后签名";
	row61.rowInfoObj1.infoValue = [UIColor blackColor];
	[section6.subRowsArray addObject:row61];
	
	//MARK: - 第7组
	TableViewSectionInfo *section7 = [TableViewSectionInfo new];
	section7.headerViewHeight = 10;
	
	TableViewRowInfo *row70 = [TableViewRowInfo new];
	row70.cellClass = NSStringFromClass([PresSectionHeaderCell class]);
	row70.rowInfoObj0.infoValue = @"取货方式";
	
	[section7.subRowsArray addObject:row70];
	
	TableViewRowInfo *row71 = [TableViewRowInfo new];
	row71.cellClass = NSStringFromClass([ContentwCell class]);
	row71.rowInfoObj0.infoValue = @"药师审方后签名";
	row71.rowInfoObj1.infoValue = [UIColor blackColor];
	[section7.subRowsArray addObject:row71];
	
	//MARK: - 第8组
	TableViewSectionInfo *section8 = [TableViewSectionInfo new];
	section8.headerViewHeight = 2;

	TableViewRowInfo *row80 = [TableViewRowInfo new];
	row80.cellClass = NSStringFromClass([PresSectionHeaderCell class]);
	row80.rowInfoObj0.infoValue = @"无";

	[section8.subRowsArray addObject:row80];

	TableViewRowInfo *row81 = [TableViewRowInfo new];
	row81.cellClass = NSStringFromClass([ContentwCell class]);
	row81.rowInfoObj0.infoValue = @"在线支付";
	row81.rowInfoObj1.infoValue = [UIColor blackColor];
	[section8.subRowsArray addObject:row81];
	
	self.tableManager.groupSectionArray = [NSMutableArray arrayWithObjects:section0, section1, section2, section3, section4, section5, section6, section7, section8, nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	[super touchesBegan:touches withEvent:event];
	
	self.row00.rowInfoObj0.infoValue = @"施文松";
	
	[self.tableManager reloadSectionData:@[self.section0] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)dealloc
{
	NSLog(@"内存释放--%@",NSStringFromClass([self class]) );
	[[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
