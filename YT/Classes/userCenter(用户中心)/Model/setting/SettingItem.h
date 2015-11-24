//
//  SettingItem.h
//  Lottery
//
//  Created by 王振海 on 15/9/11.
//  Copyright (c) 2015年 王振海. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SettingItemOption)();
@interface SettingItem : NSObject

@property (nonatomic, copy) NSString *iconimage;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) SettingItemOption option;

@property (nonatomic, copy) NSString *labelTitle;
+ (instancetype)settingItemWithImage:(NSString *)iconImage andWithTitle:(NSString *)title;

+ (instancetype)settingItemWithTitle:(NSString *)title;
@end
