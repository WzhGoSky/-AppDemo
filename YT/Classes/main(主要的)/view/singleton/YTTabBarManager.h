//
//  YTTabBarManager.h
//  YT
//
//  Created by wangzhenhai on 15/10/20.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTTabBarManager : NSObject

@property (nonatomic, strong) UIImageView *detailTabbar;

@property (nonatomic, strong) UIImageView *shopCarTabbar;

@property (nonatomic, strong) UIImageView *mainTabbar;

+ (instancetype)shareManager;
@end
