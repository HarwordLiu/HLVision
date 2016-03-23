//
//  MyEyesViewController.m
//  Vision
//
//  Created by Rilma.Liu on 16/2/26.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "MyEyesViewController.h"
#import "ReplyEyesView.h"

@interface MyEyesViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, EyesPlayInfoViewDelegate, ReplyEyesViewDelegate>

@property (nonatomic, strong) ReplyEyesView *replyView;
@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation MyEyesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSubView];
    [self creatTableSqlite];

    
}


- (void)creatSubView{

    
    // 导航视图
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 18)];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont fontWithName:@"Lobster1.4" size:28];
    titleView.text = @"VISION";
    titleView.userInteractionEnabled = YES;
    self.navigationItem.titleView = titleView;
    self.titleViewLabel = titleView;
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 80, 40)];
    self.dateLabel.font = [UIFont fontWithName:@"Lobster1.4" size:16];
    self.dateLabel.text = @"Today";
    [titleView addSubview:self.dateLabel];
    
    self.setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.setBtn.frame = CGRectMake(5, 5, 30, 30);
    [self.setBtn setImage:nil forState:UIControlStateNormal];
    [self.setBtn addTarget:self action:@selector(clickBtnSet:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:self.setBtn];
    
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRight.frame = CGRectMake(SCREENFRAMEWEIGHT - 70, 0, 40, 40);
    [btnRight setImage:[UIImage imageNamed:@"EyesUnSelested"] forState:UIControlStateNormal];
    [btnRight setImage:[UIImage imageNamed:@"EyesSeleted"] forState:UIControlStateSelected];
    [btnRight addTarget:self action:@selector(clickBtnRight:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:btnRight];
    btnRight.enabled = NO;
    self.eyesBtn = btnRight;
    


    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 18)];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.font = [UIFont fontWithName:@"Lobster1.4" size:15];
    headerLabel.text = @"- Today -";
    self.tableView.tableHeaderView = headerLabel;
    self.headerLabel = headerLabel;
    //设置分割线不显示
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[MyEyesHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"HeaderFooterView"];
    [self.view addSubview:self.tableView];
    [self setRefresh];
    
    
}

- (void)clickBtnSet:(UIButton *)sender {
    NSLog(@"set");
    
    
    
}
#pragma mark - 点击btn切换展示方式
- (void)clickBtnRight:(UIButton *)sender {
    sender.enabled = NO;
    if (!sender.selected) {
        // 
        self.currentIndexPath = [self.tableView indexPathForRowAtPoint:CGPointMake(self.view.center.x, self.tableViewContenOffset.y + self.view.center.y)];
        
        [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:self.currentIndexPath];
        
        [self.tableView scrollToRowAtIndexPath:self.currentIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        
        MyEyesTableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.currentIndexPath];
        
        // 获取cell相对于窗口的frame
        CGRect rect = [cell convertRect:cell.bounds toView:nil];
        // 改变playInfoView的参数 以及动画参数
        self.playInfoView.offSetY = rect.origin.y;
        self.playInfoView.animationTrans = cell.imageViewBackImage.transform;
        // 防止多次点击重复触发动画
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            sender.enabled = YES;
        });
        
    } else {
        [self.playInfoView animationDismissUsingCompeteBlock:^{
            self.playInfoView = nil;
            sender.enabled = YES;
            self.eyesBtn.selected =! self.eyesBtn.isSelected;
        }];
        [self.tabBarController hiddenTabBar:NO];
    }
    
}
#pragma mark - 添加下拉刷新上拉加载
- (void)setRefresh{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh:)];
    NSMutableArray *arrImages = [NSMutableArray array];
    [arrImages addObject:[UIImage imageNamed:@"myEyes"]];
    [header setImages:arrImages forState:MJRefreshStateIdle];
    [header setImages:arrImages forState:MJRefreshStatePulling];
    [header setImages:arrImages forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;

    header.stateLabel.font = [UIFont fontWithName:@"Lobster1.4" size:15];
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
    
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh:)];
    // 为了进入时不显示footer
    footer.hidden = YES;
    self.tableView.mj_footer = footer;

    
    

}

