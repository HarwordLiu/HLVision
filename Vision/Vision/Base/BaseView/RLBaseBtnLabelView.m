//
//  RLBaseBtnLabelView.m
//  Vision
//
//  Created by Rilma.Liu on 16/2/29.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "RLBaseBtnLabelView.h"

@implementation RLBaseBtnLabelView
- (instancetype)initWithFrame:(CGRect)frame
                 BtnImageView:(UIImage *)btnImage
              BtnSeletedImage:(UIImage *)btnSeletedImage
                   LabelTitle:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViewBtnImageView:btnImage BtnSeletedImage:btnSeletedImage LabelTitle:title];
        
    }
    return self;
}

- (void)creatSubViewBtnImageView:(UIImage *)btnImage
                 BtnSeletedImage:(UIImage *)btnSeletedImage
                      LabelTitle:(NSString *)title {
    self.btnImage = btnImage;
    self.btnSelectedImage = btnSeletedImage;
    
    self.btnImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * 2 / 5, self.frame.size.height)];
    self.btnImageView.image = btnImage;
    self.btnImageView.userInteractionEnabled = NO;
    [self addSubview:self.btnImageView];
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * 2 / 5, 0, self.frame.size.width * 3 / 5, self.frame.size.height)];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.userInteractionEnabled = NO;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:13];
    self.textLabel.text = title;
    [self addSubview:self.textLabel];

}










/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
