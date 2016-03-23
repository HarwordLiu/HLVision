//
//  ReplyEyesView.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/10.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "ReplyEyesView.h"
#import "ReplyEyeTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation ReplyEyesView

- (instancetype)initWithFrame:(CGRect)frame Model:(MyEyesCellModel *)model {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViewWithModel:model];
    }
    return self;
}

- (void)creatSubViewWithModel:(MyEyesCellModel *)model {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
    
    self.btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnBack.backgroundColor = [UIColor clearColor];
    [self.btnBack setImage:[UIImage imageNamed:@"btn_backdown"] forState:UIControlStateNormal];
    self.btnBack.frame = CGRectMake(SCREENFRAMEWEIGHT / 2 - SCREENFRAMEHEIGHT / 15 / 2, 64, SCREENFRAMEHEIGHT/ 15, SCREENFRAMEHEIGHT / 15);
    self.btnBack.alpha = 0;
    [self.btnBack addTarget:self action:@selector(clickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnBack];
    
    self.textLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREENFRAMEHEIGHT/ 15 + 64, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT/ 15)];
    self.textLabelTitle.backgroundColor = [UIColor clearColor];
    self.textLabelTitle.textColor = [UIColor whiteColor];
    self.textLabelTitle.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:18];
    self.textLabelTitle.text = model.title;
    self.textLabelTitle.textAlignment = NSTextAlignmentCenter;
    self.textLabelTitle.alpha = 0;
    [self addSubview:self.textLabelTitle];
    
    self.textLabelReplayCount = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREENFRAMEWEIGHT * 4 / 15 + 64, SCREENFRAMEWEIGHT, SCREENFRAMEWEIGHT / 15)];
    self.textLabelReplayCount.backgroundColor = [UIColor clearColor];
    self.textLabelReplayCount.textColor = [UIColor whiteColor];
    self.textLabelReplayCount.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:15];
    self.textLabelReplayCount.text = [NSString stringWithFormat:@"- %ld条评论 -", model.consumptionModel.replyCount];
    self.textLabelReplayCount.alpha = 0;
    self.textLabelReplayCount.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.textLabelReplayCount];
    
    self.tableViewReply = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREENFRAMEHEIGHT / 2, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 2) style:UITableViewStylePlain];
    self.tableViewReply.delegate = self;
    self.tableViewReply.dataSource = self;
    self.tableViewReply.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableViewReply];

    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT / 2, SCREENFRAMEHEIGHT / 2)];
    [backImageView transfromImageViewWith:UIImageOrientationDownMirrored Model:model];
    self.tableViewReply.backgroundView = backImageView;
    
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 2)];
    coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
    [backImageView addSubview:coverView];
    
    
    
    
    
}

- (void)showAnimation {
    self.tableViewReply.frame = CGRectMake(0, SCREENFRAMEHEIGHT / 1.7 + 64, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 2);
    [UIView animateWithDuration:0.5 animations:^{
        self.tableViewReply.frame = CGRectMake(0, SCREENFRAMEHEIGHT / 2, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 2);
        self.textLabelReplayCount.alpha = 1;
        self.textLabelTitle.alpha = 1;
        self.btnBack.alpha = 1;
    }];
    
}

- (void)dismisAnimation {
    [UIView animateWithDuration:0.5 animations:^{
        self.tableViewReply.frame = CGRectMake(0, SCREENFRAMEHEIGHT / 1.7 + 64, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 2);
        self.textLabelReplayCount.alpha = 0;
        self.textLabelTitle.alpha = 0;
        self.btnBack.alpha = 0;

    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


- (void)clickBackBtn:(UIButton *)sender {
    [self.delegate backBtnClick:sender];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    ReplyEyeTableViewCell *cell = (ReplyEyeTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"%f", cell.frame.size.height);
//    return cell.contentView.frame.size.height;
    CGFloat height = [self getHeightWithModel:self.arrModel[indexPath.row]];
    NSLog(@"%f", height);
    return height;
}

- (CGFloat)getHeightWithModel:(ReplyModel *)model {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREENFRAMEHEIGHT / 15 + 10, SCREENFRAMEHEIGHT / 30 + 5, SCREENFRAMEWEIGHT - SCREENFRAMEHEIGHT * 2 / 15, SCREENFRAMEHEIGHT / 30)];
    label.text = model.message;
    label.lineBreakMode = NSLineBreakByClipping;
    label.numberOfLines = 0;
    [label sizeToFit];
    return label.frame.size.height + SCREENFRAMEHEIGHT / 30 + 15;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"replyCell";
    ReplyEyeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ReplyEyeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.arrModel[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}




@end
