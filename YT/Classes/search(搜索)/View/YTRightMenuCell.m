//
//  YTRightMenuCell.m
//  YT
//
//  Created by wangzhenhai on 15/10/19.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#define maxButtonCount 19

#import "YTRightMenuCell.h"
#import "YTChildModel.h"

@interface YTRightMenuCell()

@property (nonatomic, strong) YTChildModel *model;

@end
@implementation YTRightMenuCell

+ (instancetype)cellWithTableview:(UITableView *)tableview
{
    static NSString *ID = @"rightCell";
    YTRightMenuCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[YTRightMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kColor(208, 208, 208);
        for (int i=0; i<maxButtonCount; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.font = kFont(13);
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];            [button setBackgroundImage:[UIImage imageNamed:@"mesBgGray"] forState:UIControlStateNormal];
            [self.contentView addSubview:button];
        }
        
    }
    return self;
}

- (void)setChilds:(NSArray *)childs
{
    _childs = childs;
    for (int  i= 0; i < maxButtonCount; i++) {
         UIButton *button = self.contentView.subviews[i];
        if (i < childs.count) {
            button.hidden = NO;
            YTChildModel *model = self.childs[i];
            [button setTitle:model.cname forState:UIControlStateNormal];
        }else
        {
            button.hidden = YES;
        }
    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.childs.count;
    NSUInteger maxcols = 2;
    for (int i = 0; i < count; i++) {
        UIButton *button = self.contentView.subviews[i];
        [button addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat marginx = 15 * kScaleW;
        CGFloat marginy = 15 * kScaleW;
        CGFloat buttonw = (self.width - (maxcols +1) * marginx) / maxcols;
        CGFloat buttonh = 30 * kScaleH;
        CGFloat buttonx = marginx +(i % maxcols) * (buttonw + marginx);
        CGFloat buttony = marginy + (i / maxcols) * (buttonh + marginy);
        button.frame = CGRectMake(buttonx, buttony, buttonw, buttonh);
    }
}

- (void)btnDidClick:(UIButton *)button
{
    for (YTChildModel *model in self.childs) {
        if ([model.cname isEqualToString:button.currentTitle]) {
            self.model = model;
            break;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(rightMenuCell:DidClickedModel:)]) {
        [self.delegate rightMenuCell:self DidClickedModel:self.model];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
