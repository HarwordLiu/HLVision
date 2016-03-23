//
//  ArticleModel.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/8.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "ArticleModel.h"


@implementation ArticleModel

- (NSMutableArray<TagModel *> *)tags {
    if (!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}
- (NSMutableArray<MediaModel *> *)medias {
    if (!_medias) {
        _medias = [NSMutableArray array];
    }
    return _medias;
}

- (NSMutableArray<AdvertModel *> *)adverts {
    if (!_adverts) {
        _adverts = [NSMutableArray array];
    }
    return _adverts;
}




@end
