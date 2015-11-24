//
//  goodsModel.h
//  YT
//
//  Created by wangzhenhai on 15/10/14.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class brandModel,userinfoModel,galleryModel,YTWeightHeightModel;
@interface goodsModel : NSObject

/** 牌子id*/
@property (nonatomic, copy) NSString *brandid;

/** 现价*/
@property (nonatomic, copy) NSString *oshopprice;

/** 重量*/
@property (nonatomic, copy) NSString *weight;

/** 省份*/
@property (nonatomic, copy) NSString *province;

/** 商品图片*/
@property (nonatomic, copy) NSString *img;

/** 描述*/
@property (nonatomic, copy) NSString *desc;

/** 牌子*/
@property (nonatomic, strong) brandModel *brand;

/** 价格*/
@property (nonatomic, copy) NSString *price;

/** 喜欢人数*/
@property (nonatomic, copy) NSString *likenum;

@property (nonatomic, strong) NSArray *gallery;

/** 降价价格*/
@property (nonatomic, copy) NSString *saleprice;

/** 材料*/
@property (nonatomic, copy) NSString *material;

/** */
@property (nonatomic, strong) userinfoModel *userinfo;

/** 图片*/
@property (nonatomic, strong) NSArray *story;

/** 尺寸*/
@property (nonatomic, copy) NSString *measure;

/** 原产地*/
@property (nonatomic, copy) NSString *origin;

/** 品牌名*/
@property (nonatomic, copy) NSString *productname;

/** 商品价格*/
@property (nonatomic, copy) NSString *shopprice;

/** 商品详情网页*/
@property (nonatomic, copy) NSString *htmlStory;

/** 原价*/
@property (nonatomic, copy) NSString *retailprice;

/** 品牌产地*/
@property (nonatomic, copy) NSString *brandorigin;

/** 性别*/
@property (nonatomic, copy) NSString *gender;

/** 打折*/
@property (nonatomic, copy) NSString *discount;

/** 长宽*/
@property (nonatomic, strong) YTWeightHeightModel *WHmodel;
@end
