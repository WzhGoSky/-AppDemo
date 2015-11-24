//
//  UIImage+Extension.h
//  01-QQ聊天布局
//
//  Created by apple on 14-4-2.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
    获得一张可拉伸的图片
 */
+ (UIImage *)resizableImage:(NSString *)name;

/**
 获得一张纯色的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
@end