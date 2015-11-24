//
//  HDTitleButton.m
//  9.20Status
//
//  Created by 王振海 on 15/9/22.
//  Copyright (c) 2015年 王振海. All rights reserved.
//

#import "HDTitleButton.h"

@interface HDTitleButton()

@property (nonatomic,strong) UIFont *MyFont;


@end
@implementation HDTitleButton


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置内部imageview居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        //设置内部label文字大小
        self.MyFont = [UIFont systemFontOfSize:14];
        self.titleLabel.font = self.MyFont;
        //普通模式为黑色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置图片在按钮高亮状态时的不变灰
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = self.height;
    CGFloat imageH = imageW;
    CGFloat imageX = self.width - imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

/**
 *  设置内部文字的frame
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 0;
    CGFloat titleX = 0;
    CGFloat titleH = self.height;
    CGFloat titleW = self.width - self.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

/**
 button的宽度设置应该在settitle时执行
 */
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    CGFloat titleWith = [title sizeWithFont:self.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    self.width = titleWith + self.height + 10;
}


@end
