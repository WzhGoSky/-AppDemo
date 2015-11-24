//
//  brandModel.h
//  YT
//
//  Created by wangzhenhai on 15/10/14.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface brandModel : NSObject

/** 牌子id*/
@property (nonatomic, copy) NSString *ID;

/** 是否显示*/
@property (nonatomic, copy) NSString *isshow;

/** 牌子名字*/
@property (nonatomic, copy) NSString *brandname;

@end
