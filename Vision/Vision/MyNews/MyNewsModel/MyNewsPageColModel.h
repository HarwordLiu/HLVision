//
//  MyNewsPageColModel.h
//  Vision
//
//  Created by Rilma.Liu on 16/2/26.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyNewsColumnModel.h"

@interface MyNewsPageColModel : NSObject<NSXMLParserDelegate>

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSMutableArray<MyNewsColumnModel *> *columnModel;



@end
