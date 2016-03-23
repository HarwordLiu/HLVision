//
//  EyesContentView.m
//  Vision
//
//  Created by Rilma.Liu on 16/2/29.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "EyesContentView.h"
#import <UIImageView+WebCache.h>

@implementation EyesContentView

- (instancetype)initWithFrame:(CGRect)frame ModelArray:(NSArray *)arrModel Index:(NSInteger)index{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViewWithModelArray:arrModel Index:index];
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)creatSubViewWithModelArray:(NSArray *)arrModel Index:(NSInteger)index {
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT - SCREENFRAMEHEIGHT / 1.7 - 64)];
    MyEyesCellModel *model = arrModel[index];
#pragma mark - 网址请求图片翻转
    [self.backImageView transfromImageViewWith:UIImageOrientationDownMirrored Model:model];
    [self addSubview:self.backImageView];
    
    
    self.coverScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT - SCREENFRAMEHEIGHT / 1.7 - 64)];
    self.coverScrollView.contentSize = CGSizeMake(SCREENFRAMEWEIGHT * arrModel.count, 0);
    self.coverScrollView.contentOffset = CGPointMake(SCREENFRAMEWEIGHT * index, 0);
    self.coverScrollView.pagingEnabled = YES;
    self.coverScrollView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
    [self addSubview:self.coverScrollView];
    
    self.textLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREENFRAMEWEIGHT - 40, SCREENFRAMEHEIGHT / 16)];
//    self.textLabelTitle.backgroundColor = [UIColor greenColor];
    self.textLabelTitle.textColor = [UIColor whiteColor];
    self.textLabelTitle.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:19];
    self.textLabelTitle.text = model.title;
    [self addSubview:self.textLabelTitle];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(20, SCREENFRAMEHEIGHT / 16, self.textLabelTitle.frame.size.width - 80, 1)];
//    self.lineView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.33];
    self.lineView.backgroundColor = [UIColor whiteColor];
    self.lineView.alpha = 0.5;
    [self addSubview:self.lineView];
    
    self.textLabelInfoVideo = [[UILabel alloc] initWithFrame:CGRectMake(20, SCREENFRAMEHEIGHT / 16 + 1, SCREENFRAMEWEIGHT - 40, SCREENFRAMEHEIGHT / 32)];
