//
//  SettingArrowItem.m
//  Lottery
//
//  Created by 王振海 on 15/9/11.
//  Copyright (c) 2015年 王振海. All rights reserved.
//

#import "SettingArrowItem.h"

@implementation SettingArrowItem


+ (instancetype)settingItemWithImage:(NSString *)iconImage andWithTitle:(NSString *)title andWithClass:(Class)destVC
{
    SettingArrowItem *item = [[SettingArrowItem alloc]init];
    item.iconimage = iconImage;
    item.title = title;
    item.destVC = destVC;
    
    return item;
}

+ (instancetype)settingItemWithTitle:(NSString *)title andWithClass:(Class)destVC
{
   return  [self settingItemWithImage:nil andWithTitle:title andWithClass:destVC];
}
@end
