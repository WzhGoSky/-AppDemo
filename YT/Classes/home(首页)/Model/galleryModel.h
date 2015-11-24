//
//  galleryModel.h
//  YT
//
//  Created by wangzhenhai on 15/10/14.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface galleryModel : NSObject

/** gallery的ID*/
@property (nonatomic, copy) NSString *ID;

/** gallery的商品id*/
@property (nonatomic, copy) NSString *productid;

/** 商品图*/
@property (nonatomic, copy) NSString *img;

/** 商品小图*/
@property (nonatomic, copy) NSString *imgthumb1;

/** 商品小图2*/
@property (nonatomic, copy) NSString *imgthumb2;


@end
