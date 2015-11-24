//
//  IntroductionFrame.m
//  YT
//
//  Created by wangzhenhai on 15/10/17.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "IntroductionFrame.h"
#import "goodsModel.h"
@implementation IntroductionFrame

- (void)setModel:(goodsModel *)model
{
    _model = model;
    
    CGFloat margin = 10;
    
    CGFloat plabelx = 0;
    CGFloat plabely = 0;
    CGFloat plabelw = kScreenW;
    CGFloat plabelh = kFont(12).lineHeight + 5;
    _prioductFrame = CGRectMake(plabelx, plabely, plabelw, plabelh);
    
    CGFloat descx = margin;
    CGFloat descy = CGRectGetMaxY(self.prioductFrame) + margin;
    CGSize descsize = [model.desc sizeWithFont:homedescFont maxSize:CGSizeMake(kScreenW - 2*margin, kScreenH)];
    _descFrame = (CGRect){{descx,descy},descsize};
    
    CGFloat cellHeight = CGRectGetMaxY(self.descFrame) + margin;
    _cellHeight = cellHeight;
}

@end
