//
//  XJFrame.h
//  YT
//
//  Created by wangzhenhai on 15/10/17.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//  细节frame

#import <UIKit/UIKit.h>

@class goodsModel;

@interface XJFrame : NSObject

@property (nonatomic, strong) goodsModel *model;

@property (nonatomic, assign) CGRect xjframe;

@property (nonatomic, assign) CGRect originFrame;

@property (nonatomic, assign) CGRect brandOriginFrame;

@property (nonatomic, assign) CGRect weightFrame;

@property (nonatomic, assign) CGRect materialFrame;

@property (nonatomic, assign) CGRect measureFrame;

@property (nonatomic, assign) CGRect viewFrame;

@property (nonatomic, assign) CGFloat cellHeight;


@end
