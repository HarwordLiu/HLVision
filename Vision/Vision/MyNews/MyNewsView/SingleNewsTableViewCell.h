//
//  SingleNewsTableViewCell.h
//  Vision
//
//  Created by Rilma.Liu on 16/3/8.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"

@interface SingleNewsTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imageViewNews;
@property (nonatomic, strong) UILabel *textLabelProvider;
@property (nonatomic, strong) UILabel *textLabelPubDate;
@property (nonatomic, strong) UILabel *textLabelTitle;
@property (nonatomic, strong) UIView *backView;


@property (nonatomic, strong) ArticleModel *model;








@end
