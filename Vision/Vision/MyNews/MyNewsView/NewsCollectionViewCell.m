//
//  NewsCollectionViewCell.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/5.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "NewsCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation NewsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubView];
    }
    return self;
}

- (void)creatSubView {
    
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2.5, 0, SCREENFRAMEWEIGHT / 3 - 5, SCREENFRAMEHEIGHT / 6)];
    [self.contentView addSubview:self.backImageView];
    
    self.textLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(2.5, SCREENFRAMEHEIGHT / 6 - 25, SCREENFRAMEWEIGHT / 3 - 5, SCREENFRAMEHEIGHT / 30)];
    self.textLabelTitle.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
    self.textLabelTitle.font = [UIFont boldSystemFontOfSize:15];
    self.textLabelTitle.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.textLabelTitle];
    
    
    
    
    
    
}

- (void)setModel:(MyNewsColumnModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.textLabelTitle.alpha = 1;
    self.textLabelTitle.text = model.Text;
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:model.Url] placeholderImage:[UIImage imageNamed:@"EyesPlaceHolder"]];
}


@end
