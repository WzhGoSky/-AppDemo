//
//  YTFunModel.m
//  YT
//
//  Created by wangzhenhai on 15/10/19.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTFunModel.h"
#import "YTChildModel.h"
@implementation YTFunModel

+ (NSDictionary *)objectClassInArray
{
    return @{@"childs": [YTChildModel class]};
}

@end
