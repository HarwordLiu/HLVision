//
//  EyesImageContentView.m
//  Vision
//
//  Created by Rilma.Liu on 16/2/29.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "EyesImageContentView.h"

@implementation EyesImageContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 自动裁剪边界使第一张照片显示完整
        self.clipsToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;

        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 1.7)];
        [self addSubview:self.imageView];
    }
    return self;
}

// 动画改变imageView的横坐标
- (void)imageOffset {
    
    CGRect centerToWindow = [self convertRect:self.bounds toView:nil];
    
    CGFloat centerX = CGRectGetMidX(centerToWindow);
    
    CGPoint windowCenter = self.window.center;
    
    CGFloat cellOffsetX = centerX - windowCenter.x;
    
    CGFloat offsetDig =  cellOffsetX / self.window.frame.size.height * 2;
    
    CGAffineTransform transX = CGAffineTransformMakeTranslation(- offsetDig * [UIScreen mainScreen].bounds.size.width * 0.7, 0);
    
    self.imageView.transform = transX;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
