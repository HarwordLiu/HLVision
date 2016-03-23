//
//  SingleNewsViewController.m
//  Vision
//
//  Created by 刘浩 on 16/3/7.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "SingleNewsViewController.h"
#import "ArticleModel.h"
#import "RLNetWorkTool.h"
#import "SingleNewsTableViewCell.h"
#import "UIImageView+RLTransfrom.h"
#import <SDWebImageManager.h>
#import "SingleNewsWebViewController.h"


@interface SingleNewsViewController ()<NSXMLParserDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *btnBack;

@property (nonatomic, strong) NSMutableArray *arrModel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;


@property (nonatomic, assign) SingleNewsWebViewController *viewController;

@end

@implementation SingleNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataSourceFromWeb];
    [self creatSubView];
}

#pragma mark - 判断是否支持3Dtouch

- (void)check3DTouchAvailableWithCell:(SingleNewsTableViewCell *)cell {
    // 如果开启了3D touch，注册
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:(id)self sourceView:cell];
    }
}

// peek
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)context viewControllerForLocation:(CGPoint)point {
    //防止重复加入
    if ([self.presentedViewController isKindOfClass:[SingleNewsWebViewController class]]){
        return nil;
    }
    else {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(SingleNewsTableViewCell *)[context sourceView]];
        SingleNewsWebViewController *peekViewController = [[SingleNewsWebViewController alloc] init];
        peekViewController.model = self.arrModel[indexPath.row];
        peekViewController.navigationItem.hidesBackButton = YES;
        
        return peekViewController;
    }
}

// pop
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    [self showViewController:viewControllerToCommit sender:self];
}




- (void)creatSubView {
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 18)];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont fontWithName:@"Lobster1.4" size:28];
    titleView.text = self.model.Text;
    titleView.userInteractionEnabled = YES;
    self.navigationItem.titleView = titleView;
    
    self.btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnBack.frame = CGRectMake(5, 5, 30, 30);
    [self.btnBack setImage:[UIImage imageNamed:@"btn_back_black"] forState:UIControlStateNormal];
    [self.btnBack addTarget:self action:@selector(clickBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:self.btnBack];
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:self.tableView];
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [self.view addSubview:self.activityView];
    [self.activityView startAnimating];
    
}

- (void)clickBtnBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREENFRAMEHEIGHT / 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrModel.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"singleCell";
    SingleNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SingleNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    [self check3DTouchAvailableWithCell:cell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ArticleModel *model = self.arrModel[indexPath.row];
    cell.model = model;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SingleNewsWebViewController *peekViewController = [[SingleNewsWebViewController alloc] init];
    peekViewController.model = self.arrModel[indexPath.row];
    peekViewController.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:peekViewController animated:YES];
    // 记录触摸第几个cell
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
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


- (void)getDataSourceFromWeb{
    [RLNetWorkTool getWithURL:[NSString stringWithFormat:NETSINGENEW, self.model.TagId] Parameter:nil HttpHeader:nil ResponseType:ResponseTypeXML Progress:^(NSProgress *progress) {
        
    } Success:^(id result) {
        NSXMLParser *parser = result;
        parser.delegate = self;
        [parser parse];
        
    } Failure:^(NSError *error) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self getDataSourceFromWeb];
        }];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络连接失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }];
}

#pragma mark - XML解析

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"开始解析了");
    // 数组初始化
    self.arrModel = [NSMutableArray array];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    if ([elementName isEqualToString:@"Article"]) {
        ArticleModel *articleModel = [ArticleModel baseModelWithDict:attributeDict];
        [self.arrModel addObject:articleModel];
    } else if ([elementName isEqualToString:@"Tag"]) {
        ArticleModel *articleModel = [self.arrModel lastObject];
        TagModel *tagModel = [TagModel baseModelWithDict:attributeDict];
        [articleModel.tags addObject:tagModel];
    } else if ([elementName isEqualToString:@"Media"]) {
        ArticleModel *articleModel = [self.arrModel lastObject];
        MediaModel *mediaModel = [MediaModel baseModelWithDict:attributeDict];
        [articleModel.medias addObject:mediaModel];
    } else if ([elementName isEqualToString:@"Advert"]) {
        ArticleModel *articleModel = [self.arrModel lastObject];
        AdvertModel *advertModel = [AdvertModel baseModelWithDict:attributeDict];
        [articleModel.adverts addObject:advertModel];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    [self.activityView removeFromSuperview];
    [self.tableView reloadData];
    NSLog(@"解析结束");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
