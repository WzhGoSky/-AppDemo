//
//  DBManager.h
//  1512LimitFree
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class goodsModel;

@interface DBManager : NSObject

// 单例模式
+ (instancetype)shareManager;

// 删除数据
- (BOOL)deleteDataWithProductname:(NSString *)productname;

// 插入数据
- (BOOL)insertDataWithGoodModel:(goodsModel *)model;

// 根据appID查询单条数据
- (BOOL)selectOneDataWithAppID:(NSString *)appID;

// 查询所有数据
- (NSArray *)selectAllData;


@end
