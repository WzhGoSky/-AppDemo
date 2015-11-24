//
//  homeGoodCell.m
//  YT
//
//  Created by wangzhenhai on 15/10/14.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "homeGoodCell.h"
#import "goodsView.h"
#import "goodsFrame.h"
@interface homeGoodCell()

@property (nonatomic, weak) goodsView *goodView;

@end
@implementation homeGoodCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        goodsView *view = [[goodsView alloc]init];
        self.goodView = view;
        [self.contentView addSubview:view];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"homecell";
    homeGoodCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[homeGoodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}
- (void)setGoodFrame:(goodsFrame *)goodFrame
{
    _goodFrame = goodFrame;
    
    //设置frame
    self.goodView.frame = goodFrame.frame;
    
    //设置数据
    self.goodView.goodframe = goodFrame;
    
}
@end
