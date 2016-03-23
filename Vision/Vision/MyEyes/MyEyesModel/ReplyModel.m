//
//  ReplyModel.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/9.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "ReplyModel.h"

@implementation ReplyModel

+ (NSMutableArray *)getMyEyesReplyModelFromDataArr:(NSArray *)arrAll {
    NSMutableArray *arrModel = [NSMutableArray array];
    for (NSDictionary *dic in arrAll) {
        ReplyModel *model = [ReplyModel baseModelWithDict:dic];
        [arrModel addObject:model];
    }
    return arrModel;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"user"]) {
        self.userDic = [UserModel baseModelWithDict:value];
    }
}

@end





