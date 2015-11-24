//
//  HttpTool.h
//  YT
//
//  Created by wangzhenhai on 15/10/14.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^successBlock)(id obj);
typedef void(^failureBlock)(NSError *error);
@interface HttpTool : NSObject

+ (void)GET:(NSString *)urlStr Parameters:(NSDictionary *)paramter success:(successBlock)success failure:(failureBlock)failure;

+ (void)POST:(NSString *)urlStr Parameters:(NSDictionary *)paramter success:(successBlock)success failure:(failureBlock)failure;
@end
