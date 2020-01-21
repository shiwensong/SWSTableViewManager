//
//  UIViewController+addFresh.h
//  MakeMoney
//
//  Created by 施文松 on 15/9/15.
//  Copyright (c) 2015年 施文松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (addFresh)
@property(strong,nonatomic) UITableView * freshTablew;
-(void)addFreshPull:(id )tablew withBlock:(void (^)(id info))pullBlock;
-(void)headerEndFreshPull;
-(void)headerBeginFreshPull;
-(void)removeHeader;

-(void)addFooterFresh:(id)tablew withBlock:(void (^)(id info))pullBlock;
-(void)footerEndFreshPull;
-(void)footerBeginFreshPull;
-(void)removeFooter;
- (void)noMoreData;

@end
