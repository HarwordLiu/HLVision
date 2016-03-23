//
//  ColumnEyesModel.h
//  Vision
//
//  Created by Rilma.Liu on 16/2/26.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "RLBaseModel.h"

@interface ColumnEyesModel : RLBaseModel

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *alias;
@property (nonatomic, copy) NSString *bgColor;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *bgPicture;

+ (NSMutableArray *)getColumnEyesModelFromArr:(NSArray *)arrAll;


@end
