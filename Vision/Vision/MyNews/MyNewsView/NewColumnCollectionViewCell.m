//
//  NewColumnCollectionViewCell.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/5.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "NewColumnCollectionViewCell.h"

@implementation NewColumnCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubView];
    }
    return self;
}

- (void)creatSubView {
    self.textLabelColumn = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT / 5, SCREENFRAMEHEIGHT / 20)];
//    self.textLabelColumn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
    self.textLabelColumn.font = [UIFont boldSystemFontOfSize:16];
    self.textLabelColumn.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.textLabelColumn];
    
}












@end
