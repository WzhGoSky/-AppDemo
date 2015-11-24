//
//  YTLeftMenuCell.m
//  YT
//
//  Created by wangzhenhai on 15/10/19.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTLeftMenuCell.h"

@interface YTLeftMenuCell()

@property (nonatomic, weak) UIButton *button;

@property (nonatomic, strong) UIButton *lastButton;
@end
@implementation YTLeftMenuCell

+ (instancetype)cellWithTableview:(UITableView *)tableview
{
    static NSString *ID = @"leftCell";
    YTLeftMenuCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[YTLeftMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"usercenter-blackback"] forState:UIControlStateSelected];
        [self.contentView addSubview:button];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.button = button;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    [self.button setTitle:title forState:UIControlStateNormal];
}
- (void)layoutSubviews
{
    [super layoutSubviews];

    self.button.frame = CGRectMake(20, 0, self.width, self.height);
}

- (void)btnClick:(UIButton *)button
{
    self.lastButton.selected = NO;
    button.selected = YES;
    self.lastButton = button;
    NSLog(@"----");
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
