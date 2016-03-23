//
//  SDWebImageManager+RLCache.h
//  Vision
//
//  Created by Rilma.Liu on 16/3/2.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import <SDWebImageManager.h>

@interface SDWebImageManager (RLCache)

- (BOOL)memoryCachedImageExistsForURL:(NSURL *)url;

@end
