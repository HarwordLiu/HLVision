//
//  MoreViewController.m
//  Vision
//
//  Created by Rilma.Liu on 16/2/26.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "MoreViewController.h"
#import "MyCollectViewController.h"
#import "UesrAgreementViewController.h"
#import <SDImageCache.h>

@interface MoreViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrSet;
@property (nonatomic, strong) UIAlertController *alertController;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSubView];
}

- (void)creatSubView {
    // 导航视图
    NSArray *arrSet = [NSArray arrayWithObjects:@"我的收藏", @"清理缓存", @"用户协议", @"视频功能声明", @"版权举报", @"前往app评分", nil];
    self.arrSet = arrSet;
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 18)];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont fontWithName:@"Lobster1.4" size:28];
    titleView.text = @"MORE";
    titleView.userInteractionEnabled = YES;
    self.navigationItem.titleView = titleView;
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrSet.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"setCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.arrSet[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:18];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MyCollectViewController *view = [[MyCollectViewController alloc] init];
        view.navigationItem.hidesBackButton = YES;
        [self.navigationController pushViewController:view animated:YES];
    } else if (indexPath.row == 2) {
        UesrAgreementViewController *view = [[UesrAgreementViewController alloc] init];
        view.textTitle = @"用户协议";
        view.textAgreement = AGREEMENT;
        view.navigationItem.hidesBackButton = YES;
        [self.navigationController pushViewController:view animated:YES];
    } else if (indexPath.row == 3) {
        UesrAgreementViewController *view = [[UesrAgreementViewController alloc] init];
        view.textTitle = @"视频功能声明";
        view.textAgreement = VIDEOAGREE;
        view.navigationItem.hidesBackButton = YES;
        [self.navigationController pushViewController:view animated:YES];
    } else if (indexPath.row == 4) {
        UesrAgreementViewController *view = [[UesrAgreementViewController alloc] init];
        view.textTitle = @"版权举报";
        view.textAgreement = VIDEOAGREE;
        view.navigationItem.hidesBackButton = YES;
        [self.navigationController pushViewController:view animated:YES];
    } else if (indexPath.row == 1) {
        [self deleteCache];
    }
}


- (void)magicTitle:(NSString *)title completion:(void (^)(void))completion {
    [self presentViewController:self.alertController animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:^{
                self.alertController.title = title;
                completion();
            }];
        });
    }];
}

// 清理缓存
- (void)deleteCache {
    __block NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    NSLog(@"%lu", size);
    NSString *sizeStr = @"当前无缓存,需要清理么?";
    if (size > 0 && size < 1024 * 1024) {
        sizeStr = [NSString stringWithFormat:@"当前缓存为%.1lukb,要清理么?", size / 1024];
    } else if (size > 1024 * 1024) {
        sizeStr = [NSString stringWithFormat:@"当前缓存为%.1luM,要清理么?", size / 1024 / 1024];
    }

    UIAlertAction *alertBack = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    size = [[SDImageCache sharedImageCache] getSize];
    UIAlertAction *alertClear = [UIAlertAction actionWithTitle:@"清理缓存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[SDImageCache sharedImageCache] clearDisk];
        size = [[SDImageCache sharedImageCache] getSize];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清理完成,当前缓存为0kb" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:alertBack];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:sizeStr message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:alertClear];
    [alertController addAction:alertBack];
    
    [self presentViewController:alertController animated:YES completion:^{

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
