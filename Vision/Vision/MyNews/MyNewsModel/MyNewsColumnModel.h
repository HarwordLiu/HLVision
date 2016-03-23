//
//  MyNewsColumnModel.h
//  Vision
//
//  Created by Rilma.Liu on 16/2/26.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "RLBaseModel.h"

@interface MyNewsColumnModel : RLBaseModel

@property (nonatomic, copy) NSString *AffiliateLinkIds;
@property (nonatomic, copy) NSString *Nb;
@property (nonatomic, copy) NSString *Push;
@property (nonatomic, copy) NSString *RegionId;
@property (nonatomic, copy) NSString *TagId;
@property (nonatomic, copy) NSString *Text;
@property (nonatomic, copy) NSString *Url;
@property (nonatomic, copy) NSString *Weight;

@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic, assign) BOOL add;





/*
 {
    AffiliateLinkIds = "";
    Nb = 28;
    Push = 0;
    RegionId = 10;
    TagId = "-52";
    Text = "Most Mooded";
    Url = "http://newsrepmedia.blob.core.windows.net/image/2016-02/58752587_00_d-552x303_f-0_c-276x151.ani.gif";
    Weight = 0;
}
 */

@end
