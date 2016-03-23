//
//  NSDate+RLSinceNow.h
//  Vision
//
//  Created by Rilma.Liu on 16/3/10.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RLSinceNow)

+ (NSString *)sinceNowToDate:(long long)timer;

@end
