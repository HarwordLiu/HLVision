//
//  UesrAgreementViewController.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/12.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "UesrAgreementViewController.h"

@interface UesrAgreementViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation UesrAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSubView];
}

- (void)creatSubView {
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 18)];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont fontWithName:@"Lobster1.4" size:28];
    titleView.text = self.textTitle;
    titleView.userInteractionEnabled = YES;
    self.navigationItem.titleView = titleView;
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 5, 30, 30);
    [backBtn setImage:[UIImage imageNamed:@"btn_back_black"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBtnSet:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:backBtn];
    
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    [self.webView loadHTMLString:self.textAgreement baseURL:nil];

}


- (void)clickBtnSet:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
