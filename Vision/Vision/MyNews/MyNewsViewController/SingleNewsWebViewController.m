//
//  SingleNewsWebViewController.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/11.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "SingleNewsWebViewController.h"

@interface SingleNewsWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton *setBtn;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;


@end

@implementation SingleNewsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSubView];
    

}
- (void)creatSubView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 18)];
    self.navigationItem.titleView = titleView;
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, SCREENFRAMEWEIGHT - 50, SCREENFRAMEHEIGHT / 18)];
    labelTitle.font = [UIFont fontWithName:@"Lobster1.4" size:21];
    labelTitle.text = self.model.Title;
    labelTitle.userInteractionEnabled = YES;
    [titleView addSubview:labelTitle];
    
    self.setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.setBtn.frame = CGRectMake(5, 5, 30, 30);
    [self.setBtn setImage:[UIImage imageNamed:@"btn_back_black"] forState:UIControlStateNormal];
    [self.setBtn addTarget:self action:@selector(clickBtnSet:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:self.setBtn];
    
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.model.Link]];
    [self.webView loadRequest:request];
    //    [self.webView loadHTMLString:self.model.Description baseURL:nil];
    self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    [self.view addSubview:self.activityView];
    [self.activityView startAnimating];

    
}
- (void)clickBtnSet:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)webViewDidStartLoad:(UIWebView *)webView {

    NSLog(@"strat");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityView removeFromSuperview];

    NSLog(@"finish");
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
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
