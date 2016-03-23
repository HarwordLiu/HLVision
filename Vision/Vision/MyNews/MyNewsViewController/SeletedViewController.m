//
//  SeletedViewController.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/5.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "SeletedViewController.h"
#import "MyNewsColumnModel.h"
#import "MyNewsPageColModel.h"
#import "RLNetWorkTool.h"
#import "ScreenCollectionViewCell.h"
#import "NewColumnCollectionViewCell.h"



@interface SeletedViewController ()<NSXMLParserDelegate, UICollectionViewDelegate, UICollectionViewDataSource, ScreenCollectionCellDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *arrModel;
@property (nonatomic, strong) NSMutableArray *arrSearchModel;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSXMLParser *searchParser;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, assign) BOOL searchState;

@property (nonatomic, strong) UICollectionView *backCollectionView;
@property (nonatomic, strong) UICollectionView *columnCollectionView;
@property (nonatomic, strong) UICollectionView *searchCollectionView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, strong) UILabel *searchInfomation;
@property (nonatomic, assign) BOOL searchTag;



@end

@implementation SeletedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataSourceFromWebWithURL:NETMYNEWS];
    [self creatSubView];

    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.backBtn removeFromSuperview];
    [self.searchBar removeFromSuperview];
    [self.columnCollectionView removeFromSuperview];
    [self.tabBarController hiddenTabBar:NO];

}

- (void)viewWillAppear:(BOOL)animated {
    [self.tabBarController hiddenTabBar:YES];



}


- (void)creatSubView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    self.navigationController.navigationBar.frame = CGRectMake(0, 0, SCREENFRAMEWEIGHT, 114);
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(5, 25, 30, 30);
    [self.backBtn setImage:[UIImage imageNamed:@"btn_back_black"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(clickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.backBtn];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(50, 20, SCREENFRAMEWEIGHT - 75, SCREENFRAMEHEIGHT / 18)];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.placeholder = @"请输入要搜索的栏目";

    self.searchBar = searchBar;
    self.searchBar.backgroundColor = [UIColor clearColor];
    self.searchBar.delegate = self;
    
    [self.navigationController.navigationBar addSubview:searchBar];
    
    UICollectionViewFlowLayout *backLayout = [[UICollectionViewFlowLayout alloc] init];
    backLayout.minimumLineSpacing = 0;
    backLayout.minimumInteritemSpacing = 0;
    backLayout.itemSize = CGSizeMake(SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT - 114);
    backLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.backCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 114, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT - 114) collectionViewLayout:backLayout];
    self.backCollectionView.tag = 1010;
    self.backCollectionView.delegate = self;
    self.backCollectionView.dataSource = self;
    self.backCollectionView.pagingEnabled = YES;
    self.backCollectionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.backCollectionView];

    [self.backCollectionView registerClass:[ScreenCollectionViewCell class] forCellWithReuseIdentifier:SCREENCOLLECTIONVIEW];
    
    self.searchState = NO;

    
    
    [self.searchCollectionView registerClass:[ScreenCollectionViewCell class] forCellWithReuseIdentifier:SEARCHCOLLECTIONVIEWCELL];
    
    UICollectionViewFlowLayout *columnLayout = [[UICollectionViewFlowLayout alloc] init];
    columnLayout.minimumLineSpacing = 0;
    columnLayout.minimumInteritemSpacing = 0;
    columnLayout.itemSize = CGSizeMake(SCREENFRAMEWEIGHT / 4, SCREENFRAMEHEIGHT / 20);
    columnLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self.columnCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT / 20) collectionViewLayout:columnLayout];
    self.columnCollectionView.backgroundColor = self.navigationController.view.backgroundColor;
//    self.columnCollectionView.backgroundColor = [UIColor greenColor];
    self.columnCollectionView.delegate = self;
    self.columnCollectionView.dataSource = self;
    self.columnCollectionView.showsHorizontalScrollIndicator = NO;
    [self.navigationController.navigationBar addSubview:self.columnCollectionView];
    
    [self.columnCollectionView registerClass:[NewColumnCollectionViewCell class] forCellWithReuseIdentifier:NEWCOLUMNCOLLECTIONVIEWCELL];
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [self.view addSubview:self.activityView];
    [self.activityView startAnimating];
    
    self.searchInfomation = [[UILabel alloc] initWithFrame:CGRectMake(0, 315, SCREENFRAMEWEIGHT, 60)];
    self.searchInfomation.text = @"没有搜索到符合条件的栏目";
    self.searchInfomation.textAlignment = NSTextAlignmentCenter;
    self.searchInfomation.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:18];
    self.searchInfomation.backgroundColor = [UIColor clearColor];
    self.searchInfomation.textColor = [UIColor whiteColor];
    self.searchInfomation.alpha = 0;
    [self.view addSubview:self.searchInfomation];
    
}

#pragma mark - 自定义tableviewItem界面代理实现
- (void)tapSearchView:(UITapGestureRecognizer *)sender {
    [self.searchBar resignFirstResponder];
}