- (void)headerRefresh:(MJRefreshGifHeader *)header {
    @synchronized(self) {
        
    
    // 初始化数组
        self.arrModel = [NSMutableArray array];
    // 获取系统时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [NSDate date];
    NSString *dateString = [dateFormatter stringFromDate:date];
    [self getDataSourceFromWeb:[NSString stringWithFormat:NETEYES, dateString]];
    [header setTitle:self.nextPublishTime forState:MJRefreshStateIdle];
    [header setTitle:self.nextPublishTime forState:MJRefreshStateRefreshing];
    [header setTitle:self.nextPublishTime forState:MJRefreshStatePulling];
    // 显示联网状态旋转圆圈
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.tableView.mj_header endRefreshing];
    }

}

- (void)footerRefresh:(MJRefreshFooter *)footer {
    [self getDataSourceFromWeb:self.nextPageUrl];
    // 显示联网状态旋转圆圈
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [footer endRefreshing];
}

#pragma mark - 头视图设置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MyEyesHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HeaderFooterView"];
    if (view == nil) {
        view = [[MyEyesHeaderFooterView alloc] initWithReuseIdentifier:@"HeaderFooterView"];
    }
    MyEyesSectionModel *model = self.arrModel[section];
    // 日期格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setDateFormat:@"- MMM d -"];
    view.textLabelDate.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:model.date / 1000]];
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section > 0) {
        return [UIScreen mainScreen].bounds.size.height / 10;
    }
    return 0;
}

// 添加Cell出现动画
- (void)tableView:(UITableView *)tableView willDisplayCell:(MyEyesTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    MyEyesSectionModel *modelSection = [[MyEyesSectionModel alloc] init];
    MyEyesCellModel *modelRow = [[MyEyesCellModel alloc] init];
    if (self.arrModel.count != 0) {
        
        modelSection = self.arrModel[indexPath.section];
        modelRow = modelSection.videoListModel[indexPath.row];
    }
    // 判断是否加载过图片 来选择是否加载动画
    if (![[SDWebImageManager sharedManager] memoryCachedImageExistsForURL:[NSURL URLWithString:modelRow.coverForFeed]]) {
        CATransform3D rotation;//3D旋转
        rotation = CATransform3DMakeTranslation(0 ,50 ,20);

        //逆时针旋转
        rotation = CATransform3DScale(rotation, 0.9, 0.9, 1);
        rotation.m34 = 1.0 / -600;
        cell.layer.shadowColor = [[UIColor blackColor]CGColor];
        cell.layer.shadowOffset = CGSizeMake(10, 10);
        cell.alpha = 0;
        cell.layer.transform = rotation;
        [UIView beginAnimations:@"rotation" context:NULL];
        //旋转时间
        [UIView setAnimationDuration:0.6];
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1;
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        [UIView commitAnimations];
    }
    cell.model = modelRow;
    // 调用改变头标题时间栏
    [self changeData:indexPath.section];
#pragma mark - 调用cell背景改变方法
    [cell cellOffset];

}

// cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIScreen mainScreen].bounds.size.height / 3;
}

// UITableViewDataSourceDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arrModel.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MyEyesSectionModel *model = self.arrModel[section];
    return model.videoListModel.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"MyEyesTableViewCell";
    MyEyesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MyEyesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

