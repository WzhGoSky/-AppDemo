//
//  YTShopCarTool.m
//  YT
//
//  Created by wangzhenhai on 15/10/20.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTShopCarTool.h"
#import "YTShopCarManager.h"
#import "YTShopsModel.h"
@implementation YTShopCarTool

+ (void)addShopS:(YTShopsModel*)model
{
    YTShopCarManager *manager = [YTShopCarManager shareManager];
    [manager.shopsArr addObject:model];
}

+ (int)shopsCarCount
{
    int count = 0;
    YTShopCarManager *manager = [YTShopCarManager shareManager];
    for (YTShopsModel *model in manager.shopsArr) {
        count = count + model.num;
    }
    return count;
}

+ (int)shopsCarGoodsKindNum
{
    YTShopCarManager *manager = [YTShopCarManager shareManager];
    return (int)manager.shopsArr.count;
}

+ (NSMutableArray *)allData
{
    YTShopCarManager *manager = [YTShopCarManager shareManager];
    return manager.shopsArr;
}
@end
