//
//  YTTabBarTool.m
//  YT
//
//  Created by wangzhenhai on 15/10/20.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTTabBarTool.h"
#import "YTTabBarManager.h"
@implementation YTTabBarTool
+ (void)mainTabbarshow
{
    YTTabBarManager *manager = [YTTabBarManager shareManager];
    manager.mainTabbar.hidden = NO;
}

+ (void)mainTabbarhidden
{
    YTTabBarManager *manager = [YTTabBarManager shareManager];
    manager.mainTabbar.hidden = YES;
}
+ (void)detailTabbarshow
{
    YTTabBarManager *manager = [YTTabBarManager shareManager];
    manager.detailTabbar.hidden = NO;
}

+ (void)detailTabbarhidden
{
    YTTabBarManager *manager = [YTTabBarManager shareManager];
    manager.detailTabbar.hidden = YES;
}

+ (void)shopCarTabbarshow
{
    YTTabBarManager *manager = [YTTabBarManager shareManager];
    manager.shopCarTabbar.hidden = NO;
}

+ (void)shopCarTabbarhidden
{
    YTTabBarManager *manager = [YTTabBarManager shareManager];
    manager.shopCarTabbar.hidden = YES;
}
@end
