//
//  EyesContentScrollView.h
//  Vision
//
//  Created by Rilma.Liu on 16/2/29.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EyesImageContentView.h"
#import "MyEyesCellModel.h"

@interface EyesContentScrollView : UIScrollView


- (instancetype)initWithFrame:(CGRect)frame
                   imageArray:(NSArray *)imageArray
                        index:(NSInteger)index
                         Size:(CGFloat)size;


@end
