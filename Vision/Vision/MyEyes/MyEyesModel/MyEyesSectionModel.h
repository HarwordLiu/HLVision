//
//  MyEyesSectionModel.h
//  Vision
//
//  Created by Rilma.Liu on 16/2/26.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "RLBaseModel.h"
#import "MyEyesCellModel.h"

@interface MyEyesSectionModel : RLBaseModel

@property (nonatomic, assign) NSInteger date;
@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSMutableArray<MyEyesCellModel *> *videoListModel;

+ (NSMutableArray *)getMyEyesSectionModelFromDataArr:(NSArray *)arrAll;

@end