// cell点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.eyesBtn.selected =! self.eyesBtn.isSelected;
    [self showImageAtIndexPath:indexPath];
    [self changeData:indexPath.section];
    self.scrollMaxContentOffset = [[self.arrModel[indexPath.section] videoListModel] count] * SCREENFRAMEWEIGHT;
    // 隐藏tabBar
    [self.tabBarController hiddenTabBar:YES];
    
}
#pragma mark - 跳转待播放界面
- (void)showImageAtIndexPath:(NSIndexPath *)indexPath {
    // 数据处理
    self.arrImages = [self.arrModel[indexPath.section] videoListModel];
    self.currentIndexPath = indexPath;
    
    // 获取点击所在cell
    MyEyesTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    CGRect rect = [cell convertRect:cell.bounds toView:nil];
    CGFloat y = rect.origin.y;
    // 创建待播放View
    self.playInfoView = [[EyesPlayInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT) imageArray:self.arrImages arrCollectModel:self.arrCollectionModel index:indexPath.row];
    self.playInfoView.offSetY = y;
    self.playInfoView.animationTrans = cell.imageViewBackImage.transform;
    self.playInfoView.delegate = self;
    self.playInfoView.animationView.imageViewBackImage.image = cell.imageViewBackImage.image;
    
    self.playInfoView.contentScrollView.delegate = self;
    self.playInfoView.contentView.coverScrollView.delegate = self;

//    self.playInfoView.contentView.collectionCount.btnImageView.image = self.playInfoView.contentView.collectionCount.btnSelectedImage;
    
    [[self.tableView superview] addSubview:self.playInfoView];
//    [self.view addSubview:self.playInfoView];
    
    // 添加上滑手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.playInfoView.contentView addGestureRecognizer:swipe];

    // 
    
    // 添加点击播放
    UITapGestureRecognizer *tapPlay = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPlayAction:)];
    [self.playInfoView.contentScrollView addGestureRecognizer:tapPlay];
    
    [self.playInfoView animationShow];
    
}

// 上滑手势
- (void)swipeAction:(UISwipeGestureRecognizer *)sender {
    // 消失动画
    self.tableView.alpha = 1;
    [self.tabBarController hiddenTabBar:NO];
    [self.playInfoView animationDismissUsingCompeteBlock:^{
        self.playInfoView = nil;
        self.eyesBtn.selected =! self.eyesBtn.isSelected;
    }];
}

// 点击播放
- (void)tapPlayAction:(UITapGestureRecognizer *)sender{
    if ([[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus] != AFNetworkReachabilityStatusReachableViaWiFi) {
        UIAlertAction *actionPlay = [UIAlertAction actionWithTitle:@"我是豪,麻溜的给我播" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            MyEyesSectionModel *modelSection = self.arrModel[self.currentIndexPath.section];
            MyEyesCellModel *model = modelSection.videoListModel[self.currentIndexPath.row];
            RLPlayerViewController *view = [[RLPlayerViewController alloc] init];
            view.model = model;
            [self presentViewController:view animated:YES completion:^{
                
            }];
        }];
        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"好,知道了" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        
        self.alertController = [UIAlertController alertControllerWithTitle:@"您现在使用的是蜂窝数据,\n继续播放么?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [self.alertController addAction:actionPlay];
        [self.alertController addAction:actionOK];
        [self presentViewController:self.alertController animated:YES completion:^{
            
        }];
        
    } else {
        MyEyesSectionModel *modelSection = self.arrModel[self.currentIndexPath.section];
        MyEyesCellModel *model = modelSection.videoListModel[self.currentIndexPath.row];
        RLPlayerViewController *view = [[RLPlayerViewController alloc] init];
        view.model = model;
        [self presentViewController:view animated:YES completion:^{
        
        }];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([self.playInfoView.contentScrollView isEqual:scrollView] || [self.playInfoView.contentView.coverScrollView isEqual:scrollView]) {
        self.tableView.alpha = 0;
    }
}
#pragma mark - 自定义scrollView滑动改变方式
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.playInfoView.contentScrollView) {
        
        self.playInfoView.contentView.coverScrollView.contentOffset = self.playInfoView.contentScrollView.contentOffset;
        

        
        //调用自定义换图方法
        for (EyesImageContentView *subView in scrollView.subviews) {
            if ([subView respondsToSelector:@selector(imageOffset)]) {
                [subView imageOffset];
            }
        }
        
        CGFloat x = self.playInfoView.contentScrollView.contentOffset.x;
        CGFloat off = 1.0;
        self.contentOffsetXNew = x;
        if (self.contentOffsetXNew > self.contentOffsetXOld) {
            self.contentOffsetXOld = self.contentOffsetXNew;
            off = ABS((int)x % (int)SCREENFRAMEWEIGHT - SCREENFRAMEWEIGHT) / SCREENFRAMEWEIGHT;
        } else {
            self.contentOffsetXOld = self.contentOffsetXNew;
            off = ABS((int)x % (int)SCREENFRAMEWEIGHT) / SCREENFRAMEWEIGHT;
        }
        [UIView animateWithDuration:0.5 animations:^{
            self.playInfoView.playView.alpha = off;
            self.playInfoView.contentView.textLabelTitle.alpha = off;
            self.playInfoView.contentView.textLabelDescribe.alpha = off;
            self.playInfoView.contentView.textLabelInfoVideo.alpha = off;
            self.playInfoView.contentView.backImageView.alpha = off;
            self.playInfoView.contentView.shareCount.alpha = off;
            self.playInfoView.contentView.collectionCount.alpha = off;
            self.playInfoView.contentView.download.alpha = off;
            self.playInfoView.contentView.replyCount.alpha = off;
            self.playInfoView.contentView.lineView.alpha = off;

        }];
        
        
        
    } else if ([scrollView isEqual:self.playInfoView.contentView.coverScrollView]) {
        self.playInfoView.contentScrollView.contentOffset = self.playInfoView.contentView.coverScrollView.contentOffset;
    }
    else {
        NSArray *arrCell = [self.tableView visibleCells];
        for (MyEyesTableViewCell *cell in arrCell) {
            [cell cellOffset];
        }
        self.tableViewContenOffset = scrollView.contentOffset;
    }
}

