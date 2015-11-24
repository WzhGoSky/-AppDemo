//
//  goodsView.m
//  YT
//
//  Created by wangzhenhai on 15/10/15.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "goodsView.h"
#import "goodsFrame.h"
#import "goodsModel.h"
#import "brandModel.h"
#import "userinfoModel.h"
#import "galleryModel.h"
#import "DBManager.h"
@interface goodsView() <UIScrollViewDelegate>

@property (nonatomic, getter=isLike) BOOL like;

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *brandNameLabel;

@property (nonatomic, weak) UILabel *maskLabel;

@property (nonatomic, weak) UIButton *textBtn;

//@property (nonatomic, strong) UIScrollView *goodShowView;
@property (nonatomic, weak) UIImageView *goodview;

@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, weak) UILabel *productNameLabel;

@property (nonatomic, weak) UILabel *descLabel;

@property (nonatomic, weak) UIButton *detailBtn;

@property (nonatomic, weak) UIButton *likeBtn;

@property (nonatomic, weak) UIButton *priceBtn;


@end

@implementation goodsView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        //icon
        UIImageView *iconview = [[UIImageView alloc]init];
        [self addSubview:iconview];
        iconview.layer.borderWidth = 1.0f;
        iconview.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.iconView = iconview;
        
        //brandname
        UILabel *brandLabel = [[UILabel alloc]init];
        brandLabel.font = homebrandFont;
        [self addSubview:brandLabel];
        self.brandNameLabel = brandLabel;
        
        UILabel *maskLabel = [[UILabel alloc] init];
        maskLabel.font = [UIFont systemFontOfSize:13];
        maskLabel.layer.cornerRadius = 8.f;
        maskLabel.clipsToBounds = YES;
        maskLabel.text = @"设计师";
        maskLabel.textAlignment = NSTextAlignmentCenter;
        maskLabel.textColor = [UIColor whiteColor];
        maskLabel.backgroundColor = [UIColor blackColor];
        [self addSubview:maskLabel];
        self.maskLabel = maskLabel;
        
        //goodshow
//        UIScrollView *goodShowView = [[UIScrollView alloc] init];
//        [self addSubview:goodShowView];
//        goodShowView.delegate = self;
//        goodShowView.pagingEnabled = YES;
//        goodShowView.bounces = NO;
//        goodShowView.showsHorizontalScrollIndicator = NO;
//        goodShowView.backgroundColor = [UIColor lightGrayColor];
//        self.goodShowView = goodShowView;
        //goodshow
        UIImageView *goodview = [[UIImageView alloc] init];
        [self addSubview:goodview];
        self.goodview = goodview;
        
//        UIPageControl *pageControl = [[UIPageControl alloc] init];
//        pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
//        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
//        [self addSubview:pageControl];
//        self.pageControl = pageControl;
//        self.pageControl.currentPage = 0;
//        [self bringSubviewToFront:self.pageControl];
        
        //商品名
        UILabel *productnameLbael = [[UILabel alloc] init];
        productnameLbael.font = homeproductNameFont;
        [self addSubview:productnameLbael];
        productnameLbael.numberOfLines = 0;
        self.productNameLabel = productnameLbael;
        
        //描述
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.font = homedescFont;
        descLabel.numberOfLines = 0;
        [self addSubview:descLabel];
        self.descLabel = descLabel;
        
        //详情按钮
        UIButton *detailBtn = [[UIButton alloc]init];
        [detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        [detailBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        detailBtn.enabled = NO;
        [detailBtn setBackgroundImage:[UIImage imageNamed:@"mesBgGray"] forState:UIControlStateNormal];
        detailBtn.layer.cornerRadius = 5.0f;
        detailBtn.clipsToBounds = YES;
        detailBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:detailBtn];
        self.detailBtn = detailBtn;
        //喜欢
        UIButton *likeBtn = [[UIButton alloc] init];
        likeBtn.layer.cornerRadius = 5.0f;
        likeBtn.clipsToBounds = YES;
        likeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [likeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:likeBtn];
        self.likeBtn = likeBtn;
        
        //价格
        UIButton *priceBtn = [[UIButton alloc] init];
        priceBtn.layer.cornerRadius = 5.0f;
        priceBtn.clipsToBounds = YES;
        priceBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [priceBtn setImage:[UIImage imageNamed:@"btn-cart"] forState:UIControlStateNormal];
        priceBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [priceBtn setBackgroundImage:[UIImage imageNamed:@"mesBgRed"] forState:UIControlStateNormal];
        [priceBtn setTitleColor:YTRed forState:UIControlStateNormal];
        [priceBtn addTarget:self action:@selector(priceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:priceBtn];
        self.priceBtn = priceBtn;
        
    }
    return self;
}

