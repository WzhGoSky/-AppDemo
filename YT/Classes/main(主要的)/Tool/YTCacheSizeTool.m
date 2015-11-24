//
//  YTCacheSizeTool.m
//  YT
//
//  Created by wangzhenhai on 15/10/19.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTCacheSizeTool.h"

@implementation YTCacheSizeTool

+ (NSString *)getCacheSize
{
    // 获取图片缓存大小 单位:B
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    
    NSString *sizeStr;
    
    if (size < 1024) {
        sizeStr = [NSString stringWithFormat:@"%ld B", size];
    } else if (size >= 1024 && size < 1024 * 1024) {
        sizeStr = [NSString stringWithFormat:@"%.2f KB", size / 1024.0];
    } else if (size >= 1024 * 1024 && size < 1024 * 1024 * 1024) {
        sizeStr = [NSString stringWithFormat:@"%.2f MB", size / (1024 * 1024.0)];
    } else {
        sizeStr = [NSString stringWithFormat:@"%.2f GB", size / (1024 * 1024 * 1024.0)];
    }
    
    return sizeStr;
}
@end
