//
//  YTShopCarButton.h
//  YT
//
//  Created by wangzhenhai on 15/10/20.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//  购物车图标

#import <UIKit/UIKit.h>
@class YTShopCarButton;
@protocol YTShopCarButtonDelegate <NSObject>

- (void)shopCharDidClick:(YTShopCarButton *) shopchar;

@end
@interface YTShopCarButton : UIImageView

@property (nonatomic, assign) id<YTShopCarButtonDelegate> delegate;
@property (nonatomic, assign) int badgeValue;

@end