// 结束滑动时改变cell的位置对应手势回滑
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.tableView.alpha = 1;
    if ([scrollView isEqual:self.playInfoView.contentScrollView] || [scrollView isEqual:self.playInfoView.contentView.coverScrollView]) {
        

        // 滑动结束时恢复alpha
        [UIView animateWithDuration:0.5 animations:^{
            self.playInfoView.playView.alpha = 1;
            self.playInfoView.contentView.textLabelTitle.alpha = 1;
            self.playInfoView.contentView.textLabelDescribe.alpha = 1;
            self.playInfoView.contentView.textLabelInfoVideo.alpha = 1;
            self.playInfoView.contentView.backImageView.alpha = 1;
            self.playInfoView.contentView.shareCount.alpha = 1;
            self.playInfoView.contentView.collectionCount.alpha = 1;
            self.playInfoView.contentView.download.alpha = 1;
            self.playInfoView.contentView.replyCount.alpha = 1;
            self.playInfoView.contentView.lineView.alpha = 1;
        }];
        // 向上取整计算滑动到第几个cell 除2 算法防止回弹取值越界
        //
        int index = ceilf((self.playInfoView.contentScrollView.contentOffset.x - scrollView.frame.size.width / 2) / scrollView.frame.size.width);
        
        self.currentIndexPath = [NSIndexPath indexPathForRow:index inSection:self.currentIndexPath.section];
        //设置cell滚动对应的scrollView
        [self.tableView scrollToRowAtIndexPath:self.currentIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        
        MyEyesTableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.currentIndexPath];
        [cell cellOffset];
        
        // 获取cell相对于窗口的frame
        CGRect rect = [cell convertRect:cell.bounds toView:nil];
        // 改变playInfoView的参数 以及动画参数
        self.playInfoView.offSetY = rect.origin.y;
        self.playInfoView.animationTrans = cell.imageViewBackImage.transform;
        
        MyEyesCellModel *model = [[self.arrModel[self.currentIndexPath.section] videoListModel] objectAtIndex:self.currentIndexPath.row];
        [self.playInfoView.animationView.imageViewBackImage sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail] placeholderImage:nil];
        
        
        [self.playInfoView.contentView changeData:model WithArrCollectModel:self.arrCollectionModel];
        
    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.playInfoView.contentScrollView] || [scrollView isEqual:self.playInfoView.contentView.coverScrollView]) {
        
        if (scrollView.contentOffset.x < 0) {
            if (self.currentIndexPath.section > 0) {
                [self changePlayInfoWithDirection:0];
                [self creatloadView];
                
                
            } else {
                [self.playInfoView animationDismissUsingCompeteBlock:^{
                    [self.tableView.mj_header beginRefreshing];
                    self.playInfoView = nil;
                }];
                [self creatloadView];
            }
            
        } else if (scrollView.contentOffset.x > self.scrollMaxContentOffset - SCREENFRAMEWEIGHT) {
            if (self.currentIndexPath.section < self.arrModel.count - 1) {
                [self changePlayInfoWithDirection:1];
                [self creatloadView];
                
                
            } else {
                [self.playInfoView animationDismissUsingCompeteBlock:^{
                    [self.tableView.mj_footer beginRefreshing];
                    self.playInfoView = nil;
                }];
                [self creatloadView];
            }
        }
    }

}

