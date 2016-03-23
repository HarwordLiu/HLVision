//
//  ReplyEyesView.h
//  Vision
//
//  Created by Rilma.Liu on 16/3/10.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyEyesCellModel.h"
#import "ReplyModel.h"

@protocol ReplyEyesViewDelegate <NSObject>

- (void)backBtnClick:(UIButton *)sender;

@end

@interface ReplyEyesView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *textLabelTitle;
@property (nonatomic, strong) UILabel *textLabelReplayCount;
@property (nonatomic, strong) UITableView *tableViewReply;
@property (nonatomic, strong) UIButton *btnBack;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSMutableArray *arrModel;

@property (nonatomic, assign) id delegate;

- (instancetype)initWithFrame:(CGRect)frame Model:(MyEyesCellModel *)model;

- (void)showAnimation;
- (void)dismisAnimation;


@end
