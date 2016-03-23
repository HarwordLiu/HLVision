//
//  NetHeader.h
//  Vision
//
//  Created by Rilma.Liu on 16/3/1.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#ifndef NetHeader_h
#define NetHeader_h

#define NETEYES @"http://baobab.wandoujia.com/api/v1/feed?date=%@&num=10"
#define NETCOLU @"http://baobab.wandoujia.com/api/v1/videos?num=10&categoryName=%@&strategy=date&vc=181"
#define NETMYNEWS @"http://apinews6-front.newsrep.cn/search/gettoptags?filter=0&premium=0&regionId=10&handsetName=iPhone8%2C1&source=visualSearch&packageId=19&topType=5&version=116"
#define NETSINGENEW @"http://apinews6-front.newsrep.cn/flow/GetArticles?packageId=19&articleId=0&version=116&bottomArticleId=0&premium=0&mood=-1&tags=%@&regionId=10&videoOnly=0&topArticleId=0&edito=1&filter=0&sortBy=1&onefeed=0&pageSize=50"
#define NETSEARCH @"http://apinews6-front.newsrep.cn/search/gettags?pageSize=100&premium=0&regionId=10&source=visualSearch&packageId=19&version=116&typeSearch=normal&textSearch=%@"
#define NETREPLY @"http://baobab.wandoujia.com/api/v1/replies/video?id=%ld&num=200&latestId=0&vc=209"

#endif /* NetHeader_h */