- (void)creatloadView {
    [UIView animateWithDuration:1.0 animations:^{
        self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        self.activityView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:self.activityView];
        [self.activityView startAnimating];
    } completion:^(BOOL finished) {
            [self.activityView removeFromSuperview];
    }];
}

// 滑动判断位置更新playInfo数据
- (void)changePlayInfoWithDirection:(int)type {
    [self.playInfoView removeFromSuperview];
    
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    if (type == 0) {
        self.arrImages = [self.arrModel[self.currentIndexPath.section - 1] videoListModel];
        indexPath = [NSIndexPath indexPathForRow:self.arrImages.count - 1 inSection:self.currentIndexPath.section - 1];
    } else {
        self.arrImages = [self.arrModel[self.currentIndexPath.section + 1] videoListModel];
        indexPath = [NSIndexPath indexPathForRow:0 inSection:self.currentIndexPath.section + 1];
    }
    //设置cell滚动对应的scrollView
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    
    MyEyesTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    CGRect rect = [cell convertRect:cell.bounds toView:nil];
    CGFloat y = rect.origin.y;
    // 创建待播放View
    self.playInfoView = [[EyesPlayInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT) imageArray:self.arrImages arrCollectModel:self.arrCollectionModel index:indexPath.row];
    self.playInfoView.offSetY = y;
    self.playInfoView.animationTrans = cell.imageViewBackImage.transform;
    self.playInfoView.animationView.imageViewBackImage.image = cell.imageViewBackImage.image;
    self.playInfoView.delegate = self;
    self.playInfoView.animationView.alpha = 0;
    self.playInfoView.contentScrollView.alpha = 1;
    self.playInfoView.playView.alpha = 1;
    
    // 消失动画初始化
    self.playInfoView.animationView.frame = CGRectMake(0, 64, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 1.7);
    self.playInfoView.animationView.imageViewBackImage.transform = CGAffineTransformMakeTranslation(0,  (SCREENFRAMEHEIGHT / 1.7 - SCREENFRAMEHEIGHT / 3)/2);
    self.playInfoView.contentView.frame = CGRectMake(0, SCREENFRAMEHEIGHT / 1.7 + 64, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT - SCREENFRAMEHEIGHT / 1.7 - 64);
    
    self.playInfoView.contentScrollView.delegate = self;
    self.playInfoView.contentView.coverScrollView.delegate = self;
    
    [[self.tableView superview] addSubview:self.playInfoView];
    
    // 添加上滑手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.playInfoView.contentView addGestureRecognizer:swipe];
    
    
    // 添加点击播放
    UITapGestureRecognizer *tapPlay = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPlayAction:)];
    [self.playInfoView.contentScrollView addGestureRecognizer:tapPlay];
    self.currentIndexPath = indexPath;

}

