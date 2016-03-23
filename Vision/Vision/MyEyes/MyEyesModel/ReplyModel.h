//
//  ReplyModel.h
//  Vision
//
//  Created by Rilma.Liu on 16/3/9.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "RLBaseModel.h"
#import "UserModel.h"

@interface ReplyModel : RLBaseModel


@property (nonatomic, assign) long long ID;

@property (nonatomic, copy) NSString *videoTitle;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) NSInteger videoId;

@property (nonatomic, assign) BOOL hot;

@property (nonatomic, assign) NSInteger parentReplyId;

@property (nonatomic, assign) NSInteger likeCount;

@property (nonatomic, assign) long long createTime;

@property (nonatomic, copy) NSString *replyStatus;

@property (nonatomic, assign) BOOL liked;

@property (nonatomic, assign) NSInteger sequence;

@property (nonatomic, strong) UserModel *userDic;

+ (NSMutableArray *)getMyEyesReplyModelFromDataArr:(NSArray *)arrAll;
@end


