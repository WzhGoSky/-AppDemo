//
//  XJFrame.m
//  YT
//
//  Created by wangzhenhai on 15/10/17.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "XJFrame.h"

@implementation XJFrame

- (void)setModel:(goodsModel *)model
{
    _model = model;
    
    CGFloat margin = 10;
    
    CGFloat xjx = 0;
    CGFloat xjy = 0;
    CGFloat xjw = kScreenW;
    CGFloat xjh = kFont(12).lineHeight + 5;
    _xjframe = CGRectMake(xjx, xjy, xjw, xjh);
    
    CGFloat originx = margin;
    CGFloat originy = CGRectGetMaxY(self.xjframe) + margin;
    CGFloat originw = kScreenW;
    CGFloat originh = kFont(12).lineHeight;
    _originFrame = CGRectMake(originx, originy, originw, originh);
    
    CGFloat brandOriginx = margin;
    CGFloat brandOriginy = CGRectGetMaxY(self.originFrame) + margin;
    CGFloat brandOriginw = kScreenW;
    CGFloat brandOriginh = kFont(12).lineHeight;
    _brandOriginFrame = CGRectMake(brandOriginx, brandOriginy, brandOriginw, brandOriginh);
    
    CGFloat weightx = margin;
    CGFloat weighty = CGRectGetMaxY(self.brandOriginFrame) + margin;
    CGFloat weightw = kScreenW;
    CGFloat weighth = kFont(12).lineHeight;
    _weightFrame = CGRectMake(weightx, weighty, weightw, weighth);
    
    CGFloat materialx = margin;
    CGFloat materialy = CGRectGetMaxY(self.weightFrame) + margin;
    CGFloat materialw = kScreenW;
    CGFloat materialh = kFont(12).lineHeight;
    _materialFrame = CGRectMake(materialx, materialy, materialw, materialh);
    
    CGFloat measurex = margin;
    CGFloat measurey = CGRectGetMaxY(self.materialFrame) + margin;
    CGFloat measurew = kScreenW;
    CGFloat measureh = kFont(12).lineHeight;
    _measureFrame = CGRectMake(measurex, measurey, measurew, measureh);
    
    CGFloat viewx = 0;
    CGFloat viewy = CGRectGetMaxY(self.measureFrame) + margin;
    CGFloat vieww = kScreenW;
    CGFloat viewh = kFont(14).lineHeight + 8;
    _viewFrame = CGRectMake(viewx, viewy, vieww, viewh);
    
    CGFloat cellHeight = CGRectGetMaxY(self.viewFrame) + margin;
    _cellHeight = cellHeight;
}
@end
