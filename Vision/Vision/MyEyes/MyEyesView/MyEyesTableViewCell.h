//
//  MyEyesTableViewCell.h
//  Vision
//
//  Created by Rilma.Liu on 16/2/27.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyEyesCellModel.h"
#import <UIImageView+WebCache.h>

@interface MyEyesTableViewCell : UITableViewCell

@property (nonatomic, strong) MyEyesCellModel *model;

@property (nonatomic, strong) UIImageView *imageViewBackImage;
@property (nonatomic, strong) UILabel *textLabelTitle;
@property (nonatomic, strong) UILabel *textLabelVideoInfo;
@property (nonatomic, strong) UIView *coverView;

- (CGFloat)cellOffset;

@end
