//
//  ScreenCollectionViewCell.h
//  Vision
//
//  Created by Rilma.Liu on 16/3/5.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNewsPageColModel.h"
#import "MyNewsColumnModel.h"

@protocol ScreenCollectionCellDelegate <NSObject>

- (void)addNewsColumnModel:(MyNewsColumnModel *)model;
- (void)removewNewsColumnModel:(MyNewsColumnModel *)model;
- (void)scrollSearchBarResignFirstResponder;

@end


@interface ScreenCollectionViewCell : UICollectionViewCell<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MyNewsPageColModel *model;
@property (nonatomic, strong) NSMutableArray *arrModel;

@property (nonatomic, assign) id delegate;

@end
