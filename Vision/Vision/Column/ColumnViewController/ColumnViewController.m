//
//  ColumnViewController.m
//  Vision
//
//  Created by Rilma.Liu on 16/2/26.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "ColumnViewController.h"
#import "RLNetWorkTool.h"
#import "ColumnEyesModel.h"
#import "ColumnCollectionViewCell.h"
#import "ColumnEyesViewController.h"

@interface ColumnViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) NSMutableArray *arrEyesColumnModel;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;


@end

@implementation ColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataSourceFromWeb];
    [self creatSubView];
}

- (void)creatSubView {
    
    // 导航视图
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 18)];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont fontWithName:@"Lobster1.4" size:28];
    titleView.text = @"VISION";
    titleView.userInteractionEnabled = YES;
    self.navigationItem.titleView = titleView;
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(SCREENFRAMEWEIGHT / 2, SCREENFRAMEHEIGHT / 3);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[ColumnCollectionViewCell class] forCellWithReuseIdentifier:COLUMNCOLLECTIONVIEWCELL];
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [self.view addSubview:self.activityView];
    [self.activityView startAnimating];
    
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrEyesColumnModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ColumnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:COLUMNCOLLECTIONVIEWCELL forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ColumnCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT / 2, SCREENFRAMEHEIGHT / 3)];
    }
    cell.model = self.arrEyesColumnModel[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ColumnEyesModel *model = self.arrEyesColumnModel[indexPath.row];
    NSString *URLstr = [NSString stringWithFormat:NETCOLU, model.name];
    NSString *URL = [URLstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"%@", URL);
    ColumnEyesViewController *view = [[ColumnEyesViewController alloc] init];
    view.URL = URL;
    view.model = model;
    view.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:view animated:YES];
    
    
}

- (void)getDataSourceFromWeb{
    [RLNetWorkTool getWithURL:@"http://baobab.wandoujia.com/api/v1/categories" Parameter:nil HttpHeader:nil ResponseType:ResponseTypeJSON Progress:^(NSProgress *progress) {
        
    } Success:^(id result) {
        self.arrEyesColumnModel = [ColumnEyesModel getColumnEyesModelFromArr:result];
        [self.activityView removeFromSuperview];
        [self.collectionView reloadData];
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
