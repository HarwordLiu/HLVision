//
//  MyEyesCellModel.m
//  Vision
//
//  Created by Rilma.Liu on 16/2/26.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "MyEyesCellModel.h"

@implementation MyEyesCellModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _consumptionModel = [[ConsumptionModel alloc] init];
    }
    return self;
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)myEyesCellModelWithDict:(NSDictionary *)dict{
    return [[MyEyesCellModel alloc] initWithDict:dict];
}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"playInfo"]) {
        self.playInfoModel = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            PlayInfoModel *model = [PlayInfoModel baseModelWithDict:dic];
            [self.playInfoModel addObject:model];
        }
    } else if ([key isEqualToString:@"consumption"]) {
        self.consumptionModel = [ConsumptionModel baseModelWithDict:value];
    } else if ([key isEqualToString:@"description"]) {
        self.descriptionText = value;
    } else if ([key isEqualToString:@"id"]) {
        self.ID = [value integerValue];
    }
}

+ (NSMutableArray *)getEyeModelFromArr:(NSArray *)arrAll{
    NSMutableArray *arrModel = [NSMutableArray array];
    for (NSDictionary *dic in arrAll) {
        MyEyesCellModel *model = [MyEyesCellModel myEyesCellModelWithDict:dic];
        [arrModel addObject:model];
    }
    return arrModel;
}








@end




