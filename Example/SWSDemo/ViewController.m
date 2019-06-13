//
//  ViewController.m
//  SWSDemo
//
//  Created by 施文松 on 2019/4/16.
//  Copyright © 2019 施文松. All rights reserved.
//

#import "ViewController.h"
#import "NetViewController.h"
#import "InputViewController.h"
#import "PrescriptionViewController.h"
#import "TestViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) TableViewManager *manager;

@end

@implementation ViewController

- (void)rightBarButtonItemOnClick:(UIBarButtonItem *)item{
	NetViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NetViewController"];
	[self.navigationController pushViewController:vc animated:YES];
}
- (void)leftBarButtonItemOnClick:(UIBarButtonItem *)item{
	InputViewController *vc = [InputViewController new];
	[self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"首页";
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"网络" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemOnClick:)];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"输入" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemOnClick:)];

	self.tableView.separatorInset = UIEdgeInsetsZero;
	
	WS(ws);
	NSArray *list = @[
					  @[@{
							@"title" : @"处方记录",
							}],
					  @[@{
							@"title" : @"发布通知",
							},
						@{
							@"title" : @"执业点管理",
							},
						@{
							@"title" : @"我的名片",
							},
						@{
							@"title" : @"我的问卷",
							},
						@{
							@"title" : @"我的收藏",
							}],
					  @[@{
							@"title" : @"建议投诉",
							},
						@{
							@"title" : @"设置",
							}],
					  ];
	
	TableViewManager *manager = [TableViewManager createTableViewManager:self tableView:self.tableView];
	self.manager = manager;
	[TableViewManager registerClass:self.tableView withCellTypes:@[NSStringFromClass([UITableViewCell class])]];
	
	NSMutableArray *modelsArray = [NSMutableArray array];
	for(int i = 0; i < list.count; i ++){
		NSArray *array = list[i];
		TableViewSectionInfo *section = [TableViewSectionInfo new];
		section.headerHeightBlock = ^CGFloat(UITableView * _Nonnull tableViewCurrent, NSInteger currentSection, TableViewSectionInfo * _Nonnull currentSectionInfo) {
			return 10;
		};
		for (int j = 0; j < array.count; j++) {
			NSDictionary *dict = array[j];
			TableViewRowInfo *row = [TableViewRowInfo new];
			row.cellClass = NSStringFromClass([UITableViewCell class]);
			row.rowInfoObj0.infoValue = dict[@"title"];
			row.setCellValueBlock = ^(UITableViewCell * _Nonnull currentCell, UITableView * _Nonnull tableViewCurrent, NSIndexPath * _Nonnull indexPathCurrent, TableViewSectionInfo * _Nonnull sectionInfo, TableViewRowInfo * _Nonnull rowInfo) {
				currentCell.textLabel.text = dict[@"title"];
			};
			row.cellHeightBlock = ^CGFloat(UITableView * _Nonnull tableViewCurrent, NSIndexPath * _Nonnull indexPathCurrent, TableViewSectionInfo * _Nonnull currentSectionInfo, TableViewRowInfo * _Nonnull currentRowInfo) {
				return 44.0;
			};
			row.didSelectBlock = ^(UITableView * _Nonnull tableViewCurrent, NSIndexPath * _Nonnull indexPathCurrent, TableViewSectionInfo * _Nonnull currentSectionInfo, TableViewRowInfo * _Nonnull currentRowInfo) {
//				UITableViewCell *cell = [tableViewCurrent cellForRowAtIndexPath:indexPathCurrent];
				NSLog(@"点击了 == %@", currentRowInfo.rowInfoObj0.infoValue);
				if ([currentRowInfo.rowInfoObj0.infoValue isEqualToString:@"处方记录"]) {
					ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PrescriptionViewController"];
					[ws.navigationController pushViewController:vc animated:YES];
				}else if([currentRowInfo.rowInfoObj0.infoValue isEqualToString:@"发布通知"]){
					TestViewController *test = [TestViewController new];
					[ws.navigationController pushViewController:test animated:YES];
				}
			};
			[section.subRowsArray addObject:row];
		}
		[modelsArray addObject:section];
	}
	
	
	manager.groupSectionArray = modelsArray;
	
	[self createSubject];
}

-(void)dealloc
{
	NSLog(@"内存释放--%@",NSStringFromClass([self class]) );
	[[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)createSubject{
//	RACSignal *signal = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//
//		[subscriber sendNext:@"shi"];
//		[subscriber sendNext:@"wen"];
//		[subscriber sendNext:@"song"];
//		[subscriber sendCompleted];
//		return nil;
//	}] replay];
	
//	RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//
//		[subscriber sendNext:@"shi"];
//		[subscriber sendNext:@"wen"];
//		[subscriber sendNext:@"song"];
//		return nil;
//	}];

	
//	[signal subscribeNext:^(id  _Nullable x) {
//		NSLog(@"订阅者1 == %@", x);
//	}];
//
//	[signal subscribeNext:^(id  _Nullable x) {
//		NSLog(@"订阅者2 == %@", x);
//	}];
	
//	RACSubject *subject = [RACSubject subject];
//
//	[subject subscribeNext:^(id  _Nullable x) {
//		NSLog(@"订阅者1 == %@", x);
//	}];
//
//	 [subject subscribeNext:^(id  _Nullable x) {
//		NSLog(@"订阅者2 == %@", x);
//	}];
//
//	[subject sendNext:@"shi"];
//	[subject sendNext:@"wen"];
//	[subject sendNext:@"song"];
	
	
	
}

@end
