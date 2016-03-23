//
//  ColumnEyesModel.m
//  Vision
//
//  Created by Rilma.Liu on 16/2/26.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "ColumnEyesModel.h"

@implementation ColumnEyesModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
+ (NSMutableArray *)getColumnEyesModelFromArr:(NSArray *)arrAll {
    NSMutableArray *arrModel = [NSMutableArray array];
    for (NSDictionary *dic in arrAll) {
        ColumnEyesModel *model = [ColumnEyesModel baseModelWithDict:dic];
        [arrModel addObject:model];
    }
    return arrModel;
}

@end
