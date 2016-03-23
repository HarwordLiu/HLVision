//
//  EyesPlayInfoView.h
//  Vision
//
//  Created by Rilma.Liu on 16/2/29.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EyesImageContentView.h"
#import "EyesContentScrollView.h"
#import "MyEyesTableViewCell.h"
#import "MyEyesSectionModel.h"
#import "MyEyesCellModel.h"
#import "EyesContentView.h"

@protocol EyesPlayInfoViewDelegate <NSObject>

- (void)clickShareBtn:(RLBaseBtnLabelView *)sender WithModel:(MyEyesCellModel *)model;
- (void)clickDownloadBtn:(RLBaseBtnLabelView *)sender WithModel:(MyEyesCellModel *)model;
- (void)clickCollectionBtn:(RLBaseBtnLabelView *)sender WithModel:(MyEyesCellModel *)model;
- (void)clickReplyBtn:(RLBaseBtnLabelView *)sender WithModel:(MyEyesCellModel *)model;

@end

@interface EyesPlayInfoView : UIView<EyesContentDelegate>

@property (nonatomic, strong) EyesContentView *contentView;
@property (nonatomic, strong) EyesContentScrollView *contentScrollView;
@property (nonatomic, strong) MyEyesTableViewCell *animationView;

@property (nonatomic, strong) UIImageView *playView;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) CGFloat offSetY;
@property (nonatomic, assign) CGAffineTransform animationTrans;

@property (nonatomic, assign) id delegate;


- (instancetype)initWithFrame:(CGRect)frame
                   imageArray:(NSArray *)imageArray
              arrCollectModel:(NSArray *)arrCollectionModel
                        index:(NSInteger)index;



// 出现动画
- (void)animationShow;
// 收起动画
- (void)animationDismissUsingCompeteBlock:(void (^)(void))complete;


@end
