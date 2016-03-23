//
//  RLVTabBarController.m
//  Vision
//
//  Created by Rilma.Liu on 16/2/26.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "RLVTabBarController.h"
#import "MyEyesViewController.h"
#import "MyNewsViewController.h"
#import "ColumnViewController.h"
#import "MoreViewController.h"

@interface RLVTabBarController ()

@end

@implementation RLVTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyEyesViewController *MyEyesVC = [[MyEyesViewController alloc] init];
    [self addChild:MyEyesVC image:@"myEyes" imageSele:@"myEyes" title:@"每日视界"];
    
    ColumnViewController *MyColumnsVC = [[ColumnViewController alloc] init];
    [self addChild:MyColumnsVC image:@"column" imageSele:@"column" title:@"我的栏目"];
    
    MyNewsViewController *MyNewsVC = [[MyNewsViewController alloc] init];
    [self addChild:MyNewsVC image:@"myNews" imageSele:@"myNews" title:@"科技快讯"];
    
    MoreViewController *MyMoreVC = [[MoreViewController alloc] init];
    [self addChild:MyMoreVC image:@"more" imageSele:@"more" title:@"更多"];
    
}


- (void)addChild:(UIViewController *)childVC
           image:(NSString *)image
       imageSele:(NSString *)imageSele
           title:(NSString *)title{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVC];
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image =
    [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage =
    [[UIImage imageNamed:imageSele] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 取消tabbar文字渲染效果,属性字符串
    NSMutableDictionary *dicTemp = [NSMutableDictionary dictionary];
    dicTemp[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *dicTempTwo = [NSMutableDictionary dictionary];
    dicTempTwo[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    [childVC.tabBarItem
     setTitleTextAttributes:dicTemp forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:dicTempTwo forState:
     UIControlStateSelected];
    
    [self addChildViewController:nav];
    
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
