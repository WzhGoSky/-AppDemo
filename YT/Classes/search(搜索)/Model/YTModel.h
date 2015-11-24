//
//  YTModel.h
//  YT
//
//  Created by wangzhenhai on 15/10/19.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTModel : NSObject

@property (nonatomic, copy) NSString *cname;

/**性别*/
@property (nonatomic, strong) NSNumber *gender;

@property (nonatomic, strong) NSArray *childs;

@end
