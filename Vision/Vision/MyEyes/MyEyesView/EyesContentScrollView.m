//
//  EyesContentScrollView.m
//  Vision
//
//  Created by Rilma.Liu on 16/2/29.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "EyesContentScrollView.h"
#import <UIImageView+WebCache.h>

@implementation EyesContentScrollView
- (instancetype)initWithFrame:(CGRect)frame
                   imageArray:(NSArray *)imageArray
                        index:(NSInteger)index
                         Size:(CGFloat)size {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake([imageArray count] * [UIScreen mainScreen].bounds.size.width, 0);
        // 设置边框是否回弹
        self.bounces = YES;
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width * index, 0);

        for (int i = 0; i < imageArray.count; i++) {
            EyesImageContentView *imageBackView = [[EyesImageContentView alloc] initWithFrame:CGRectMake(SCREENFRAMEWEIGHT * i, 0, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / size)];
            MyEyesCellModel *model = imageArray[i];
            if (size == 1.7) {
                [imageBackView.imageView sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail]];
            } else {

                [imageBackView.imageView sd_setImageWithURL:[NSURL URLWithString:model.coverBlurred]];

            }
            
            [self addSubview:imageBackView];
            

        }
    }
    return self;
}









/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
