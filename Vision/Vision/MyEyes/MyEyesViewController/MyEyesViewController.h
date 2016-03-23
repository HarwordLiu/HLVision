//
//  MyEyesViewController.h
//  Vision
//
//  Created by Rilma.Liu on 16/2/26.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "RLBaseViewController.h"
#import "MyEyesSectionModel.h"
#import "MyEyesCellModel.h"
#import "MyEyesTableViewCell.h"
#import "MyEyesHeaderFooterView.h"
#import <MJRefresh.h>
#import "RLNetWorkTool.h"
#import "ConsumptionModel.h"
#import "PlayInfoModel.h"
#import <SDWebImageManager.h>
#import "SDWebImageManager+RLCache.h"
#import "EyesPlayInfoView.h"
#import "EyesContentScrollView.h"
#import "EyesImageContentView.h"
#import "RLPlayerViewController.h"
#import <FMDB.h>

@interface MyEyesViewController : RLBaseViewController

@property (nonatomic, copy) NSString *URL;
@property (nonatomic, strong) NSDictionary *dicHeader;

@property (nonatomic, strong) NSMutableArray *arrModel;
@property (nonatomic, strong) NSMutableArray *arrCollectionModel;
@property (nonatomic, strong) FMDatabase *dataBase;

@property (nonatomic, copy) NSString *nextPageUrl;
@property (nonatomic, copy) NSString *nextPublishTime;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *titleViewLabel;
@property (nonatomic, strong) UIButton *eyesBtn;
@property (nonatomic, strong) UIButton *setBtn;

@property (nonatomic, strong) EyesPlayInfoView *playInfoView;
@property (nonatomic, strong) NSMutableArray *arrImages;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, strong) NSIndexPath *playInfoIndexPath;

@property (nonatomic, assign) CGFloat contentOffsetXNew;
@property (nonatomic, assign) CGFloat contentOffsetXOld;
@property (nonatomic, assign) NSInteger scrollMaxContentOffset;
@property (nonatomic, assign) CGPoint tableViewContenOffset;

@property (nonatomic, strong) UILabel *leftLabelDate;
@property (nonatomic, strong) UILabel *headerLabel;

@end
