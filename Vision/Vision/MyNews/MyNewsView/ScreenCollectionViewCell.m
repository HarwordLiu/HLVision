//
//  ScreenCollectionViewCell.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/5.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "ScreenCollectionViewCell.h"
#import "NewsCollectionViewCell.h"
#import "SelectedCollectionViewCell.h"


@implementation ScreenCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubView];
    }
    return self;
}

- (void)creatSubView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(SCREENFRAMEWEIGHT / 3, SCREENFRAMEHEIGHT / 6);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEWEIGHT, SCREENFRAMEHEIGHT - 114) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.collectionView];
    
    // 允许多选选中
    self.collectionView.allowsMultipleSelection = YES;
    
    [self.collectionView registerClass:[SelectedCollectionViewCell class] forCellWithReuseIdentifier:NEWSCOLLECTIONVIEWCELL];
    
    
    
    
    
}

- (void)setArrModel:(NSMutableArray *)arrModel {
    if (_arrModel != arrModel) {
        _arrModel = arrModel;
    }
    // 在arrModel set方法进行reloadData方法防止数组越界
    [self.collectionView reloadData];
}

// 多选 选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SelectedCollectionViewCell *cell = (SelectedCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.model.selected) {
        [self.delegate removewNewsColumnModel:self.model.columnModel[indexPath.row]];
        [self changeUnSelectedStateCell:cell];
    } else {
        [self.delegate addNewsColumnModel:self.model.columnModel[indexPath.row]];
        [self changeSelectedStateCell:cell];
    }
    NSLog(@"%@, %s", @(cell.model.selected), __FUNCTION__);
    cell.model.selected =! cell.model.isSelected;
    return YES;
}
// 多选 取消选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    SelectedCollectionViewCell *cell = (SelectedCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.model.selected) {
        [self.delegate removewNewsColumnModel:self.model.columnModel[indexPath.row]];
        [self changeUnSelectedStateCell:cell];
    } else {
        [self.delegate addNewsColumnModel:self.model.columnModel[indexPath.row]];
        [self changeSelectedStateCell:cell];
    }
    NSLog(@"%@, %s", @(cell.model.selected), __FUNCTION__);
    cell.model.selected =! cell.model.isSelected;
    return YES;
}

- (void)changeSelectedStateCell:(SelectedCollectionViewCell *)cell {
    cell.selectedView.alpha = 1;
    cell.coverView.alpha = 0.5;
    cell.unSelectedView.alpha = 0;
}


- (void)changeUnSelectedStateCell:(SelectedCollectionViewCell *)cell {
    cell.selectedView.alpha = 0;
    cell.coverView.alpha = 0;
    cell.unSelectedView.alpha = 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.columnModel.count;
}

#pragma mark - cell 选中效果判断

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SelectedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NEWSCOLLECTIONVIEWCELL forIndexPath:indexPath];
    MyNewsColumnModel *model = self.model.columnModel[indexPath.row];
    for (MyNewsColumnModel *newsModel in self.arrModel) {
        if (newsModel.TagId == model.TagId) {
            model.selected = YES;
            [self changeSelectedStateCell:cell];
            // 判断成功跳出循环
            break;
        } else {
            model.selected = NO;
            [self changeUnSelectedStateCell:cell];
        }
    }
    cell.model = model;
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.delegate scrollSearchBarResignFirstResponder];
}





@end
