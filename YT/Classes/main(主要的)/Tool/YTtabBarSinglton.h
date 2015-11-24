//
//  YTtabBarSinglton.h
//  YT
//
//  Created by wangzhenhai on 15/10/16.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTtabBarSinglton : UIImageView

+ (instancetype)share;

@property (nonatomic, strong) UIImageView *tabbar;

@end