#pragma mark - EyesPlayInfoViewDelegate
- (void)clickShareBtn:(RLBaseBtnLabelView *)sender WithModel:(MyEyesCellModel *)model {


}
- (void)clickDownloadBtn:(RLBaseBtnLabelView *)sender WithModel:(MyEyesCellModel *)model {
    NSLog(@"%s", __FUNCTION__);
    
}
- (void)clickCollectionBtn:(RLBaseBtnLabelView *)sender WithModel:(MyEyesCellModel *)model {
    NSLog(@"%s", __FUNCTION__);
    sender.selected =! sender.isSelected;
    if (sender.selected) {
        [self collectionMyEyesCellModel:model];
        sender.btnImageView.image = sender.btnSelectedImage;
    } else {
        [self deleteFromSqliteWithModel:model];
        sender.btnImageView.image = sender.btnImage;
    }
}
#pragma mark - 评论界面
- (void)clickReplyBtn:(RLBaseBtnLabelView *)sender WithModel:(MyEyesCellModel *)model {
    
    self.eyesBtn.enabled = NO;
    
    ReplyEyesView *view = [[ReplyEyesView alloc] initWithFrame:[UIScreen mainScreen].bounds Model:model];
    [self.view addSubview:view];
    [view showAnimation];
    self.replyView = view;
    view.delegate = self;
    self.playInfoView.playView.alpha = 0;
    NSLog(@"%s", __FUNCTION__);
    [RLNetWorkTool getWithURL:[NSString stringWithFormat:NETREPLY, model.ID] Parameter:nil HttpHeader:nil ResponseType:ResponseTypeJSON Progress:^(NSProgress *progress) {
        
    } Success:^(id result) {
        self.replyView.arrModel = [ReplyModel getMyEyesReplyModelFromDataArr:[result valueForKey:@"replyList"]];
        [self.replyView.tableViewReply reloadData];
    } Failure:^(NSError *error) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self clickReplyBtn:sender WithModel:model];
        }];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络连接失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{
            
        }];

    }];
}

- (void)backBtnClick:(UIButton *)sender {
    self.eyesBtn.enabled = YES;
    [self.replyView dismisAnimation];
    [UIView animateWithDuration:0.5 animations:^{
        self.playInfoView.playView.alpha = 1;
    }];
}



#pragma mark - 收藏

// 建表查询收藏的模型数组
- (void)creatTableSqlite {
    self.arrCollectionModel = [NSMutableArray array];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingString:@"/Vision.sqlite"];
    NSLog(@"%@", path);
    FMDatabase *dataBase = [FMDatabase databaseWithPath:path];
    self.dataBase = dataBase;
    BOOL open = [dataBase open];
    if (open) {
        [dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_MyEyesCellModel (ID integer, duration integer, idx integer, date integer, title text, webUrl text, rawWebUrl text, playUrl text, descriptionText text, category text, coverBlurred text, coverForFeed text, coverForDetail text, coverForSharing text, collection integer, collectionCount integer, shareCount integer, replyCount integer, playCount integer)"];
        
        FMResultSet *result = [dataBase executeQuery:@"SELECT * FROM t_MyEyesCellModel"];
        while (result.next) {
            MyEyesCellModel *model = [[MyEyesCellModel alloc] init];
            model.ID = [result intForColumn:@"ID"];
            model.duration = [result intForColumn:@"duration"];
            model.idx = [result intForColumn:@"idx"];
            model.date = [result intForColumn:@"date"];
            model.consumptionModel.collectionCount = [result intForColumn:@"collectionCount"];
            model.consumptionModel.shareCount = [result intForColumn:@"shareCount"];
            model.consumptionModel.replyCount = [result intForColumn:@"replyCount"];
            model.consumptionModel.playCount = [result intForColumn:@"playCount"];
            model.collection = [result intForColumn:@"title"];
            
            model.title = [result stringForColumn:@"title"];
            model.webUrl = [result stringForColumn:@"webUrl"];
            model.rawWebUrl = [result stringForColumn:@"rawWebUrl"];
            model.playUrl = [result stringForColumn:@"playUrl"];
            model.descriptionText = [result stringForColumn:@"descriptionText"];
            model.category = [result stringForColumn:@"category"];
            model.coverBlurred = [result stringForColumn:@"coverBlurred"];
            model.coverForFeed = [result stringForColumn:@"coverForFeed"];
            model.coverForDetail = [result stringForColumn:@"coverForDetail"];
            model.coverForSharing = [result stringForColumn:@"coverForSharing"];
            
            [self.arrCollectionModel addObject:model];
        }
        
        [dataBase close];
    }
}