- (void)addNewsColumnModel:(MyNewsColumnModel *)model {
    [self.MyNewsModels addObject:model];
}
- (void)scrollSearchBarResignFirstResponder {
    [self.searchBar resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}

- (void)removewNewsColumnModel:(MyNewsColumnModel *)model {
    MyNewsColumnModel *temp = [[MyNewsColumnModel alloc] init];
    for (MyNewsColumnModel *newsModel in self.MyNewsModels) {
        if (newsModel.TagId == model.TagId) {
            temp = newsModel;
        }
    }
    [self.MyNewsModels removeObject:temp];

}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.searchState = YES;
    self.searchCollectionView.alpha = 1;
    searchText = [searchText stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (![searchText isEqualToString:@""]) {
        NSString *URLstr = [NSString stringWithFormat:NETSEARCH, searchText];
        NSString *URL = [URLstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self getSearchDataSourceFromWebWithURL:URL];
    }
}



- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
        return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.searchState == YES) {
        return self.arrSearchModel.count;
    } else {
        return self.arrModel.count;
    }

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyNewsPageColModel *model = [[MyNewsPageColModel alloc] init];
    if (self.searchState == NO) {
        model = self.arrModel[indexPath.row];
    } else {
        model = self.arrSearchModel[indexPath.row];
    }
    if (self.backCollectionView == collectionView) {
        
        ScreenCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SCREENCOLLECTIONVIEW forIndexPath:indexPath];
        cell.model = model;
        cell.arrModel = self.MyNewsModels;
        cell.delegate = self;
        cell.backgroundColor = [UIColor blackColor];
        return cell;
    } else {
        
        NewColumnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NEWCOLUMNCOLLECTIONVIEWCELL forIndexPath:indexPath];
        cell.textLabelColumn.text = model.text;
        cell.textLabelColumn.font = [UIFont boldSystemFontOfSize:15];
        return cell;
    }
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == 1010) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:scrollView.contentOffset.x / SCREENFRAMEWEIGHT inSection:0];
        [self.columnCollectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        [self collectionView:self.columnCollectionView didSelectItemAtIndexPath:indexPath];
    }
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.columnCollectionView == collectionView) {
        NSArray *arrCells = [collectionView visibleCells];
        for (NewColumnCollectionViewCell *temp in arrCells) {
            temp.textLabelColumn.font = [UIFont boldSystemFontOfSize:15];
        }
        NewColumnCollectionViewCell *cell = (NewColumnCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [UIView animateWithDuration:0.5 animations:^{
            cell.textLabelColumn.font = [UIFont boldSystemFontOfSize:17];
        }];
        [self.backCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    } if (self.backCollectionView == collectionView) {
        [self.columnCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}



- (void)clickBackBtn:(UIButton *)sender {
    self.searchInfomation.alpha = 0;
    if (self.searchState == YES) {
        self.searchState = NO;
        [self.columnCollectionView reloadData];
        [self.backCollectionView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self collectionView:self.columnCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [self.columnCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
            
        });
        [self.searchBar resignFirstResponder];
        self.searchBar.text = @"";
    } else {
    
        [self.delegate sentModelArray:self.MyNewsModels];
        self.navigationItem.hidesBackButton = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}



- (void)getSearchDataSourceFromWebWithURL:(NSString *)url {
    self.searchInfomation.alpha = 0;
    self.searchTag = NO;
    self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.activityView.backgroundColor = [UIColor blackColor];
    self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [self.view addSubview:self.activityView];
    [self.activityView startAnimating];
    self.arrSearchModel = [NSMutableArray array];
    MyNewsPageColModel *pageColModel = [[MyNewsPageColModel alloc] init];
    pageColModel.text = @"搜索结果";
    [self.arrSearchModel addObject:pageColModel];
    [RLNetWorkTool getWithURL:url Parameter:nil HttpHeader:nil ResponseType:ResponseTypeXML Progress:^(NSProgress *progress) {
        
    } Success:^(id result) {
        NSXMLParser *parser = result;
        parser.delegate = self;
        self.searchParser = parser;
        [parser parse];
        
        
    } Failure:^(NSError *error) {

    }];
}


- (void)getDataSourceFromWebWithURL:(NSString *)url{
    self.arrModel = [NSMutableArray array];
    self.searchTag = YES;
    [RLNetWorkTool getWithURL:url Parameter:nil HttpHeader:nil ResponseType:ResponseTypeXML Progress:^(NSProgress *progress) {
        
    } Success:^(id result) {
        NSXMLParser *parser = result;
        parser.delegate = self;
        [parser parse];

    } Failure:^(NSError *error) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self getSearchDataSourceFromWebWithURL:url];
        }];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络连接失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }];
}

#pragma mark - XML数据解析
- (void)parserDidStartDocument:(NSXMLParser *)parser{

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    if ([elementName isEqualToString:@"Category"]) {
        MyNewsPageColModel *pageColModel = [[MyNewsPageColModel alloc] init];
        pageColModel.text = [attributeDict valueForKey:@"Text"];
        [self.arrModel addObject:pageColModel];
    } else if ([elementName isEqualToString:@"Tag"]) {
        if (self.searchParser == parser) {
            self.searchTag = YES;
            MyNewsPageColModel *pageColModel = [self.arrSearchModel lastObject];
            MyNewsColumnModel *columnModel = [MyNewsColumnModel baseModelWithDict:attributeDict];
            [pageColModel.columnModel addObject:columnModel];
        } else {
            MyNewsPageColModel *pageColModel = [self.arrModel lastObject];
            MyNewsColumnModel *columnModel = [MyNewsColumnModel baseModelWithDict:attributeDict];
            [pageColModel.columnModel addObject:columnModel];
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    [self.activityView removeFromSuperview];
    [self.backCollectionView reloadData];
    [self.columnCollectionView reloadData];
    if (self.searchTag == NO) {
        self.searchInfomation.alpha = 1;
    }


        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self collectionView:self.columnCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [self.columnCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        });

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
