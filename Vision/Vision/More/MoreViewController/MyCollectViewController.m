//
//  MyCollectViewController.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/11.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "MyCollectViewController.h"

@interface MyCollectViewController ()

@end

@implementation MyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.setBtn setImage:[UIImage imageNamed:@"btn_back_black"] forState:UIControlStateNormal];
    self.dateLabel.text = @"";
    self.headerLabel.text = @"- Collection -";
}

- (void)creatTableSqlite {
    UILabel *label = [[UILabel alloc] initWithFrame:[UIScreen mainScreen].bounds];
    label.text = @"没有收藏过,快去收藏!!!";
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:18];
    self.arrModel = [NSMutableArray array];
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
    MyEyesSectionModel *model = [[MyEyesSectionModel alloc] init];
    
    for (MyEyesCellModel *modelCell in self.arrCollectionModel) {
        [model.videoListModel addObject:modelCell];
    }
    if (model.videoListModel.count == 0) {
        self.eyesBtn.enabled = NO;
        [self.view addSubview:label];
        
    } else if (model.videoListModel.count > 1) {
        self.eyesBtn.enabled = YES;
    } else {
        label = nil;
        self.eyesBtn.enabled = NO;
    }
    
    [self.arrModel addObject:model];
    [self.tableView reloadData];
}
- (void)clickBtnSet:(UIButton *)sender {
    NSLog(@"set");
    [self.tabBarController hiddenTabBar:NO];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

#pragma mark - 重写一些方法滞空 不执行
- (void)getDataSourceFromWeb:(NSString *)url {
    
}
- (void)setRefresh {
    
}
- (void)changeData:(NSInteger)section {
    
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
