//
//  SeletedViewController.h
//  Vision
//
//  Created by Rilma.Liu on 16/3/5.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "RLBaseViewController.h"

@protocol SelectedViewControllerDelegate <NSObject>

- (void)sentModelArray:(NSMutableArray *)arrModel;

@end

@interface SeletedViewController : RLBaseViewController

@property (nonatomic, strong) NSMutableArray *MyNewsModels;

@property (nonatomic, assign) id delegate;


@end
