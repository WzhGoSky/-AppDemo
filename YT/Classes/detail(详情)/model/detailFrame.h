//
//  detailFrame.h
//  YT
//
//  Created by wangzhenhai on 15/10/16.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class goodsModel;
@interface detailFrame : NSObject

@property (nonatomic, strong) goodsModel *model;

@property (nonatomic, assign ,readonly) CGRect goodsShowFrame;

@property (nonatomic, assign ,readonly) CGRect pagecontrolFrame;

@property (nonatomic, assign ,readonly) CGRect productNameFrame;

@property (nonatomic, assign ,readonly) CGRect priceFrame;

@property (nonatomic, assign ,readonly) CGRect reailPriceFrame;

@property (nonatomic, assign ,readonly) CGRect line;

#warning 折上折 包邮界面 添加CGRect
@property (nonatomic, assign, readonly) CGRect zszlabelFrame;

@property (nonatomic, assign, readonly) CGRect bylabelFrame;

@property (nonatomic, assign, readonly) CGRect text1labelFrame;

@property (nonatomic, assign, readonly) CGRect text2labelFrame;

@property (nonatomic, assign ,readonly) CGRect frame;

@property (nonatomic, assign,readonly) CGFloat cellHeight;

@end
