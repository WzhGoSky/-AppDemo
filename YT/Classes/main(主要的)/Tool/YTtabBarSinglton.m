//
//  YTtabBarSinglton.m
//  YT
//
//  Created by wangzhenhai on 15/10/16.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTtabBarSinglton.h"

static YTtabBarSinglton *_tabbar;
@implementation YTtabBarSinglton

+ (instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tabbar = [[YTtabBarSinglton alloc]init];
    });
    
    return _tabbar;
}

- (void)setTabbar:(UIImageView *)tabbar
{
    _tabbar = tabbar;
}
@end
