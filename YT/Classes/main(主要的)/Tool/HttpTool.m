//
//  HttpTool.m
//  YT
//
//  Created by wangzhenhai on 15/10/14.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "HttpTool.h"

@implementation HttpTool

+ (void)GET:(NSString *)urlStr Parameters:(NSDictionary *)paramter success:(successBlock)success failure:(failureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStr parameters:paramter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)urlStr Parameters:(NSDictionary *)paramter success:(successBlock)success failure:(failureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:urlStr parameters:paramter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}
@end
