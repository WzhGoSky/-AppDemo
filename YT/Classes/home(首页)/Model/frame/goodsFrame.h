//
//  goodsFrame.h
//  YT
//
//  Created by wangzhenhai on 15/10/15.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class goodsModel;
@interface goodsFrame : NSObject

@property (nonatomic, strong) goodsModel *model;

/** 头像*/
@property (nonatomic, assign) CGRect iconFrame;

/** 名字*/
@property (nonatomic, assign) CGRect brandNameFrame;

/** 设计师标签*/
@property (nonatomic, assign) CGRect maskFrame;

@property (nonatomic, assign) CGRect goodShowViewFrame;


@property (nonatomic, assign) CGRect productnameFrame;

@property (nonatomic, assign) CGRect descFrame;

@property (nonatomic, assign) CGRect detailBtnFrame;

@property (nonatomic, assign) CGRect likeBtnFrame;

@property (nonatomic, assign) CGRect priceBtnFrame;

@property (nonatomic, assign) CGRect frame;

@property (nonatomic, assign) CGFloat cellHeight;
@end
