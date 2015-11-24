//
//  YTUserCenterHeaderView.h
//  YT
//
//  Created by wangzhenhai on 15/10/19.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTUserCenterHeaderView;

@protocol userCenterHeaderViewDelegate <NSObject>

@optional

- (void)userCenterHeaderView:(YTUserCenterHeaderView *)userView didClickGoodsButton:(UIButton *)goodsButton;

- (void)userCenterHeaderView:(YTUserCenterHeaderView *)userView didClickFocusButton:(UIButton *)focusButton;

@end
@interface YTUserCenterHeaderView : UIImageView

@property (nonatomic, assign) NSUInteger collectionCount;

@property (nonatomic, assign) int goodsNum;

@property (nonatomic, assign) id<userCenterHeaderViewDelegate> delegate;
@end
