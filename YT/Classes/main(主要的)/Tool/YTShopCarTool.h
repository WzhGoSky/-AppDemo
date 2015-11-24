//
//  YTShopCarTool.h
//  YT
//
//  Created by wangzhenhai on 15/10/20.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YTShopsModel;

@interface YTShopCarTool : NSObject

+ (void)addShopS:(YTShopsModel *)model;

/**
 *  购物车内商品种类
 */
+ (int)shopsCarGoodsKindNum;

+ (int)shopsCarCount;

+ (NSMutableArray *)allData;

@end