- (void)collectionMyEyesCellModel:(MyEyesCellModel *)model {
    [self.arrCollectionModel addObject:model];
    ConsumptionModel *modelConsunmp = model.consumptionModel;
    BOOL open = [self.dataBase open];
    if (open) {
        modelConsunmp.shareCount = 0;
    BOOL result =[self.dataBase executeUpdate:@"INSERT INTO t_MyEyesCellModel (ID, duration, idx, date, title, webUrl, rawWebUrl, playUrl, descriptionText, category, coverBlurred, coverForFeed, coverForDetail, coverForSharing, collection, collectionCount, shareCount, replyCount, playCount) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NSNumber numberWithInteger:model.ID], [NSNumber numberWithInteger:model.duration], [NSNumber numberWithInteger:model.idx], [NSNumber numberWithInteger:model.date], model.title, model.webUrl, model.rawWebUrl, model.playUrl, model.descriptionText, model.category, model.coverBlurred, model.coverForFeed, model.coverForDetail, model.coverForSharing, [NSNumber numberWithInteger:model.collection], [NSNumber numberWithInteger:model.consumptionModel.collectionCount], [NSNumber numberWithInteger:model.consumptionModel.shareCount], [NSNumber numberWithInteger:model.consumptionModel.replyCount], [NSNumber numberWithInteger:model.consumptionModel.playCount]];
        NSLog(@"%d", result);
        
        [self.dataBase close];
        
    }
}

- (void)deleteFromSqliteWithModel:(MyEyesCellModel *)model {
    BOOL open = [self.dataBase open];
    MyEyesCellModel *removeModel = [[MyEyesCellModel alloc] init];
    for (MyEyesCellModel *tempModel in self.arrCollectionModel) {
        if (tempModel.duration == model.duration) {
            removeModel = tempModel;
        }
    }
    [self.arrCollectionModel removeObject:removeModel];
    if (open) {
        BOOL result = [self.dataBase executeUpdateWithFormat:@"DELETE FROM t_MyEyesCellModel WHERE title = %@ ", model.title];
        NSLog(@"%d", result);
    }
    
    
}



// 头标题日期改变
- (void)changeData:(NSInteger)section{
    if (section == 0) {
        self.dateLabel.text = @"Today";
    } else {
        MyEyesSectionModel *model = self.arrModel[section];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [formatter setDateFormat:@"MMM d"];
        self.dateLabel.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:model.date / 1000]];
    }
}

// 数据刷新
- (void)getDataSourceFromWeb:(NSString *)url{
    self.eyesBtn.enabled = NO;

//    NSLog(@"%@", url);
    [RLNetWorkTool getWithURL:url Parameter:nil HttpHeader:self.dicHeader ResponseType:ResponseTypeJSON Progress:^(NSProgress *progress) {
        
    } Success:^(id result) {
        NSMutableArray *arrModel = [MyEyesSectionModel getMyEyesSectionModelFromDataArr:[result valueForKey:@"dailyList"]];
        for (MyEyesCellModel *model in arrModel) {
            [self.arrModel addObject:model];
        }
        self.nextPageUrl = [result valueForKey:@"nextPageUrl"];

        NSString *dateStr = [NSString stringWithFormat:@"%@", [result valueForKey:@"nextPublishTime"]];
        NSInteger dateInteger = [dateStr integerValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateInteger / 1000];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [formatter setDateFormat:@"下次更新时间 MM-dd HH:mm"];
        self.nextPublishTime = [formatter stringFromDate:date];
        [self.tableView reloadData];
        // 关闭联网状态旋转圆圈
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        // 打开上拉加载
        self.tableView.mj_footer.hidden = NO;
        self.eyesBtn.enabled = YES;
    } Failure:^(NSError *error) {
#pragma mark - 添加弹窗网络连接失败
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self getDataSourceFromWeb:url];
        }];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络连接失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        NSLog(@"%@", error);
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
