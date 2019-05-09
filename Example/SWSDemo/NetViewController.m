//
//  NetViewController.m
//  SWSDemo
//
//  Created by 施文松 on 2019/4/16.
//  Copyright © 2019 施文松. All rights reserved.
//

#import "NetViewController.h"
#import "HeaderCell.h"
#import "ViewController.h"
#import "NetCell.h"
#import "NetModel.h"
#import "NetViewModel.h"


@interface NetViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) BOOL isHeader;
@property (assign, nonatomic) NSInteger page;
@property (strong, nonatomic) TableViewSectionInfo *section;
//@property (strong, nonatomic) TableViewManager *manager;
@end

@implementation NetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"张国荣";
	self.isHeader = YES;
	self.page = 1;
	

	WS(ws);
	[TableViewManager registerClass:self.tableView withCellTypes:@[NSStringFromClass([UITableViewCell class])]];
	[TableViewManager registerNib:self.tableView withCellNibTypes:@[NSStringFromClass([HeaderCell class])]];
	[TableViewManager registerNib:self.tableView withCellNibTypes:@[NSStringFromClass([NetCell class])]];
	
	[TableViewManager createTableViewManager:self tableView:self.tableView];
	
	self.tableManager.didSelectBlock = ^(UITableView * _Nonnull tableViewCurrent, NSIndexPath * _Nonnull indexPathCurrent, TableViewSectionInfo * _Nonnull currentSectionInfo, TableViewRowInfo * _Nonnull currentRowInfo) {
//		if (indexPathCurrent.section == 0) {
//			NSLog(@"点击了headerCell");
//		}else if(indexPathCurrent.section == 1){
//			NSLog(@"点击了姓名cell == %@", currentRowInfo.rowInfoValue0);
//		}
		if ([currentRowInfo.cellClass isEqualToString:NSStringFromClass([HeaderCell class])]) {
			NSLog(@"点击了headerCell");
		}else if ([currentRowInfo.cellClass isEqualToString:NSStringFromClass([UITableViewCell class])]){
			NSLog(@"点击了姓名cell == %@", currentRowInfo.rowInfoValue0[@"user"][@"nickname"]);
			ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
			[ws.navigationController pushViewController:vc animated:YES];
		}
	};
	
	TableViewSectionInfo *section0 = [TableViewSectionInfo new];
	TableViewRowInfo *row00 = [TableViewRowInfo new];
	row00.cellClass = NSStringFromClass([HeaderCell class]);
	row00.setCellValueBlock = ^(UITableViewCell * _Nonnull currentCell, UITableView * _Nonnull tableViewCurrent, NSIndexPath * _Nonnull indexPathCurrent, TableViewSectionInfo * _Nonnull sectionInfo, TableViewRowInfo * _Nonnull rowInfo) {
		currentCell.selectionStyle = UITableViewCellSelectionStyleNone;
	};
	
	row00.cellHeightBlock = ^CGFloat(UITableView * _Nonnull tableViewCurrent, NSIndexPath * _Nonnull indexPathCurrent, TableViewSectionInfo * _Nonnull currentSectionInfo, TableViewRowInfo * _Nonnull currentRowInfo) {
		return 100;
	};
	
//	row00.didSelectBlock = ^(UITableView * _Nonnull tableViewCurrent, NSIndexPath * _Nonnull indexPathCurrent, TableViewSectionInfo * _Nonnull currentSectionInfo, TableViewRowInfo * _Nonnull currentRowInfo) {
//		NSLog(@"点击了headerCell");
//	};
	
	[section0.subRowsArray addObject:row00];
	
	
	TableViewSectionInfo *section = [TableViewSectionInfo new];
	self.section = section;
	self.tableManager.groupSectionArray = [NSMutableArray arrayWithObjects:section0, section, nil];
	
	
