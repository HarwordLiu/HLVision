//
//  TagModel.h
//  Vision
//
//  Created by Rilma.Liu on 16/3/8.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "RLBaseModel.h"

@interface TagModel : RLBaseModel

@property (nonatomic, copy) NSString *TagId;
@property (nonatomic, copy) NSString *Text;
@property (nonatomic, copy) NSString *Nb;
@property (nonatomic, copy) NSString *Weight;
@property (nonatomic, copy) NSString *AffiliateLinkIds;
@property (nonatomic, copy) NSString *Push;
@property (nonatomic, copy) NSString *RegionId;

@end
