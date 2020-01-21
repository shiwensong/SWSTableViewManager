//
//  InputViewController.m
//  SWSDemo
//
//  Created by 施文松 on 2019/4/30.
//  Copyright © 2019 施文松. All rights reserved.
//

#import "InputViewController.h"

@interface InputViewController()

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UILabel *textLabel;
@property (copy, nonatomic) NSString *inputString;

@end

@implementation InputViewController

- (void)viewDidLoad{
	[super viewDidLoad];
	self.view.backgroundColor = white_Color;
	self.edgesForExtendedLayout = UIRectEdgeNone;
	self.title = @"输入";
	
	UITextField *textField = [[UITextField alloc] init];
	self.textField = textField;
	[self.view addSubview:textField];
	textField.backgroundColor = [UIColor yellowColor];
	textField.sd_layout
	.leftSpaceToView(self.view, kGlobalSpace)
	.rightSpaceToView(self.view, kGlobalSpace)
	.topSpaceToView(self.view, kGlobalCommonLabelHeight)
	.heightIs(44);

	
	UILabel *textLabel = [[UILabel alloc] init];
	self.textLabel = textLabel;
	[self.view addSubview:textLabel];
	textLabel.sd_layout
	.leftEqualToView(textField)
	.rightEqualToView(textField)
	.topSpaceToView(textField, kGlobalCommonLabelHeight)
	.heightIs(20);
	
	[textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
		self.inputString = x;
	}];
	
	RAC(textLabel, text) = [RACObserve(self, inputString) map:^id _Nullable(id  _Nullable value) {
		return [@([value floatValue] * [value floatValue]) stringValue];
	}];
}

@end
