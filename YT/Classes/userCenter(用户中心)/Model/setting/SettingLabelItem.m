//
//  SettingLabelItem.m
//  Lottery
//
//  Created by 王振海 on 15/9/13.
//  Copyright (c) 2015年 王振海. All rights reserved.
//

#import "SettingLabelItem.h"

@implementation SettingLabelItem

+ (instancetype)settingItemWithTitle:(NSString *)title andWithLabelTitle:(NSString *)labelTitle andWithIcon:(NSString *)icon
{
    SettingLabelItem *item = [[SettingLabelItem alloc]init];
    
    item.iconimage = icon;
    item.title = title;
    item.labelTitle = labelTitle;
    
    return item;
}
@end
