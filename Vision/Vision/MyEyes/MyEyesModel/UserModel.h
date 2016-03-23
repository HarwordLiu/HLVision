//
//  UesrModel.h
//  Vision
//
//  Created by Rilma.Liu on 16/3/9.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "RLBaseModel.h"

@interface UserModel : RLBaseModel

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *avatar;

@end