//	[self addFreshPull:self.tableView withBlock:^(id info) {
//		ws.isHeader = YES;
//		[ws getList];
//	}];
	NetViewModel *viewModel = [[NetViewModel alloc] initWithVC:self withTableView:self.tableView];
	[self addFreshPull:self.tableView withBlock:^(id info) {
		viewModel.isHeader = YES;
		[viewModel.netCommand execute:@""];
	}];
	
	[[viewModel.netCommand.executionSignals.switchToLatest takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSArray *x) {
//		NSLog(@"x == %@", x);
		[ws.section.subRowsArray removeAllObjects];
		ws.section.subRowsArray = [NSMutableArray arrayWithArray:x];
//		if (x.count >= 20 && ws.isHeader) {
//			[ws addFooterFresh:ws.tableView withBlock:^(id info) {
//				viewModel.isHeader = NO;
//				[viewModel.netCommand execute:@""];
//			}];
//		}
		[ws.tableView reloadData];
//		if (ws.isHeader) {
//			[ws headerEndFreshPull];
//		}else{
//			[ws footerEndFreshPull];
//		}
	}];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	if (self.section.subRowsArray.count == 0) {
		[self headerBeginFreshPull];
	}
}

- (void)getList{
	WS(ws);
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.requestSerializer = [AFHTTPRequestSerializer serializer];
	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	
	NSLog(@"page == %ld", (long)self.page);
	NSString *url = @"http://music.163.com/api/v1/resource/comments/R_SO_4_186436";
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	[dict setObject:@"20" forKey:@"limit"];
	if (self.isHeader) {
		self.page = 1;
	}else{
		self.page += 1;
	}
	
	[dict setObject:[@(self.page) stringValue] forKey:@"offset"];
	
	NSLog(@"dict == %@", dict);
	[manager GET:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
		NSArray *comments = dict[@"comments"];
		
		if (ws.isHeader) {
			[ws.section.subRowsArray removeAllObjects];
		}else{
			
		}
		
		for (int i = 0; i < comments.count; i++) {
			NSDictionary *tempDict = comments[i];
			NetModel *netModel = [NetModel mj_objectWithKeyValues:tempDict];
			
			TableViewRowInfo *info = [TableViewRowInfo new];
			info.cellClass = NSStringFromClass([NetCell class]);
			info.rowInfoValue0 = netModel;
			info.setCellValueBlock = ^(UITableViewCell * _Nonnull currentCell, UITableView * _Nonnull tableViewCurrent, NSIndexPath * _Nonnull indexPathCurrent, TableViewSectionInfo * _Nonnull sectionInfo, TableViewRowInfo * _Nonnull rowInfo) {
				NetCell *netCell = (NetCell *)currentCell;
				netCell.model = rowInfo.rowInfoValue0;
			};
			info.cellHeightBlock = ^CGFloat(UITableView * _Nonnull tableViewCurrent, NSIndexPath * _Nonnull indexPathCurrent, TableViewSectionInfo * _Nonnull currentSectionInfo, TableViewRowInfo * _Nonnull currentRowInfo) {
				return [tableViewCurrent cellHeightForIndexPath:indexPathCurrent model:currentRowInfo.rowInfoValue0 keyPath:@"model" cellClass:[NetCell class] contentViewWidth:_kWidth];
			};
//			info.didSelectBlock = ^(UITableView * _Nonnull tableViewCurrent, NSIndexPath * _Nonnull indexPathCurrent, TableViewSectionInfo * _Nonnull currentSectionInfo, TableViewRowInfo * _Nonnull currentRowInfo) {
//				NSLog(@"点击了cell");
//			};
			[ws.section.subRowsArray addObject:info];
		}
		
		
		if (comments.count >= 20 && ws.isHeader) {
			[ws addFooterFresh:ws.tableView withBlock:^(id info) {
				ws.isHeader = NO;
				[ws getList];
			}];
		}
		[ws.tableView reloadData];
		if (ws.isHeader) {
			[ws headerEndFreshPull];
		}else{
			[ws footerEndFreshPull];
		}
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		NSLog(@"erro == %@", error);
		if (ws.isHeader) {
			[ws headerEndFreshPull];
		}else{
			[ws footerEndFreshPull];
		}
	}];
}

- (void)dealloc{
	NSLog(@"%@ -- 释放了", NSStringFromClass([self class]));
}

@end
