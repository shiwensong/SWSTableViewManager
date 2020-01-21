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
#import "SWSAboutUsCell.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) TableViewManager *manager;

@end

@implementation ViewController

- (void)rightBarButtonItemOnClick:(UIBarButtonItem *)item{
    
    /// section的隐藏
//    int index = rand() % 3;
//    NSLog(@"index == %d", index);
//    [self.tableManager.groupSectionArray setValue:@(NO) forKeyPath:@"hidden"];
//    TableViewSectionInfo *sectionInfo = self.tableManager.groupSectionArray[index];
//    sectionInfo.hidden = YES;
    
//     rowInfo的隐藏
//    int index = rand() % 4;
//    NSLog(@"index == %d", index);
//    TableViewSectionInfo *sectionInfo = self.tableManager.groupSectionArray[1];
//    [sectionInfo.subRowsArray setValue:@(NO) forKeyPath:@"hidden"];
//    TableViewRowInfo *rowInfo = sectionInfo.subRowsArray[index];
//    rowInfo.hidden = YES;
//    [self.tableView reloadData];
    
//    // 查找section
//    TableViewSectionInfo *sectionInfo = [self.tableManager getSectionInfoWithIdentifier:@"呵呵呵"];
//    NSLog(@"sectionInfo == %@", sectionInfo);
//    TableViewRowInfo *rowInfo = [self.tableManager getRowInfoWithIdentifier:@"哈哈哈" withSectionInfo:sectionInfo];
//    NSLog(@"rowInfo == %@", rowInfo);
//    return;
    
//    删除一行然后刷新
    //    [self.tableManager.groupSectionArray removeObjectAtIndex:1];
    //    [self.tableView reloadData];
    
    // 修改一行数据后刷新
//    TableViewSectionInfo *sectionInfo = [self.tableManager getSectionInfoWithIdentifier:@"呵呵呵"];
//    TableViewRowInfo *rowInfo = [self.tableManager getRowInfoWithIdentifier:@"哈哈哈" withSectionInfo:sectionInfo];
//    rowInfo.rowInfoObj0.infoValue = @"施文松";
////    [self.tableView reloadData];
//    [self.tableManager reloadSectionData:@[sectionInfo] withRowAnimation:UITableViewRowAnimationFade];
    
    // 查找sectionInfo的位置
    TableViewSectionInfo *sectionInfo = [self.tableManager getSectionInfoWithIdentifier:@"呵呵呵"];
    NSInteger index = [self.tableManager indexOfSectionInfos:sectionInfo];
    TableViewRowInfo *rowInfo = [self.tableManager getRowInfoWithIdentifier:@"哈哈哈" withSectionInfo:sectionInfo];
    NSInteger index1 = [self.tableManager indexOfRowInfos:rowInfo withSectionInfo:sectionInfo];
    NSLog(@"index == %ld", index);
    NSLog(@"index1 == %ld", index1);
    return;
    
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	WS(ws);
	NSArray *list = @[
					  @[@{
							@"title" : @"一. 处方记录",
							}],
					  @[@{
							@"title" : @"二. 1.发布通知",
							},
						@{
							@"title" : @"2.执业点管理",
							},
						@{
							@"title" : @"3.我的名片",
							},
						@{
							@"title" : @"4.我的问卷",
							},
						@{
							@"title" : @"5.我的收藏",
							}],
					  @[@{
							@"title" : @"三. 建议投诉",
							},
						@{
							@"title" : @"设置",
							}],
                      @[
                        @{
                            @"title" : @"四. 发布通知",
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
                            },
                        @{
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
                            },
                        @{
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
                            }
                        ],
					  ];
	
	TableViewManager *manager = [TableViewManager createTableViewManager:self tableView:self.tableView];
    manager.titles = @[@"1", @"2"];
    self.tableView.sectionIndexColor = [UIColor greenColor];
	self.manager = manager;
	[TableViewManager registerClass:self.tableView withCellTypes:@[NSStringFromClass([UITableViewCell class])]];
    [TableViewManager registerNib:self.tableView withCellNibTypes:@[NSStringFromClass([SWSAboutUsCell class])]];
	
	NSMutableArray *modelsArray = [NSMutableArray array];
	for(int i = 0; i < list.count; i ++){
		NSArray *array = list[i];
		TableViewSectionInfo *section = [TableViewSectionInfo new];
        if (i == 1) {
            section.identifier = @"呵呵呵";
        }
		section.headerHeightBlock = ^CGFloat(UITableView * _Nonnull tableViewCurrent, NSInteger currentSection, TableViewSectionInfo * _Nonnull currentSectionInfo) {
			return 10;
		};
		for (int j = 0; j < array.count; j++) {
			NSDictionary *dict = array[j];
			TableViewRowInfo *row = [TableViewRowInfo new];
            if (j == 2) {
                row.identifier = @"哈哈哈";
            }
			row.cellClass = NSStringFromClass([UITableViewCell class]);
			row.rowInfoObj0.infoValue = dict[@"title"];
			row.rowInfoObj0.valueDescription = @"施文松";
			row.setCellValueBlock = ^(UITableViewCell * _Nonnull currentCell, UITableView * _Nonnull tableViewCurrent, NSIndexPath * _Nonnull indexPathCurrent, TableViewSectionInfo * _Nonnull sectionInfo, TableViewRowInfo * _Nonnull rowInfo) {
				currentCell.textLabel.text = rowInfo.rowInfoObj0.infoValue;
			};
			row.cellHeightBlock = ^CGFloat(UITableView * _Nonnull tableViewCurrent, NSIndexPath * _Nonnull indexPathCurrent, TableViewSectionInfo * _Nonnull currentSectionInfo, TableViewRowInfo * _Nonnull currentRowInfo) {
				return 44.0;
			};
			row.didSelectBlock = ^(UITableView * _Nonnull tableViewCurrent, NSIndexPath * _Nonnull indexPathCurrent, TableViewSectionInfo * _Nonnull currentSectionInfo, TableViewRowInfo * _Nonnull currentRowInfo) {
//				UITableViewCell *cell = [tableViewCurrent cellForRowAtIndexPath:indexPathCurrent];
				NSLog(@"点击了 == %@", currentRowInfo.rowInfoObj0.infoValue);
				if ([currentRowInfo.rowInfoObj0.infoValue isEqualToString:@"一. 处方记录"]) {
					ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PrescriptionViewController"];
					[ws.navigationController pushViewController:vc animated:YES];
				}else if([currentRowInfo.rowInfoObj0.infoValue isEqualToString:@"二. 1.发布通知"]){
					TestViewController *test = [TestViewController new];
					[ws.navigationController pushViewController:test animated:YES];
				}
			};
			[section.subRowsArray addObject:row];
		}
		[modelsArray addObject:section];
	}
    
    
    TableViewSectionInfo *section11 = [TableViewSectionInfo new];
    section11.headerHeightBlock = ^CGFloat(UITableView * _Nonnull tableViewCurrent, NSInteger currentSection, TableViewSectionInfo * _Nonnull currentSectionInfo) {
        return 10;
    };
    
    TableViewRowInfo *row0 = [TableViewRowInfo new];
    row0.cellClass = NSStringFromClass([SWSAboutUsCell class]);
    row0.setCellValueBlock = ^(SWSAboutUsCell  *cell, UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, TableViewSectionInfo * _Nonnull sectionInfo, TableViewRowInfo * _Nonnull rowInfo) {
        
    };
    row0.cellHeightBlock = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, TableViewSectionInfo * _Nonnull sectionInfo, TableViewRowInfo * _Nonnull rowInfo) {
        return [tableView cellHeightForIndexPath:indexPath cellClass:[SWSAboutUsCell class] cellContentViewWidth:_kWidth cellDataSetting:^(UITableViewCell *cell) {
            
        }];
    };
    [section11.subRowsArray addObject:row0];
    [modelsArray addObject:section11];

	
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
