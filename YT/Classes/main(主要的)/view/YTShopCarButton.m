//
//  YTShopCarButton.m
//  YT
//
//  Created by wangzhenhai on 15/10/20.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTShopCarButton.h"

@interface YTShopCarButton()

@property (nonatomic, weak) UILabel *badgelabel;

@end

@implementation YTShopCarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUp];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    
    return self;
}

- (void)setUp
{
    self.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = YTRed;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = kFont(12);
    label.adjustsFontSizeToFitWidth = YES;
    [self addSubview:label];
    self.badgelabel = label;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClick:)];
    [self addGestureRecognizer:tap];
}

- (void)layoutSubviews
{
    self.badgelabel.centerX = self.width/2 + 4;
    self.badgelabel.centerY = self.height/2 - 12;
    self.badgelabel.width = 12;
    self.badgelabel.height = 12;
    self.badgelabel.layer.cornerRadius = 6;
    self.badgelabel.clipsToBounds = YES;
}

- (void)setBadgeValue:(int)badgeValue
{
    _badgeValue = badgeValue;
    
    if (badgeValue == 0) {
        self.badgelabel.hidden = YES;
    }else
    {
        self.badgelabel.hidden = NO;
        self.badgelabel.text = [NSString stringWithFormat:@"%d",badgeValue];
    }
   
}

//实现点击代理方法
- (void)btnClick:(UIGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(shopCharDidClick:)]) {
        [self.delegate shopCharDidClick:self];
    }
}
@end