- (void)setGoodframe:(goodsFrame *)goodframe
{
    _goodframe = goodframe;
    
    goodsModel *goodmodel = goodframe.model;
    brandModel *brandmodel = goodmodel.brand;
    userinfoModel *userinfo = goodmodel.userinfo;
    
    //头像
    [self.iconView setImageWithURL:[NSURL URLWithString:userinfo.face] placeholderImage:[UIImage imageNamed:@"holder-item"]];
    self.iconView.frame = goodframe.iconFrame;
    //品牌名
    self.brandNameLabel.text = brandmodel.brandname;
    self.brandNameLabel.frame = goodframe.brandNameFrame;
    
    //设计师标签
    self.maskLabel.frame = goodframe.maskFrame;
    
    //showview
    self.goodview.frame = goodframe.goodShowViewFrame;
//    [self createShowGoodsImage:goodframe.model.gallery];
    [self.goodview setImageWithURL:[NSURL URLWithString:goodframe.model.img]];
    
//    self.pageControl.width = 100;
//    self.pageControl.height = 35;
//    self.pageControl.x = kScreenW / 2 - 50;
//    self.pageControl.y = CGRectGetMaxY(self.goodShowView.frame) * 0.85;
//    self.pageControl.currentPage = 0;
    
    //productlabel
    self.productNameLabel.text = goodmodel.productname;
    self.productNameLabel.frame = goodframe.productnameFrame;
    
    //desc
    self.descLabel.text = goodmodel.desc;
    self.descLabel.frame = goodframe.descFrame;
    
    self.detailBtn.frame = goodframe.detailBtnFrame;
    
    
    [self.likeBtn setTitle:goodmodel.likenum forState:UIControlStateNormal];
    self.likeBtn.frame = goodframe.likeBtnFrame;
    
    NSString *priceStr = [goodmodel.price stringByReplacingOccurrencesOfString:@".00" withString:@""];
    [self.priceBtn setTitle:priceStr forState:UIControlStateNormal];
    self.priceBtn.frame = goodframe.priceBtnFrame;
    
    if ([self isExitInSqlite:self.goodframe.model]) {
        self.like = YES;
        [self.likeBtn setTitleColor:YTRed forState:UIControlStateNormal];
        [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"mesBgRed"] forState:UIControlStateNormal];
        [self.likeBtn setImage:[UIImage imageNamed:@"btn-fav-on"] forState:UIControlStateNormal];
    }else
    {
        self.like = NO;
        [self.likeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"mesBgGray"] forState:UIControlStateNormal];
        [self.likeBtn setImage:[UIImage imageNamed:@"btn-fav-off"] forState:UIControlStateNormal];
    }
}

//- (void)createShowGoodsImage:(NSArray *)gallery
//{
//    NSUInteger count = gallery.count;
//    self.pageControl.numberOfPages = count;
//    self.goodShowView.contentSize = CGSizeMake(kScreenW * count, 0);
//    for (int i = 0; i < count; i++) {
//        galleryModel *model = gallery[i];
//        UIImageView *imageview = [[UIImageView alloc] init];
//        imageview.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageview:)];
//        [imageview addGestureRecognizer:tap];
//        imageview.x = kScreenW * i ;
//        imageview.y = 0;
//        imageview.width = kScreenW;
//        imageview.height = self.goodShowView.frame.size.height;
//        [imageview setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"holder-item"]];
//        [self.goodShowView addSubview:imageview];
//    }
//}
#pragma mark ------ 喜欢按钮点击（收藏）
- (void)likeBtnClick:(UIButton *)button
{
   
    if (!self.isLike) {
        self.like = YES;
        [self.likeBtn setTitleColor:YTRed forState:UIControlStateNormal];
        [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"mesBgRed"] forState:UIControlStateNormal];
        [self.likeBtn setImage:[UIImage imageNamed:@"btn-fav-on"] forState:UIControlStateNormal];
        [MBProgressHUD showSuccess:@"收藏成功"];
        
        goodsModel *model = self.goodframe.model;
        DBManager *manager = [DBManager shareManager];
        [manager insertDataWithGoodModel:model];
        
    }else
    {
        [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"mesBgGray"] forState:UIControlStateNormal];
        [self.likeBtn setImage:[UIImage imageNamed:@"btn-fav-off"] forState:UIControlStateNormal];
        [self.likeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.like = NO;
         [MBProgressHUD showSuccess:@"取消收藏成功"];
        
        goodsModel *model = self.goodframe.model;
        DBManager *manager = [DBManager shareManager];
        [manager deleteDataWithProductname:model.productname];
    }
}
- (BOOL)isExitInSqlite:(goodsModel *)model
{
    DBManager *manager = [DBManager shareManager];
    NSArray *array = [manager selectAllData];
    for (goodsModel *goods in array) {
        if ([goods.productname isEqualToString:model.productname]) {
            return YES;
        }
    }
    
    return NO;
}
#pragma mark ------- 价格按钮点击
- (void)priceBtnClick:(UIButton *)button
{
    goodsModel *model = self.goodframe.model;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kPriceBtn object:model];
}

#pragma mark ----UIScrollView
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if (scrollView == self.goodShowView) {
//        
//        int index = scrollView.contentOffset.x / kScreenW + 0.5;
//        self.pageControl.currentPage = index;
//
//    }
//}

#pragma mark ------------------------点击了图片------------------------
- (void)tapImageview:(UIGestureRecognizer *)tap
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KtapKey object:self.goodframe.model];
}
@end
