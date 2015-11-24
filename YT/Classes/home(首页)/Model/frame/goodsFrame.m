//
//  goodsFrame.m
//  YT
//
//  Created by wangzhenhai on 15/10/15.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "goodsFrame.h"
#import "goodsModel.h"
#import "brandModel.h"
@implementation goodsFrame

- (void)setModel:(goodsModel *)model
{
    _model = model;
    
    CGFloat margin = 10;
    //1.iconFrame
    CGFloat iconx = margin;
    CGFloat icony = margin;
    CGFloat iconw = 50;
    CGFloat iconh = 50;
    self.iconFrame = CGRectMake(iconx, icony, iconw, iconh);
    
    //2.brandname
    CGFloat namex = CGRectGetMaxX(self.iconFrame) + margin;
    CGFloat namey = icony;
    CGSize maxsize = CGSizeMake(kScreenW - 60 - 2*margin, MAXFLOAT);
    CGSize namesize = [model.brand.brandname sizeWithFont:homebrandFont maxSize:maxsize];
    self.brandNameFrame = (CGRect){{namex,namey},namesize};
    
    //mask设计师
    CGFloat maskh = namesize.height;
    CGFloat maskw = 60;
    CGFloat maskx = CGRectGetMaxX(self.brandNameFrame) + margin;
    CGFloat masky = namey;
    self.maskFrame = CGRectMake(maskx, masky, maskw, maskh);
    
    //3.goodshowView
    CGFloat showx = 0;
    CGFloat showy = CGRectGetMaxY(self.iconFrame) + margin * 0.5;
    CGFloat showw = kScreenW;
    CGFloat showh = kScreenW * (float)(555/450.0);
    self.goodShowViewFrame = CGRectMake(showx, showy, showw, showh);
    
    //4.productname
    CGFloat pnamex = iconx;
    CGFloat pnamey = CGRectGetMaxY(self.goodShowViewFrame) + margin;
    CGSize pmaxsize = CGSizeMake(kScreenW - 2*margin, MAXFLOAT);
    CGSize pnamesize = [model.productname sizeWithFont:homeproductNameFont maxSize:pmaxsize];
    self.productnameFrame = (CGRect){{pnamex,pnamey},pnamesize};
    
    //5.desc
    CGFloat descx = pnamex;
    CGFloat descy = CGRectGetMaxY(self.productnameFrame) + margin;
    CGSize descmaxsize = CGSizeMake(kScreenW - 2*descx, MAXFLOAT);
    CGSize descsize = [model.desc sizeWithFont:homedescFont maxSize:descmaxsize];
    self.descFrame = (CGRect){{descx,descy},descsize};
    
    //6.detailbtn
    CGFloat detailBtnx = pnamex;
    CGFloat detailBtny = CGRectGetMaxY(self.descFrame) + margin;
    CGFloat detailBtnw = 0.25*kScreenW;
    CGFloat detailBtnh = 0.5 * detailBtnw;
    self.detailBtnFrame = CGRectMake(detailBtnx, detailBtny, detailBtnw, detailBtnh);
    
    //7.like
    CGFloat likeBtnx = CGRectGetMaxX(self.detailBtnFrame) + detailBtnh;
    CGFloat likeBtny = detailBtny;
    CGFloat likeBtnw = detailBtnw;
    CGFloat likeBtnh = detailBtnh;
    self.likeBtnFrame = CGRectMake(likeBtnx, likeBtny, likeBtnw, likeBtnh);
    
    //8.price
    CGFloat pricebtnx = CGRectGetMaxX(self.likeBtnFrame) + margin;
    CGFloat pricebtny = likeBtny;
    CGFloat pricebtnw = likeBtnw + margin;
    CGFloat pricebtnh = likeBtnh;
    self.priceBtnFrame = CGRectMake(pricebtnx, pricebtny, pricebtnw, pricebtnh);
    
    //10.frame
    CGFloat x = 0;
    CGFloat y = 15;
    CGFloat w = kScreenW;
    CGFloat h = CGRectGetMaxY(self.priceBtnFrame) + margin;
    self.frame = CGRectMake(x, y, w, h);
    
    //9.cell高度
    CGFloat cellHeight = CGRectGetMaxY(self.frame);
    self.cellHeight = cellHeight;
}
@end
