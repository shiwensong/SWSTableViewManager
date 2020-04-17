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
@property (strong, nonatomic) UILabel *textLabel1;
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
    
    UILabel *textLabel1 = [[UILabel alloc] init];
    self.textLabel1 = textLabel1;
    [self.view addSubview:textLabel1];
    textLabel1.sd_layout
    .leftEqualToView(textField)
    .rightEqualToView(textField)
    .topSpaceToView(textLabel, kGlobalCommonLabelHeight)
    .heightIs(20);
	
	[textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
		self.inputString = x;
	}];
	
    RAC(textLabel1, text) = textField.rac_textSignal;
    RAC(textLabel1, hidden) = [textField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return [value length] > 2 ? @NO : @YES;
    }];
    
	RAC(textLabel, text) = [RACObserve(self, inputString) map:^id _Nullable(id  _Nullable value) {
//		return [@([value floatValue] * [value floatValue]) stringValue];
        return [value length] > 5 ? @"合格" : @"不合格";
	}];
}

@end
