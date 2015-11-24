//
//  IntroductionFrame.h
//  YT
//
//  Created by wangzhenhai on 15/10/17.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class goodsModel;

@interface IntroductionFrame : NSObject

@property (nonatomic, strong) goodsModel *model;

@property (nonatomic, assign, readonly) CGRect descFrame;

@property (nonatomic, assign, readonly) CGRect prioductFrame;

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
