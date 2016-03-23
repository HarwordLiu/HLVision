//
//  ColumnCollectionViewCell.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/4.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "ColumnCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation ColumnCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubView];
    }
    return self;
}

- (void)creatSubView {
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.origin.x + 0.5, self.contentView.frame.origin.y, self.contentView.frame.size.width - 1, self.contentView.frame.size.height - 1)];
    self.backImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.backImageView];
    
    UIView *coverView = [[UIView alloc] initWithFrame:self.backImageView.frame];
    coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
    [self.contentView addSubview:coverView];
    
    self.textLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.5, 0, self.contentView.frame.size.width - 1, self.contentView.frame.size.height / 6)];
    self.textLabelTitle.center = self.contentView.center;
    self.textLabelTitle.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:15];
    self.textLabelTitle.textAlignment = NSTextAlignmentCenter;
    self.textLabelTitle.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.textLabelTitle];
    
    
}

- (void)setModel:(ColumnEyesModel *)model {
    self.textLabelTitle.text = [NSString stringWithFormat:@"#%@", model.name];
    
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:model.bgPicture]];
    

    
}







@end
