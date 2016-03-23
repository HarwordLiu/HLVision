//
//  ColumnEyesViewController.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/4.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "ColumnEyesViewController.h"


@interface ColumnEyesViewController ()



@end

@implementation ColumnEyesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeImageBtn];
    
}

- (void)changeImageBtn {
    self.dateLabel.alpha = 0;
    self.titleViewLabel.text = self.model.name;
    [self.setBtn setImage:[UIImage imageNamed:@"btn_back_black"] forState:UIControlStateNormal];
    
}
- (void)clickBtnSet:(UIButton *)sender {
    [self.tabBarController hiddenTabBar:NO];
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)headerRefresh:(MJRefreshGifHeader *)header {
    // 初始化数组
    self.arrModel = [NSMutableArray array];
    MyEyesSectionModel *model = [[MyEyesSectionModel alloc] init];
    [self.arrModel addObject:model];
    // 获取系统时间
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //    [dateFormatter setDateFormat:@"yyyyMMdd"];
    //    NSDate *date = [NSDate date];
    //    NSString *dateString = [dateFormatter stringFromDate:date];
    [self getDataSourceFromWeb:self.URL];
    [header setTitle:self.nextPublishTime forState:MJRefreshStateIdle];
    [header setTitle:self.nextPublishTime forState:MJRefreshStateRefreshing];
    [header setTitle:self.nextPublishTime forState:MJRefreshStatePulling];
    // 显示联网状态旋转圆圈
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.tableView.mj_header endRefreshing];
    
    
}


// 数据刷新
- (void)getDataSourceFromWeb:(NSString *)url{
    [RLNetWorkTool getWithURL:url Parameter:nil HttpHeader:self.dicHeader ResponseType:ResponseTypeJSON Progress:^(NSProgress *progress) {
        
    } Success:^(id result) {
        NSMutableArray *arrModel = [result valueForKey:@"videoList"];
        MyEyesSectionModel *modelVideo = self.arrModel[0];
        for (NSDictionary *dic in arrModel) {
            MyEyesCellModel *model = [[MyEyesCellModel alloc] initWithDict:dic];
            [modelVideo.videoListModel addObject:model];
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
