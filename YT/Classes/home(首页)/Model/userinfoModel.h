//
//  userinfoModel.h
//  YT
//
//  Created by wangzhenhai on 15/10/14.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userinfoModel : NSObject

@property (nonatomic, copy) NSString *selfbackground;

/** 描述*/
@property (nonatomic, copy) NSString *selfdesc;

/** id*/
@property (nonatomic, copy) NSString *ID;

/** signature*/
@property (nonatomic, copy) NSString *signature;

/** 用户姓名*/
@property (nonatomic, copy) NSString *username;

/**头像*/
@property (nonatomic, copy) NSString *face;

/** 牌子id*/
@property (nonatomic, copy) NSString *brandid;

@end
