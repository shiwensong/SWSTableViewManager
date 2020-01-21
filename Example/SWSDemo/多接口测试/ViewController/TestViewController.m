//
//  TestViewController.m
//  SWSDemo
//
//  Created by 施文松 on 2019/5/9.
//  Copyright © 2019 施文松. All rights reserved.
//

#import "TestViewController.h"
#import <CoreNFC/CoreNFC.h>

@interface TestViewController ()<NFCNDEFReaderSessionDelegate>

@property (strong, nonatomic) NFCNDEFReaderSession *session;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"多接口测试";
	self.view.backgroundColor = white_Color;
	
	[self createRequests];
	
	NFCNDEFReaderSession *session = [[NFCNDEFReaderSession alloc] initWithDelegate:self queue:dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT) invalidateAfterFirstRead:NO];
	self.session = session;
	[session beginSession];
}

- (void)readerSession:(nonnull NFCNDEFReaderSession *)session didDetectNDEFs:(nonnull NSArray<NFCNDEFMessage *> *)messages {
	
	for (NFCNDEFMessage *message in messages) {
		for (NFCNDEFPayload *payload in message.records) {
			NSLog(@"Payload data:%@",payload.payload);
		}
	}
}

- (void)createRequests{
	
	RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
		
		AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
		manager.requestSerializer = [AFHTTPRequestSerializer serializer];
		manager.responseSerializer = [AFHTTPResponseSerializer serializer];
		[manager GET:@"http://127.0.0.1:5004" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
			
		} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
			NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
			[subscriber sendNext:dict];
//			[subscriber sendCompleted];
		} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
			[subscriber sendError:error];
//			[subscriber sendCompleted];
		}];
		
		return [RACDisposable disposableWithBlock:^{
			NSLog(@"signal1 完成!")
		}];
	}];
	
	RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
		
		AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
		manager.requestSerializer = [AFHTTPRequestSerializer serializer];
		manager.responseSerializer = [AFHTTPResponseSerializer serializer];
		
		[manager GET:@"http://127.0.0.1:5004/home" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
			
		} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
			NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//			[subscriber sendNext:dict];
			[subscriber sendError:[NSError errorWithDomain:NSMachErrorDomain code:100 userInfo:@{@"hehe" : @"haha"}]];
//			[subscriber sendCompleted];
		} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
			[subscriber sendError:error];
//			[subscriber sendCompleted];
		}];
		
		return [RACDisposable disposableWithBlock:^{
			NSLog(@"signal2 完成!")
		}];
	}];
	
	[[signal1 merge:signal2] subscribeCompleted:^{
		NSLog(@"两个接口都结束了!");
	}];

	[[self rac_liftSelector:@selector(refreshUI::) withSignals:signal1, signal2, nil] subscribeNext:^(id  _Nullable x) {
		NSLog(@"x == %@", x);
	}];
}

- (void)refreshUI:(id)hehe :(id)hehe1{
	NSLog(@"hehe == %@", hehe);
}

@end