//    self.textLabelInfoVideo.backgroundColor = [UIColor greenColor];
    self.textLabelInfoVideo.textColor = [UIColor whiteColor];
    self.textLabelInfoVideo.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:13];
    self.textLabelInfoVideo.text = [NSString stringWithFormat:@"#%@  /  %ld'%ld\"", model.category, model.duration / 60, model.duration % 60];
    [self addSubview:self.textLabelInfoVideo];
    
    self.textLabelDescribe = [[UILabel alloc] initWithFrame:CGRectMake(20, SCREENFRAMEHEIGHT / 16 + 1 + SCREENFRAMEHEIGHT / 25, SCREENFRAMEWEIGHT - 40, SCREENFRAMEHEIGHT / 10)];
    self.textLabelDescribe.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:13];
    self.textLabelDescribe.numberOfLines = 0;
    self.textLabelDescribe.lineBreakMode = NSLineBreakByClipping;
    self.textLabelDescribe.text = model.descriptionText;
    self.textLabelDescribe.textColor = [UIColor whiteColor];
    [self addSubview:self.textLabelDescribe];
    
    self.collectionCount = [[RLBaseBtnLabelView alloc] initWithFrame:CGRectMake(20, SCREENFRAMEHEIGHT / 16 + 1 + SCREENFRAMEHEIGHT * 2 / 25 + SCREENFRAMEHEIGHT / 10, SCREENFRAMEWEIGHT / 5, SCREENFRAMEWEIGHT / 20) BtnImageView:[UIImage imageNamed:@"btn_collect"] BtnSeletedImage:[UIImage imageNamed:@"btn_collected"] LabelTitle:[NSString stringWithFormat:@"%ld", [model.consumptionModel collectionCount]]];
    [self.collectionCount addTarget:self action:@selector(clickCollectionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.collectionCount];
    
//    self.shareCount = [[RLBaseBtnLabelView alloc] initWithFrame:CGRectMake(20 + SCREENFRAMEWEIGHT / 5, SCREENFRAMEHEIGHT / 16 + 1 + SCREENFRAMEHEIGHT * 2 / 25 + SCREENFRAMEHEIGHT / 10, SCREENFRAMEWEIGHT / 5, SCREENFRAMEWEIGHT / 20) BtnImageView:[UIImage imageNamed:@"btn_share"] BtnSeletedImage:[UIImage imageNamed:@"btn_share"] LabelTitle:[NSString stringWithFormat:@"%ld", [model.consumptionModel shareCount]]];
//    [self addSubview:self.shareCount];
//    [self.shareCount addTarget:self action:@selector(clickShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    
//    self.download = [[RLBaseBtnLabelView alloc] initWithFrame:CGRectMake(20 + SCREENFRAMEWEIGHT * 2 / 5, SCREENFRAMEHEIGHT / 16 + 1 + SCREENFRAMEHEIGHT * 2 / 25 + SCREENFRAMEHEIGHT / 10, SCREENFRAMEWEIGHT / 5, SCREENFRAMEWEIGHT / 20) BtnImageView:[UIImage imageNamed:@"btn_download"] BtnSeletedImage:[UIImage imageNamed:@"btn_download"] LabelTitle:@"缓存"];
//    [self.download addTarget:self action:@selector(clickDownloadBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:self.download];
    
    self.replyCount = [[RLBaseBtnLabelView alloc] initWithFrame:CGRectMake(20 + SCREENFRAMEWEIGHT / 5, SCREENFRAMEHEIGHT / 16 + 1 + SCREENFRAMEHEIGHT * 2 / 25 + SCREENFRAMEHEIGHT / 10, SCREENFRAMEWEIGHT / 5, SCREENFRAMEWEIGHT / 20) BtnImageView:[UIImage imageNamed:@"btn_reply"] BtnSeletedImage:[UIImage imageNamed:@"btn_reply"] LabelTitle:[NSString stringWithFormat:@"%ld", [model.consumptionModel replyCount]]];
    [self.replyCount addTarget:self action:@selector(clickReplyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.replyCount];
    
    
    
    

    
}

- (void)changeHeight:(CGFloat)height {
    self.backImageView.frame = CGRectMake(0, 0, SCREENFRAMEWEIGHT, height);
    self.coverScrollView.frame = CGRectMake(0, 0, SCREENFRAMEWEIGHT, height);

}
- (void)changeAlpha:(NSInteger)alpha {
    self.textLabelTitle.alpha = alpha;
    self.textLabelDescribe.alpha = alpha;
    self.textLabelInfoVideo.alpha = alpha;
    self.shareCount.alpha = alpha;
    self.collectionCount.alpha = alpha;
    self.download.alpha = alpha;
    self.replyCount.alpha = alpha;
    self.lineView.alpha = alpha;
}
- (void)changeData:(MyEyesCellModel *)model WithArrCollectModel:(NSArray *)arrCollectionModel{
    if (_model != model) {
        _model = model;
    }
    [self.backImageView transfromImageViewWith:UIImageOrientationDownMirrored Model:model];
    self.textLabelTitle.text = model.title;
    self.textLabelInfoVideo.text = [NSString stringWithFormat:@"#%@  /  %ld'%ld\"", model.category, model.duration / 60, model.duration % 60];
    self.textLabelDescribe.text = model.descriptionText;

    self.backImageView.alpha = 0;
    self.collectionCount.btnImageView.image = self.collectionCount.btnImage;
    self.collectionCount.selected = NO;
    
    
    
#pragma mark - 收藏状态判断
    for (MyEyesCellModel *tempModel in arrCollectionModel) {
        if (tempModel.duration == model.duration) {
            self.collectionCount.btnImageView.image = self.collectionCount.btnSelectedImage;
            self.collectionCount.selected = YES;
            self.collectionCount.textLabel.text = [NSString stringWithFormat:@"%ld", model.consumptionModel.collectionCount];
        }
    }
    self.replyCount.textLabel.text = [NSString stringWithFormat:@"%ld", model.consumptionModel.replyCount];
    self.model = model;
    [UIView animateWithDuration:0.5 animations:^{
        self.backImageView.alpha = 1;
    }];
}

- (void)clickCollectionBtn:(RLBaseBtnLabelView *)sender {
    [self.delegate clickCollection:sender WithModel:_model];
}

- (void)clickShareBtn:(RLBaseBtnLabelView *)sender{
    [self.delegate clickShare:sender WithModel:_model];
}
- (void)clickDownloadBtn:(RLBaseBtnLabelView *)sender{
    [self.delegate clickDownload:sender WithModel:_model];
    
}
- (void)clickReplyBtn:(RLBaseBtnLabelView *)sender{
    [self.delegate clickReply:sender WithModel:_model];
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
