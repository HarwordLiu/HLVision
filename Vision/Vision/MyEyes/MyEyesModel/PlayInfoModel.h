//
//  PlayInfoModel.h
//  Vision
//
//  Created by Rilma.Liu on 16/2/26.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "RLBaseModel.h"

@interface PlayInfoModel : RLBaseModel

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, copy) NSString *name;



@end
