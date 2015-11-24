//
//  goodsModel.m
//  YT
//
//  Created by wangzhenhai on 15/10/14.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "goodsModel.h"
#import "galleryModel.h"
@implementation goodsModel

+ (NSDictionary *)objectClassInArray
{
    return @{@"gallery": [galleryModel class]};
}


@end
