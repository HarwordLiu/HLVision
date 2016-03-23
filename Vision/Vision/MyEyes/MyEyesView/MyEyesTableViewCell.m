//
//  MyEyesTableViewCell.m
//  Vision
//
//  Created by Rilma.Liu on 16/2/27.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "MyEyesTableViewCell.h"

@implementation MyEyesTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubView];
    }
    return self;
}

- (void)creatSubView{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.clipsToBounds = YES;
    
    self.imageViewBackImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -(SCREENFRAMEHEIGHT / 1.7 - SCREENFRAMEHEIGHT / 3) / 2, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 1.7)];
    self.imageViewBackImage.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.imageViewBackImage];
    
    self.coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 3)];
    self.coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
    [self.contentView addSubview:self.coverView];
    
    self.textLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREENFRAMEHEIGHT / 3 / 2 - 30, SCREENFRAMEWEIGHT, 30)];
    self.textLabelTitle.textAlignment = NSTextAlignmentCenter;
    self.textLabelTitle.textColor = [UIColor whiteColor];
    self.textLabelTitle.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:18];
    [self.contentView addSubview:self.textLabelTitle];
    
    self.textLabelVideoInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREENFRAMEHEIGHT / 3 / 2, SCREENFRAMEWEIGHT, 30)];
    self.textLabelVideoInfo.textAlignment = NSTextAlignmentCenter;
    self.textLabelVideoInfo.textColor = [UIColor whiteColor];
    self.textLabelVideoInfo.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:13];
    [self.contentView addSubview:self.textLabelVideoInfo];
    
}

- (void)setModel:(MyEyesCellModel *)model{
    [self.imageViewBackImage sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail] placeholderImage:[UIImage imageNamed:@"EyesPlaceHolder"]];
    self.textLabelTitle.text = model.title;
    self.textLabelVideoInfo.text = [NSString stringWithFormat:@"#%@ / %ld'%ld\"", model.category, model.duration / 60, model.duration % 60];
}

// 图片背景偏移
- (CGFloat)cellOffset {
    // 获取WINDOW中心点和cell中心点的差值
    // 改变Transform的Y实现平移
    CGRect centerToWindow = [self convertRect:self.bounds toView:self.window];
    CGFloat centerY = CGRectGetMidY(centerToWindow);
    CGPoint windowCenter = self.superview.center;
    CGFloat cellOffsetY = centerY - windowCenter.y;
    
    CGFloat offsetDig =  cellOffsetY / self.superview.frame.size.height * 2;
    CGFloat offset =  -offsetDig * (SCREENFRAMEHEIGHT / 1.7 - SCREENFRAMEHEIGHT / 3) / 2;
    
    CGAffineTransform transY = CGAffineTransformMakeTranslation(0,offset);
    self.imageViewBackImage.transform = transY;
    
    return offset;
}










@end
