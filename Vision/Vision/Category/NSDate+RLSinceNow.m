//
//  NSDate+RLSinceNow.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/10.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "NSDate+RLSinceNow.h"

@implementation NSDate (RLSinceNow)


+ (NSString *)sinceNowToDate:(long long)timer {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSDate *sinceDate = [NSDate dateWithTimeIntervalSince1970:timer / 1000];
    NSString *sinceDateStr =  [dateFormatter stringFromDate:sinceDate];
    NSLog(@"%@", sinceDateStr);
    NSTimeInterval time = [sinceDate timeIntervalSinceNow];
    time = - time;
    if (time >= 0 && time < 3600) {
        int mins = ((int)time) / 60;
        return [NSString stringWithFormat:@"%d分钟前", mins];
    } else if (time >= 3600 && time < 3600 * 24) {
        int hours = ((int)time) / 3600;
        return [NSString stringWithFormat:@"%d小时前", hours];
    } else if (time >= 3600 * 24 && time < 3600 * 24 * 30) {
        int days = ((int)time) / (3600 * 24);
        return [NSString stringWithFormat:@"%d天前", days];
    } else if (time >= 3600 * 24 * 30 && time < 3600 * 24 * 30 * 12) {
        int months = ((int)time) / (3600 * 24 * 30);
        return [NSString stringWithFormat:@"%d个月前", months];
    } else {
        return @"一年前";
    }
}

@end
