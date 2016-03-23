//
//  RLBaseBtnLabelView.h
//  Vision
//
//  Created by Rilma.Liu on 16/2/29.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RLBaseBtnLabelView : UIControl

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *btnImageView;

@property (nonatomic, strong) UIImage *btnImage;
@property (nonatomic, strong) UIImage *btnSelectedImage;

- (instancetype)initWithFrame:(CGRect)frame
                 BtnImageView:(UIImage *)btnImage
              BtnSeletedImage:(UIImage *)btnSeletedImage
                   LabelTitle:(NSString *)title;

@end
