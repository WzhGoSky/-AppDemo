//
//  YTWeightHeightModel.h
//  YT
//
//  Created by wangzhenhai on 15/10/18.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTWeightHeightModel : NSObject

@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
