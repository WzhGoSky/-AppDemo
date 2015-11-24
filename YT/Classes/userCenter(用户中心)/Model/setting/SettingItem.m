//
//  SettingItem.m
//  Lottery
//
//  Created by 王振海 on 15/9/11.
//  Copyright (c) 2015年 王振海. All rights reserved.
//

#import "SettingItem.h"

@implementation SettingItem

+ (instancetype)settingItemWithImage:(NSString *)iconImage andWithTitle:(NSString *)title
{
    SettingItem *item = [[self alloc]init];
    item.iconimage = iconImage;
    item.title = title;
    
    return item;
}

+ (instancetype)settingItemWithTitle:(NSString *)title
{
    return [self settingItemWithImage:nil andWithTitle:title];
}
@end
