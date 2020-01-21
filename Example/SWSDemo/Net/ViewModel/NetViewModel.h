//
//  NetViewModel.h
//  SWSDemo
//
//  Created by 施文松 on 2019/5/8.
//  Copyright © 2019 施文松. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetViewModel : BaseViewModel

@property (strong, nonatomic) RACCommand *netCommand;

@end

NS_ASSUME_NONNULL_END
