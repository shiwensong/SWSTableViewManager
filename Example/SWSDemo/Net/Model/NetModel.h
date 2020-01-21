//
//  NetModel.h
//  SWSDemo
//
//  Created by 施文松 on 2019/4/30.
//  Copyright © 2019 施文松. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BeReplied :NSObject

@end

@interface Associator :NSObject
@property (nonatomic , assign) NSInteger              vipCode;
@property (nonatomic , assign) BOOL              rights;

@end

@interface VipRights :NSObject
@property (nonatomic , strong) Associator              * associator;
@property (nonatomic , copy) NSString              * musicPackage;
@property (nonatomic , assign) NSInteger              redVipAnnualCount;

@end

@interface User :NSObject
@property (nonatomic , assign) NSInteger              authStatus;
@property (nonatomic , copy) NSString              * experts;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , assign) NSInteger              vipType;
@property (nonatomic , copy) NSString              * avatarUrl;
@property (nonatomic , copy) NSString              * expertTags;
@property (nonatomic , copy) NSString              * remarkName;
@property (nonatomic , strong) VipRights              * vipRights;
@property (nonatomic , copy) NSString              * locationInfo;
@property (nonatomic , assign) NSInteger              userType;

@end

@interface NetModel :NSObject
@property (nonatomic , assign) NSInteger              commentId;
@property (nonatomic , assign) BOOL              repliedMark;
@property (nonatomic , copy) NSString              * expressionUrl;
@property (nonatomic , strong) NSArray<BeReplied *>              * beReplied;
@property (nonatomic , assign) NSInteger              commentLocationType;
@property (nonatomic , assign) NSInteger              parentCommentId;
@property (nonatomic , copy) NSString*              likedCount;
@property (nonatomic , copy) NSString*              time;
@property (nonatomic , copy) NSString              * showFloorComment;
@property (nonatomic , copy) NSString              * pendantData;
@property (nonatomic , copy) NSString              * decoration;
@property (nonatomic , assign) BOOL              liked;
@property (nonatomic , strong) User              * user;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * content;

@end

NS_ASSUME_NONNULL_END
