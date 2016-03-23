//
//  MyEyesSectionModel.m
//  Vision
//
//  Created by Rilma.Liu on 16/2/26.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "MyEyesSectionModel.h"

@implementation MyEyesSectionModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.videoListModel = [NSMutableArray array];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"videoList"]) {
        self.videoListModel = [MyEyesCellModel getEyeModelFromArr:value];
    }
}

+ (NSMutableArray *)getMyEyesSectionModelFromDataArr:(NSArray *)arrAll {
    NSMutableArray *arrModel = [NSMutableArray array];
    for (NSDictionary *dic in arrAll) {
        MyEyesSectionModel *model = [MyEyesSectionModel baseModelWithDict:dic];
        [arrModel addObject:model];
    }
    return arrModel;
}


@end
