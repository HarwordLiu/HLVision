//
//  SDWebImageManager+RLCache.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/2.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "SDWebImageManager+RLCache.h"

@implementation SDWebImageManager (RLCache)

- (BOOL)memoryCachedImageExistsForURL:(NSURL *)url {
    NSString *key = [self cacheKeyForURL:url];
    return ([self.imageCache imageFromMemoryCacheForKey:key] != nil) ?  YES : NO;
}

@end
