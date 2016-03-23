//
//  ArticleModel.h
//  Vision
//
//  Created by Rilma.Liu on 16/3/8.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "RLBaseModel.h"
#import "TagModel.h"
#import "MediaModel.h"
#import "AdvertModel.h"

@interface ArticleModel : RLBaseModel

@property (nonatomic, copy) NSString *ArticleId;
@property (nonatomic, copy) NSString *Index;
@property (nonatomic, copy) NSString *Type;
@property (nonatomic, copy) NSString *ProviderId;
@property (nonatomic, copy) NSString *ProviderName;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *Link;
@property (nonatomic, copy) NSString *PubDate;
@property (nonatomic, copy) NSString *MoodType;
@property (nonatomic, copy) NSString *EditoType;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, copy) NSString *ShareLink;
@property (nonatomic, copy) NSString *Rating;
@property (nonatomic, copy) NSString *MoodTotal;
@property (nonatomic, copy) NSString *Moods;
@property (nonatomic, copy) NSString *Locale;

@property (nonatomic, strong) NSMutableArray<TagModel *> *tags;
@property (nonatomic, strong) NSMutableArray<MediaModel *> *medias;
@property (nonatomic, strong) NSMutableArray<AdvertModel *> *adverts;











@end
