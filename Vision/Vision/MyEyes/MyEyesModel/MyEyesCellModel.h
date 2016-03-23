//
//  MyEyesCellModel.h
//  Vision
//
//  Created by Rilma.Liu on 16/2/26.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConsumptionModel.h"
#import "PlayInfoModel.h"

@interface MyEyesCellModel : NSObject


@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSInteger idx;
@property (nonatomic, assign) long long date;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *webUrl;
@property (nonatomic, copy) NSString *rawWebUrl;
@property (nonatomic, copy) NSString *playUrl;
@property (nonatomic, copy) NSString *descriptionText;
@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *coverBlurred;
@property (nonatomic, copy) NSString *coverForFeed;
@property (nonatomic, copy) NSString *coverForDetail;
@property (nonatomic, copy) NSString *coverForSharing;

@property (nonatomic, assign) BOOL collection;

@property (nonatomic, strong) NSMutableArray<PlayInfoModel *> *playInfoModel;
@property (nonatomic, strong) ConsumptionModel *consumptionModel;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)myEyesCellModelWithDict:(NSDictionary *)dict;

+ (NSMutableArray *)getEyeModelFromArr:(NSArray *)arrAll;

@end


