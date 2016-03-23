//
//  UITabBarController+RLHiddenTabBar.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/2.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "UITabBarController+RLHiddenTabBar.h"

@implementation UITabBarController (RLHiddenTabBar)

- (void)hiddenTabBar:(bool)hidden {
    // 设置tabBar动画
    [UIView beginAnimations:@"filpping" context:NULL];
    [UIView setAnimationDuration:0.5];
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, SCREENFRAMEHEIGHT, view.frame.size.width, view.frame.size.height)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, SCREENFRAMEHEIGHT - 49, view.frame.size.width, view.frame.size.height)];
            }
        } else {
            if ([view isKindOfClass:NSClassFromString(@"UITransitionView")]) {
                if (hidden) {
                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, SCREENFRAMEHEIGHT)];
                } else {
                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, SCREENFRAMEHEIGHT - 49)];
                }
            }
        }
    }
    [UIView commitAnimations];
}

@end
