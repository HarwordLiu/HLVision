//
//  UIImageView+RLTransfrom.h
//  Vision
//
//  Created by Rilma.Liu on 16/3/3.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImageManager.h>
#import "MyEyesCellModel.h"

@interface UIImageView (RLTransfrom)

- (void)transfromImageViewWith:(UIImageOrientation)Orientation
                         Model:(MyEyesCellModel *)model;


@end
