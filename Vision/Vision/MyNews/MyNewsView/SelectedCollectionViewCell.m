//
//  SelectedCollectionViewCell.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/5.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "SelectedCollectionViewCell.h"
#import <UIImageView+WebCache.h>


@implementation SelectedCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSelectedView];
    }
    return self;
}

- (void)creatSelectedView {
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2.5, 0, SCREENFRAMEWEIGHT / 3 - 5, SCREENFRAMEHEIGHT / 6)];
    [self.contentView addSubview:self.backImageView];
    
    self.textLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(2.5, SCREENFRAMEHEIGHT / 6 - 25, SCREENFRAMEWEIGHT / 3 - 5, SCREENFRAMEHEIGHT / 30)];
    self.textLabelTitle.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
    self.textLabelTitle.textColor = [UIColor whiteColor];
    self.textLabelTitle.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:self.textLabelTitle];
    
    self.coverView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
    self.coverView.alpha = 0;
    [self.contentView addSubview:self.coverView];
    
    self.textLabelTitle.frame = CGRectMake(2.5, 0, SCREENFRAMEWEIGHT / 3 - 5, SCREENFRAMEHEIGHT / 30);
    
    self.selectedView = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.bounds.size.width * 4 / 5, self.contentView.bounds.size.height * 4 / 5, self.contentView.bounds.size.width / 5, self.contentView.bounds.size.height / 5)];
    self.selectedView.image = [UIImage imageNamed:@"selected"];
    self.selectedView.alpha = 0;
    [self.contentView addSubview:self.selectedView];
    
    self.unSelectedView = [[UIImageView alloc] initWithFrame:self.selectedView.frame];
    self.unSelectedView.image = [UIImage imageNamed:@"unselected"];
    self.unSelectedView.alpha = 1;
    [self.contentView addSubview:self.unSelectedView];
    
    
}
- (void)setModel:(MyNewsColumnModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    self.textLabelTitle.text = model.Text;
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:model.Url] placeholderImage:[UIImage imageNamed:@"EyesPlaceHolder"]];
}




@end
