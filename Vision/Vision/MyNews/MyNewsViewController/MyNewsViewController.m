//
//  MyNewsViewController.m
//  Vision
//
//  Created by Rilma.Liu on 16/2/26.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "MyNewsViewController.h"
#import "RLNetWorkTool.h"
#import "MyNewsColumnModel.h"
#import "MyNewsPageColModel.h"
#import "NewsCollectionViewCell.h"
#import "SeletedViewController.h"
#import "ScreenCollectionViewCell.h"
#import "SingleNewsViewController.h"
#import <FMDB.h>


@interface MyNewsViewController ()<NSXMLParserDelegate, UICollectionViewDelegate, UICollectionViewDataSource, SelectedViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *arrModel;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGRect navigationFrame;
@property (nonatomic, strong) MyNewsColumnModel *model;

@property (nonatomic, strong) FMDatabase *dataBase;

@end

@implementation MyNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataFromSqlite];
    [self creatSubView];
}

- (void)check3DTouchAvailableWithCell:(NewsCollectionViewCell *)cell {
    // 如果开启了3D touch，注册
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:(id)self sourceView:cell];
    }
}

// peek
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)context viewControllerForLocation:(CGPoint)point {
    //防止重复加入
    if ([self.presentedViewController isKindOfClass:[SingleNewsViewController class]]){
        return nil;
    }
    else {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:(NewsCollectionViewCell *)[context sourceView]];
        
        SingleNewsViewController *peekViewController = [[SingleNewsViewController alloc] init];
        peekViewController.model = self.arrModel[indexPath.row];
        peekViewController.navigationItem.hidesBackButton = YES;
        
        return peekViewController;
    }
}

// pop
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    [self showViewController:viewControllerToCommit sender:self];
}


- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.frame = self.navigationFrame;
    [[self.navigationController.navigationBar viewWithTag:1002] removeFromSuperview];
}

- (void)getDataFromSqlite {
    self.arrModel = [NSMutableArray array];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingString:@"/Vision.sqlite"];
    NSLog(@"%@", path);
    FMDatabase *dataBase = [FMDatabase databaseWithPath:path];
    self.dataBase = dataBase;
    BOOL open = [dataBase open];
    if (open) {
        NSLog(@"数据库打开成功");
        [dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_NewsColumn (AffiliateLinkIds text, Nb text, Push text, RegionId text, TagId text, Text text, Url text, Weight text, selected integer, addSelected integer)"];
        FMResultSet *result = [dataBase executeQuery:@"SELECT * FROM t_NewsColumn"];
        while (result.next) {
            MyNewsColumnModel *model = [[MyNewsColumnModel alloc] init];
            model.AffiliateLinkIds = [result stringForColumn:@"AffiliateLinkIds"];
            model.Nb = [result stringForColumn:@"Nb"];
            model.Push = [result stringForColumn:@"Push"];
            model.RegionId = [result stringForColumn:@"RegionId"];
            model.TagId = [result stringForColumn:@"TagId"];
            model.Text = [result stringForColumn:@"Text"];
            model.Url = [result stringForColumn:@"Url"];
            model.Weight = [result stringForColumn:@"Weight"];
            model.selected = [result intForColumn:@"selected"];
            model.add = [result intForColumn:@"addSelected"];
            [self.arrModel addObject:model];
        }
        [dataBase close];
    }
    
    self.model = [[MyNewsColumnModel alloc] init];
    self.model.add = YES;
    [self.arrModel addObject:self.model];
    
}

- (void)creatSubView {

    self.view.backgroundColor = [UIColor blackColor];
    
    self.navigationFrame = self.navigationController.navigationBar.frame;
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 18)];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont fontWithName:@"Lobster1.4" size:28];
    titleView.text = @"SCIENCE";
    titleView.userInteractionEnabled = YES;
    self.navigationItem.titleView = titleView;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(SCREENFRAMEWEIGHT / 3, SCREENFRAMEHEIGHT / 6);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[NewsCollectionViewCell class] forCellWithReuseIdentifier:NEWSCOLLECTIONVIEWCELL];
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.arrModel.count == 0) {
        return 1;
    }
    return self.arrModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NEWSCOLLECTIONVIEWCELL forIndexPath:indexPath];
    MyNewsColumnModel *model = self.arrModel[indexPath.row];
    [self check3DTouchAvailableWithCell:cell];
    if (model.add == YES) {
        cell.textLabelTitle.alpha = 0;
        cell.backImageView.image = [UIImage imageNamed:@"add"];
    } else {
        cell.model = model;
        
    }
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.arrModel.count - 1) {
        SeletedViewController *view = [[SeletedViewController alloc] init];
        view.navigationItem.hidesBackButton = YES;
        view.MyNewsModels = self.arrModel;
        view.delegate = self;
        [self.navigationController pushViewController:view animated:YES];
    } else {
        SingleNewsViewController *view = [[SingleNewsViewController alloc] init];
        view.model = self.arrModel[indexPath.row];
        view.navigationItem.hidesBackButton = YES;
        [self.navigationController pushViewController:view animated:YES];
    }
}

- (void)sentModelArray:(NSMutableArray *)arrModel {
    self.arrModel = arrModel;
    [self.arrModel removeObject:self.model];
    [self.collectionView reloadData];
    BOOL result = [self.dataBase open];
    if (result) {
        [self.dataBase executeUpdate:@"DELETE FROM t_NewsColumn"];
        for (MyNewsColumnModel *model in self.arrModel) {
            [self.dataBase executeUpdate:@"INSERT INTO t_NewsColumn (AffiliateLinkIds, Nb, Push, RegionId, TagId, Text, Url, Weight, selected, addSelected) VALUES (?,?,?,?,?,?,?,?,?,?)", model.AffiliateLinkIds, model.Nb, model.Push, model.RegionId, model.TagId, model.Text, model.Url, model.Weight, [NSNumber numberWithInteger:model.selected], [NSNumber numberWithInteger:model.add]];
        }
        [self.dataBase close];
    }
    
    [self.arrModel addObject:self.model];

    
    
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
