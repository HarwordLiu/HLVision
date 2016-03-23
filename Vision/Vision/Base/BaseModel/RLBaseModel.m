//
//  RLBaseModel.m
//  Vision
//
//  Created by Rilma.Liu on 16/2/26.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "RLBaseModel.h"

@implementation RLBaseModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)baseModelWithDict:(NSDictionary *)dict{
    return [[super alloc] initWithDict:dict];
}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
