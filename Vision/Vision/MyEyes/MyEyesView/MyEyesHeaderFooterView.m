//
//  MyEyesHeaderFooterView.m
//  Vision
//
//  Created by Rilma.Liu on 16/2/27.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "MyEyesHeaderFooterView.h"

@implementation MyEyesHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubView];
    }
    return self;
}

- (void)creatSubView{
    self.textLabelDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 10)];
    self.textLabelDate.textAlignment = NSTextAlignmentCenter;
    self.textLabelDate.font = [UIFont fontWithName:@"Lobster1.4" size:15];
    [self.contentView addSubview:self.textLabelDate];
    
    
}


@end
