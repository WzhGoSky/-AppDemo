//
//  YTShopCarManager.m
//  YT
//
//  Created by wangzhenhai on 15/10/20.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTShopCarManager.h"

static YTShopCarManager *_shopcar;
@implementation YTShopCarManager


// 单例模式
+ (instancetype)shareManager {

    static dispatch_once_t predicate;

    dispatch_once(&predicate, ^{
        _shopcar = [[YTShopCarManager alloc] init];
        _shopcar.shopsArr = [NSMutableArray array];
    });

    return _shopcar;
}


@end
