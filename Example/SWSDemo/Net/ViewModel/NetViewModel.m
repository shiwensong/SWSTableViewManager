//
//  NetViewModel.m
//  SWSDemo
//
//  Created by 施文松 on 2019/5/8.
//  Copyright © 2019 施文松. All rights reserved.
//

#import "NetViewModel.h"
#import "NetModel.h"
#import "NetCell.h"

@implementation NetViewModel

- (RACCommand *)netCommand{
	if (!_netCommand) {
		_netCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
			return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
				WS(ws);
				AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
				manager.requestSerializer = [AFHTTPRequestSerializer serializer];
				manager.responseSerializer = [AFHTTPResponseSerializer serializer];
				
				NSLog(@"page == %ld", (long)self.page);
				NSString *url = @"http://music.163.com/api/v1/resource/comments/R_SO_4_186436";
				NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
				[dict1 setObject:@"20" forKey:@"limit"];
				if (self.isHeader) {
					self.page = 1;
				}else{
					self.page += 1;
				}
				
				[dict1 setObject:[@(self.page) stringValue] forKey:@"offset"];
				
				NSLog(@"dict == %@", dict1);
				[manager GET:url parameters:dict1 progress:^(NSProgress * _Nonnull downloadProgress) {
					
				} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
					NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
					if ([dict[@"code"] integerValue] == 200)  {
						NSArray *comments = dict[@"comments"];
						
						if (ws.isHeader) {
							[ws.modelsArray removeAllObjects];
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
							
							[self.modelsArray addObject:info];
						}
						
						if (comments.count >= 20 && ws.isHeader) {
							[self.viewController addFooterFresh:self.tableView withBlock:^(id info) {
								self.isHeader = NO;
								[self.netCommand execute:@""];
							}];
						}
						
						[subscriber sendNext:self.modelsArray];
						[subscriber sendCompleted];
						[self endFresh];
					}else{
						[subscriber sendCompleted];
						[self endFresh];
					}
					
				} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
					NSLog(@"erro == %@", error);
					[subscriber sendError:error];
					[subscriber sendCompleted];
					[self endFresh];
				}];
				
				return [RACDisposable disposableWithBlock:^{
					NSLog(@"NetViewModel -- netCommand -- RACDisposable执行完成")
				}];
			}];
		}];
	}
	return _netCommand;
}

- (void)endFresh{
	if (self.isHeader) {
		[self.viewController headerEndFreshPull];
	}else{
		[self.viewController footerEndFreshPull];
	}
}

@end
