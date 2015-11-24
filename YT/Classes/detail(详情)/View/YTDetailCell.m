//
//  YTDetailCell.m
//  YT
//
//  Created by wangzhenhai on 15/10/16.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTDetailCell.h"
#import "detailFrame.h"
#import "galleryModel.h"
#import "goodsModel.h"
@interface YTDetailCell() <UIScrollViewDelegate>

@property (nonatomic, weak) UIView *containView;

@property (nonatomic, weak) UIScrollView *goodShowView;

@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic ,weak) UILabel *productlabel;

@property (nonatomic, weak) UILabel *pricelabel;

@property (nonatomic, weak) UILabel *realpriceLael;

@property (nonatomic, weak) UIView *line;

@property (nonatomic, weak) UILabel *zszLbael;

@property (nonatomic, weak) UILabel *bylabel;

@property (nonatomic, weak) UILabel *text1label;

@property (nonatomic, weak) UILabel *text2label;


@end
@implementation YTDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"DetailCell";
    YTDetailCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YTDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        //1.containView
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        self.containView = view;
        
        UIScrollView *goodShowView = [[UIScrollView alloc] init];
        [view addSubview:goodShowView];
        goodShowView.delegate = self;
        goodShowView.pagingEnabled = YES;
        goodShowView.bounces = NO;
        goodShowView.showsHorizontalScrollIndicator = NO;
        self.goodShowView = goodShowView;
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        [view addSubview:pageControl];
        self.pageControl = pageControl;
        self.pageControl.currentPage = 0;
        [self bringSubviewToFront:self.pageControl];
        
        //商品名
        UILabel *productnameLbael = [[UILabel alloc] init];
        productnameLbael.font = homeproductNameFont;
        [view addSubview:productnameLbael];
        productnameLbael.numberOfLines = 0;
        self.productlabel = productnameLbael;
        
        //price
        UILabel *pricelabel = [[UILabel alloc] init];
        pricelabel.font = priceFont;
        pricelabel.textColor = YTRed;
        [view addSubview:pricelabel];
        self.pricelabel = pricelabel;
        
        //realprice
        UILabel *realprice = [[UILabel alloc] init];
        realprice.font = priceFont;
        [view addSubview:realprice];
        self.realpriceLael = realprice;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:line];
        self.line = line;
        
        UILabel *zszlabel = [[UILabel alloc] init];
        zszlabel.font = kFont(12);
        zszlabel.text = @"折上折";
        zszlabel.backgroundColor = YTRed;
        zszlabel.textColor = [UIColor whiteColor];
        zszlabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:zszlabel];
        self.zszLbael = zszlabel;
        
        UILabel *bylabel = [[UILabel alloc] init];
        bylabel.font = kFont(12);
        bylabel.backgroundColor = YTRed;
        bylabel.text = @"包邮";
        bylabel.textColor = [UIColor whiteColor];
        bylabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:bylabel];
        self.bylabel = bylabel;
        
        UILabel *text1label = [[UILabel alloc] init];
        text1label.font = kFont(12);
        text1label.text = @"折上折后价格在购物车中可见";
        text1label.textColor = [UIColor lightGrayColor];
        [view addSubview:text1label];
        self.text1label = text1label;
        
        UILabel *text2label = [[UILabel alloc] init];
        text2label.font = kFont(12);
        text2label.text = @"享受满减或折上折的商品不能使用代金券";
        text2label.textColor = [UIColor lightGrayColor];
        [view addSubview:text2label];
        self.text2label = text2label;
        
        
    }
    return self;
}

- (void)setDetframe:(detailFrame *)detframe
{
    _detframe = detframe;
    
    self.containView.frame = detframe.frame;
    
    self.goodShowView.frame = detframe.goodsShowFrame;
    [self createShowGoodsImage:detframe.model.gallery];
    
    self.pageControl.frame = detframe.pagecontrolFrame;
    self.pageControl.currentPage = 0;
    
    
    self.productlabel.text = detframe.model.productname;
    self.productlabel.frame = detframe.productNameFrame;
    
    NSString *priceStr = [NSString stringWithFormat:@"￥ %@(%@折)",detframe.model.price,detframe.model.discount];
    self.pricelabel.text = priceStr;
    self.pricelabel.frame = detframe.priceFrame;
    
    NSString *realpriceStr = [NSString stringWithFormat:@"￥%@",detframe.model.retailprice];
    self.realpriceLael.text = realpriceStr;
    self.realpriceLael.frame = detframe.reailPriceFrame;
    
    self.line.frame = detframe.line;
    
    self.zszLbael.frame = detframe.zszlabelFrame;
    
    self.bylabel.frame = detframe.bylabelFrame;
    
    self.text1label.frame = detframe.text1labelFrame;
    
    self.text2label.frame = detframe.text2labelFrame;
}

- (void)createShowGoodsImage:(NSArray *)gallery
{
    NSUInteger count = gallery.count;
    self.pageControl.numberOfPages = count;
    self.goodShowView.contentSize = CGSizeMake(kScreenW * count, 0);
    for (int i = 0; i < count; i++) {
        galleryModel *model = gallery[i];
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.x = kScreenW * i ;
        imageview.y = 0;
        imageview.width = kScreenW;
        imageview.height = self.goodShowView.frame.size.height;
        [imageview setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"holder-item"]];
        [self.goodShowView addSubview:imageview];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

#pragma mark ----UIScrollView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.goodShowView) {
        int index = scrollView.contentOffset.x / kScreenW + 0.5;
        self.pageControl.currentPage = index;
    }
}

@end
