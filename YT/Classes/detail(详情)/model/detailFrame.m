//
//  detailFrame.m
//  YT
//
//  Created by wangzhenhai on 15/10/16.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "detailFrame.h"
#import "goodsModel.h"
@implementation detailFrame

- (void)setModel:(goodsModel *)model
{
    _model = model;
    
    CGFloat margin = 10;
    //1.goodsshow
    CGFloat goodViewx = 0;
    CGFloat goodViewy = 0;
    CGFloat goodVieww = kScreenW;
    CGFloat goodViewh = 350;
    _goodsShowFrame = CGRectMake(goodViewx, goodViewy, goodVieww, goodViewh);
    
    //2.pagecontrol
    CGFloat pagecontrolw = 100;
    CGFloat pagecontrolh = 35;
    CGFloat pagecontrolx = kScreenW / 2 - 50;
    CGFloat pagecontroly = CGRectGetMaxY(self.goodsShowFrame) * 0.85;
    _pagecontrolFrame = CGRectMake(pagecontrolx, pagecontroly, pagecontrolw, pagecontrolh);
    
    //3.productname
    CGFloat productnamex = margin;
    CGFloat productnamey = CGRectGetMaxY(self.goodsShowFrame) + margin;
    CGSize productsize = [model.productname sizeWithFont:homeproductNameFont maxSize:CGSizeMake(kScreenW - 2 * margin, MAXFLOAT)];
    _productNameFrame = (CGRect){{productnamex,productnamey},productsize};
    
    //price
    CGFloat pricex = margin;
    CGFloat pricey = CGRectGetMaxY(self.productNameFrame) + margin;
     NSString *priceStr = [NSString stringWithFormat:@"￥ %@(%@折)",self.model.price,self.model.discount];
    CGSize  pricesize = [priceStr sizeWithFont:priceFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _priceFrame = (CGRect){{pricex,pricey},pricesize};
    
    //realprice
    CGFloat realpricex = CGRectGetMaxX(self.priceFrame) + margin;
    CGFloat realpricey = pricey;
    CGFloat realpricew = 50;
    CGFloat realpriceh = priceFont.lineHeight;
    _reailPriceFrame = CGRectMake(realpricex, realpricey, realpricew, realpriceh);
    
    CGFloat linew = realpricew + margin;
    CGFloat lineh = 1;
    CGFloat linex = realpricex - 3;
    CGFloat liney = realpricey + realpriceh / 2;
    _line = CGRectMake(linex, liney, linew, lineh);
    
    CGFloat zszx = margin;
    CGFloat zsxy = CGRectGetMaxY(self.reailPriceFrame) + margin;
    CGFloat zszw = 50;
    CGFloat zszh = 25;
    _zszlabelFrame = CGRectMake(zszx, zsxy, zszw, zszh);
    
    CGFloat byx = margin;
    CGFloat byy = CGRectGetMaxY(self.zszlabelFrame) + margin;
    CGFloat byw = 50;
    CGFloat byh = 25;
    _bylabelFrame = CGRectMake(byx, byy, byw, byh);
    
    CGFloat text1x = margin;
    CGFloat text1y = CGRectGetMaxY(self.bylabelFrame) + margin;
    CGFloat text1w = 300;
    CGFloat text1h = 25;
    _text1labelFrame = CGRectMake(text1x, text1y, text1w, text1h);
    
    CGFloat text2x = margin;
    CGFloat text2y = CGRectGetMaxY(self.text1labelFrame);
    CGFloat text2w = 300;
    CGFloat text2h = 25;
    _text2labelFrame = CGRectMake(text2x, text2y, text2w, text2h);
    
    
    CGFloat cellHeight = CGRectGetMaxY(self.text2labelFrame) + margin;
    _cellHeight = cellHeight;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = kScreenW;
    CGFloat h = CGRectGetMaxY(self.text2labelFrame) + margin;
    _frame = CGRectMake(x, y, w, h);
    
}
@end
