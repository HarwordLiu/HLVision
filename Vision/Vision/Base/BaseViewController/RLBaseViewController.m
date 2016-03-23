//
//  RLBaseViewController.m
//  Vision
//
//  Created by Rilma.Liu on 16/2/26.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "RLBaseViewController.h"
#import <AFNetworking.h>

@interface RLBaseViewController ()

@property (nonatomic, strong) UIAlertController *alertController;

@end

@implementation RLBaseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNETObbserver];
    

}

- (void)addNETObbserver {
    self.alertController = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                self.alertController.title = @"未知网络,请在有网络的情况下使用本应用";
                [self presentViewController:self.alertController animated:YES completion:^{
                    
                }];
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                self.alertController.title = @"没有网络,请在有网络的情况下使用本应用";
                [self presentViewController:self.alertController animated:YES completion:^{
                    
                }];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                self.alertController.title = @"网络已连接";
                [self backToVC];

                break;
                
                case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                self.alertController.title = @"网络已连接";
                [self backToVC];
                break;
        }
    }];
    [mgr startMonitoring];
    
}
- (void)backToVC {
    [UIView animateWithDuration:0.25 animations:^{
        [self.alertController dismissViewControllerAnimated:YES completion:^{
            
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
