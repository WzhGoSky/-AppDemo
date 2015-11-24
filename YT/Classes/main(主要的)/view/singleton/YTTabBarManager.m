//
//  YTTabBarManager.m
//  YT
//
//  Created by wangzhenhai on 15/10/20.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTTabBarManager.h"

static YTTabBarManager *_shopcar;
@implementation YTTabBarManager

// 单例模式
+ (instancetype)shareManager {
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _shopcar = [[YTTabBarManager alloc] init];
    });
    
    return _shopcar;
}
@end
