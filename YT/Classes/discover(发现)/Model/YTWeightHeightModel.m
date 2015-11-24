//
//  YTWeightHeightModel.m
//  YT
//
//  Created by wangzhenhai on 15/10/18.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTWeightHeightModel.h"

@implementation YTWeightHeightModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSNumber *h = dict[@"h"];
        NSNumber *w = dict[@"w"];
        _h = [h floatValue];
        _w = [w floatValue];
    }
    
    return self;
}
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
