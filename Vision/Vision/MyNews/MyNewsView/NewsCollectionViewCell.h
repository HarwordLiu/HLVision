//
//  NewsCollectionViewCell.h
//  Vision
//
//  Created by Rilma.Liu on 16/3/5.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNewsColumnModel.h"

@interface NewsCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *textLabelTitle;

@property (nonatomic, strong) MyNewsColumnModel *model;


@end
