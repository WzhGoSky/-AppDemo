//
//  YTMaleModel.m
//  YT
//
//  Created by wangzhenhai on 15/10/19.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTMaleModel.h"
#import "YTChildModel.h"
@implementation YTMaleModel

+ (NSDictionary *)objectClassInArray
{
    return @{@"childs": [YTChildModel class]};
}

@end
