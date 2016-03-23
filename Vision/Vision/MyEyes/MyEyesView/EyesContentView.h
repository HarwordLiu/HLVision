//
//  EyesContentView.h
//  Vision
//
//  Created by Rilma.Liu on 16/2/29.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RLBaseBtnLabelView.h"
#import "MyEyesCellModel.h"
#import "ConsumptionModel.h"
#import <SDWebImageManager.h>

@protocol EyesContentDelegate <NSObject>

- (void)clickShare:(RLBaseBtnLabelView *)sender WithModel:(MyEyesCellModel *)model;
- (void)clickDownload:(RLBaseBtnLabelView *)sender WithModel:(MyEyesCellModel *)model;
- (void)clickCollection:(RLBaseBtnLabelView *)sender WithModel:(MyEyesCellModel *)model;
- (void)clickReply:(RLBaseBtnLabelView *)sender WithModel:(MyEyesCellModel *)model;

@end

@interface EyesContentView : UIView<SDWebImageManagerDelegate>

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIScrollView *coverScrollView;

@property (nonatomic, strong) UILabel *textLabelTitle;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *textLabelInfoVideo;
@property (nonatomic, strong) UILabel *textLabelDescribe;

@property (nonatomic, strong) RLBaseBtnLabelView *collectionCount;
@property (nonatomic, strong) RLBaseBtnLabelView *shareCount;
@property (nonatomic, strong) RLBaseBtnLabelView *replyCount;
@property (nonatomic, strong) RLBaseBtnLabelView *download;

@property (nonatomic, strong) MyEyesCellModel *model;

@property (nonatomic, assign) id delegate;

- (instancetype)initWithFrame:(CGRect)frame
                   ModelArray:(NSArray *)arrModel
                        Index:(NSInteger)index;


- (void)changeHeight:(CGFloat)height;

- (void)changeData:(MyEyesCellModel *)model WithArrCollectModel:(NSArray *)arrCollectionModel;

- (void)changeAlpha:(NSInteger)alpha;



@end
