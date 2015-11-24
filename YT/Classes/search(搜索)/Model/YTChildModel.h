//
//  YTChildModel.h
//  YT
//
//  Created by wangzhenhai on 15/10/19.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTChildModel : NSObject

@property (nonatomic, copy) NSString *cid;

@property (nonatomic, copy) NSString *cname;

@property (nonatomic, copy) NSString *title;

/**性别*/
@property (nonatomic, strong) NSNumber *gender;

@end
