//
//  ColumnCollectionViewCell.h
//  Vision
//
//  Created by Rilma.Liu on 16/3/4.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColumnEyesModel.h"

@interface ColumnCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *textLabelTitle;

@property (nonatomic, strong) ColumnEyesModel *model;

@end
