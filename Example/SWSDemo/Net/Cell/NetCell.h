//
//  NetCell.h
//  SWSDemo
//
//  Created by 施文松 on 2019/4/30.
//  Copyright © 2019 施文松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (strong, nonatomic) NetModel *model;

@end

NS_ASSUME_NONNULL_END
