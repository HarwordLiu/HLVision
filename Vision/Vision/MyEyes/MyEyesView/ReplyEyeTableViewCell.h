//
//  ReplyEyeTableViewCell.h
//  Vision
//
//  Created by Rilma.Liu on 16/3/10.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplyModel.h"

@interface ReplyEyeTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imageViewUser;
@property (nonatomic, strong) UILabel *textLabelName;
@property (nonatomic, strong) UILabel *textLabelReply;
@property (nonatomic, strong) UILabel *textLabelTime;

@property (nonatomic, strong) UIView *lineView;


@property (nonatomic, strong) ReplyModel *model;


@end
