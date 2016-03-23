//
//  SelectedCollectionViewCell.h
//  Vision
//
//  Created by Rilma.Liu on 16/3/5.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNewsColumnModel.h"

@interface SelectedCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *selectedView;
@property (nonatomic, strong) UIImageView *unSelectedView;
@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *textLabelTitle;

@property (nonatomic, strong) MyNewsColumnModel *model;

@end
