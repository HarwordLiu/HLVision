//
//  EyesPlayInfoView.m
//  Vision
//
//  Created by Rilma.Liu on 16/2/29.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "EyesPlayInfoView.h"

@implementation EyesPlayInfoView

- (instancetype)initWithFrame:(CGRect)frame
                   imageArray:(NSArray *)imageArray
              arrCollectModel:(NSArray *)arrCollectionModel
                        index:(NSInteger)index{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeTop;
        self.clipsToBounds = YES;
        // 轮播图
        self.contentScrollView = [[EyesContentScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT - 64) imageArray:imageArray index:index Size:1.7];
        [self addSubview:self.contentScrollView];
        self.contentScrollView.userInteractionEnabled = YES;
        
        // 播放图标
        self.playView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENFRAMEWEIGHT - 100) / 2, (SCREENFRAMEHEIGHT / 1.7 - 100) / 2 + 64, 100, 100)];
        self.playView.image = [UIImage imageNamed:@"video-play"];
        
        [self addSubview:self.playView];
        
        self.animationView = [[MyEyesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [self.animationView.coverView removeFromSuperview];
        [self addSubview:self.animationView];
        
        MyEyesCellModel *model = imageArray[index];
        
        self.contentView = [[EyesContentView alloc] initWithFrame:CGRectMake(0, SCREENFRAMEHEIGHT / 1.7, SCREENFRAMEWEIGHT, 0) ModelArray:imageArray Index:index];
        self.contentView.model = model;
        self.contentView.delegate = self;
        
#pragma mark - 收藏状态判断
        for (MyEyesCellModel *tempModel in arrCollectionModel) {
            if (tempModel.duration == model.duration) {
                self.contentView.collectionCount.btnImageView.image = self.contentView.collectionCount.btnSelectedImage;
                self.contentView.collectionCount.selected = YES;

            }
        }
//        self.contentView.userInteractionEnabled = YES;
        [self addSubview:self.contentView];
        
        self.playView.alpha = 0;
        /**
         *  test
         */
        self.contentScrollView.alpha = 0;
        self.animationView.alpha = 1;
    }
    return self;
}
- (void)clickShare:(RLBaseBtnLabelView *)sender WithModel:(MyEyesCellModel *)model{
    [self.delegate clickShareBtn:sender WithModel:model];
}
- (void)clickDownload:(RLBaseBtnLabelView *)sender WithModel:(MyEyesCellModel *)model{
    [self.delegate clickDownloadBtn:sender WithModel:model];
}
- (void)clickCollection:(RLBaseBtnLabelView *)sender WithModel:(MyEyesCellModel *)model {
    [self.delegate clickCollectionBtn:sender WithModel:model];
}
- (void)clickReply:(RLBaseBtnLabelView *)sender WithModel:(MyEyesCellModel *)model {
    [self.delegate clickReplyBtn:sender WithModel:model];
}




- (void)animationShow {
    self.contentView.frame = CGRectMake(0, self.offSetY + SCREENFRAMEHEIGHT / 3, SCREENFRAMEWEIGHT, 0);
    [self.contentView changeHeight:0];
    [self.contentView changeAlpha:0];
    self.animationView.frame = CGRectMake(0, self.offSetY, SCREENFRAMEWEIGHT, 250);
    self.animationView.imageViewBackImage.transform = self.animationTrans;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.animationView.frame = CGRectMake(0, 64, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 1.7);
        self.animationView.imageViewBackImage.transform = CGAffineTransformMakeTranslation(0,  (SCREENFRAMEHEIGHT / 1.7 - SCREENFRAMEHEIGHT / 3)/2);
        
        self.contentView.frame = CGRectMake(0, SCREENFRAMEHEIGHT / 1.7 + 64, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT - SCREENFRAMEHEIGHT / 1.7 - 64);
        [self.contentView changeHeight:SCREENFRAMEHEIGHT - SCREENFRAMEHEIGHT / 1.7 - 64];
    } completion:^(BOOL finished) {
        
        self.contentScrollView.alpha = 1;
        [UIView animateWithDuration:0.25 animations:^{
            
            self.animationView.alpha = 0;
            self.playView.alpha = 1;
            [self.contentView changeAlpha:1];

        } completion:^(BOOL finished) {
            
        }];
    }];

}
- (void)animationDismissUsingCompeteBlock:(void (^)(void))complete {
    [UIView animateWithDuration:0.25 animations:^{
        self.animationView.alpha = 1;
        [self.contentView changeAlpha:0];
    } completion:^(BOOL finished) {
        
        self.contentScrollView.alpha = 0;
        self.playView.alpha = 0;

        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect rec = self.animationView.frame;
            rec.origin.y = self.offSetY;
            rec.size.height = SCREENFRAMEHEIGHT / 3;
            self.animationView.frame = rec;
            self.animationView.imageViewBackImage.transform = self.animationTrans;
            self.contentView.frame = CGRectMake(0, self.offSetY + SCREENFRAMEHEIGHT / 3, SCREENFRAMEWEIGHT, 0);
            [self.contentView changeHeight:0];
            
        } completion:^(BOOL finished) {
            
            self.animationTrans = CGAffineTransformIdentity;
            
            [self.contentView removeFromSuperview];
            [UIView animateWithDuration:0.25 animations:^{
                self.animationView.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                
                complete();
            }];
            
        }];
    }];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
