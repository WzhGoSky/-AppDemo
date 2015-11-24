//
//  YTShopCarManager.h
//  YT
//
//  Created by wangzhenhai on 15/10/20.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTShopCarManager : NSObject

+ (instancetype)shareManager;

@property (nonatomic, strong) NSMutableArray *shopsArr;

@end
