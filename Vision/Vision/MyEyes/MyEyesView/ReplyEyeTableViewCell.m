//
//  ReplyEyeTableViewCell.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/10.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "ReplyEyeTableViewCell.h"
#import "NSDate+RLSinceNow.h"
#import <UIImageView+WebCache.h>

@implementation ReplyEyeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubView];
    }
    return self;
}

- (void)creatSubView {
    self.backgroundColor = [UIColor clearColor];
    
    self.imageViewUser = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, SCREENFRAMEHEIGHT / 15, SCREENFRAMEHEIGHT / 15)];
    self.imageViewUser.clipsToBounds = YES;
    self.imageViewUser.layer.cornerRadius = SCREENFRAMEHEIGHT / 15 / 2;
    [self.contentView addSubview:self.imageViewUser];
    
    self.textLabelName = [[UILabel alloc] initWithFrame:CGRectMake(SCREENFRAMEHEIGHT / 15 + 10, 5, SCREENFRAMEWEIGHT - SCREENFRAMEHEIGHT * 2 / 15, SCREENFRAMEHEIGHT / 30)];
    self.textLabelName.backgroundColor = [UIColor clearColor];
    self.textLabelName.textColor = [UIColor whiteColor];
    self.textLabelName.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:15];
    [self.contentView addSubview:self.textLabelName];
    
    self.textLabelReply = [[UILabel alloc] initWithFrame:CGRectMake(SCREENFRAMEHEIGHT / 15 + 10, SCREENFRAMEHEIGHT / 30 + 5, SCREENFRAMEWEIGHT - SCREENFRAMEHEIGHT * 2 / 15, SCREENFRAMEHEIGHT / 30)];
    self.textLabelReply.backgroundColor = [UIColor clearColor];
    self.textLabelReply.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:13];
    self.textLabelReply.textColor = [UIColor whiteColor];
    self.textLabelReply.lineBreakMode = NSLineBreakByClipping;
    self.textLabelReply.numberOfLines = 0;
    [self.contentView addSubview:self.textLabelReply];
    
    self.textLabelTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, SCREENFRAMEWEIGHT - 5, SCREENFRAMEHEIGHT / 30)];
    self.textLabelTime.backgroundColor = [UIColor clearColor];
    self.textLabelTime.alpha = 0.5;
    self.textLabelTime.textColor = [UIColor whiteColor];
    self.textLabelTime.textAlignment = NSTextAlignmentRight;
    self.textLabelTime.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:13];
    [self.contentView addSubview:self.textLabelTime];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(SCREENFRAMEHEIGHT / 15 + 15, SCREENFRAMEHEIGHT / 10 - 3.5, SCREENFRAMEWEIGHT - SCREENFRAMEWEIGHT / 6, 1)];
    viewLine.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:viewLine];
    self.lineView = viewLine;
    
    
}

- (void)setModel:(ReplyModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.textLabelReply.frame = CGRectMake(SCREENFRAMEHEIGHT / 15 + 10, SCREENFRAMEHEIGHT / 30 + 5, SCREENFRAMEWEIGHT - SCREENFRAMEHEIGHT * 2 / 15, SCREENFRAMEHEIGHT / 30);
    self.lineView.frame = CGRectMake(SCREENFRAMEHEIGHT / 15 + 15, SCREENFRAMEHEIGHT / 15 - 3.5, SCREENFRAMEWEIGHT - SCREENFRAMEWEIGHT / 6, 1);
    
    self.textLabelName.text = model.userDic.nickname;
    self.textLabelReply.text = model.message;
    self.textLabelTime.text = [NSDate sinceNowToDate:model.createTime];
    
    [self.imageViewUser sd_setImageWithURL:[NSURL URLWithString:model.userDic.avatar] placeholderImage:nil];
    [self.textLabelReply sizeToFit];
    

    self.lineView.frame = CGRectMake(SCREENFRAMEHEIGHT / 15 + 15, SCREENFRAMEHEIGHT / 15 - 3.5 + self.textLabelReply.frame.size.height, SCREENFRAMEWEIGHT - SCREENFRAMEWEIGHT / 6, 1);
    
    
}




@end
