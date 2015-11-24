//
//  SettingArrowItem.h
//  Lottery
//
//  Created by 王振海 on 15/9/11.
//  Copyright (c) 2015年 王振海. All rights reserved.
//

#import "SettingItem.h"

@interface SettingArrowItem : SettingItem

@property (nonatomic, assign) Class destVC;

+ (instancetype)settingItemWithImage:(NSString *)iconImage andWithTitle:(NSString *)title andWithClass:(Class)destVC;

+ (instancetype)settingItemWithTitle:(NSString *)title andWithClass:(Class)destVC;
@end
