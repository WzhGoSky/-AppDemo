//
//  YTDeatilTableViewController.m
//  YT
//
//  Created by wangzhenhai on 15/10/16.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTDeatilTableViewController.h"
#import "YTDetailCell.h"
#import "YTIntroductuinCell.h"
#import "YTXJCell.h"
#import "YTIntroductuinCell.h"
#import "detailFrame.h"
#import "IntroductionFrame.h"
#import "XJFrame.h"
#import "HDTitleButton.h"
#import "YTWebViewController.h"
#import "goodsModel.h"
#import "YTWebViewController.h"
#import "YTShopCarButton.h"
#import "YTShopCarController.h"
#import "YTTabBarManager.h"
#import "YTShopsModel.h"
#import "DBManager.h"
#define NAVBAR_CHANGE_POINT 50
@interface YTDeatilTableViewController ()<UIScrollViewDelegate,YTXJCellDelegate,YTShopCarButtonDelegate>

@property (nonatomic, strong) detailFrame *detframe;
@property (nonatomic, strong) IntroductionFrame *introframe;
@property (nonatomic, strong) XJFrame *xjframe;

@property (nonatomic, strong) UIView *NavView;
@property (nonatomic, weak) UIImageView *shadowView;

@property (nonatomic, strong) YTShopCarButton *shopbtnred;
@property (nonatomic, strong) YTShopCarButton *shopbtnwhite;

@property (nonatomic, weak) UIButton *likeBtn;

@property (nonatomic, strong) UIImageView *animationView;
@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, assign,getter=islike) BOOL like;
@end

@implementation YTDeatilTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpData];
    
    [self setUpimageView];
    
    [self setWhiteItem];
}

- (void)setUpData
{
    //设置头部视图的阴影
    UIImageView *imageview = [[UIImageView alloc] init];
    [self.tableView addSubview:imageview];
    self.shadowView = imageview;
    self.shadowView.frame = CGRectMake(0, -100, kScreenW, 100+64);
    self.shadowView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shadow"]];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.tableView.bounces  = NO;
    
    self.detframe = [[detailFrame alloc] init];
    self.detframe.model = self.model;
    self.tableView.delegate = self;//监听滚动
  
    
    self.introframe = [[IntroductionFrame alloc] init];
    self.introframe.model = self.model;
    
    self.xjframe = [[XJFrame alloc] init];
    self.xjframe.model = self.model;
    
}
- (void)setWhiteItem{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"nav-back-white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem =backItem;
   
    YTShopCarButton *shopCarBtn = [[YTShopCarButton alloc] init];
    shopCarBtn.image = [UIImage imageNamed:@"nav-mycart-white"];
    shopCarBtn.width = 20;
    shopCarBtn.height = 18;
    shopCarBtn.delegate = self;
    self.shopbtnwhite = shopCarBtn;
    self.shopbtnwhite.badgeValue = [YTShopCarTool shopsCarCount];
    UIBarButtonItem *rightbutton = [[UIBarButtonItem alloc] initWithCustomView:shopCarBtn];
    self.navigationItem.rightBarButtonItem = rightbutton;
    self.title= @"";
}

- (void)setRedItem{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"cart_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem =backItem;
    
    YTShopCarButton *shopCarBtn = [[YTShopCarButton alloc] init];
    shopCarBtn.image = [UIImage imageNamed:@"btn-cart"];
    shopCarBtn.width = 20;
    shopCarBtn.height = 18;
    shopCarBtn.delegate = self;
    self.shopbtnred = shopCarBtn;
    self.shopbtnred.badgeValue = [YTShopCarTool shopsCarCount];
    UIBarButtonItem *rightbutton = [[UIBarButtonItem alloc] initWithCustomView:shopCarBtn];
    self.navigationItem.rightBarButtonItem = rightbutton;
    self.title = @"商品详情";
}
#pragma mark 实现ShopCarDelegate
- (void)shopCharDidClick:(YTShopCarButton *)shopchar
{
    YTShopCarController *shopcar = [[YTShopCarController alloc] init];
    [self.navigationController pushViewController:shopcar animated:YES];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark viewdidLoad
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.delegate = self;
    [YTTabBarTool detailTabbarshow];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    if ([self isExitInSqlite:self.model]) {
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
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}

- (void)setUpimageView
{
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.userInteractionEnabled = YES;
    imageview.backgroundColor = [UIColor whiteColor];
    imageview.frame = CGRectMake(0, kScreenH - 49, kScreenW, 49);
    [self.navigationController.view addSubview:imageview];
    YTTabBarManager *manager = [YTTabBarManager shareManager];
     manager.detailTabbar = imageview;
    [self addbuttonInView:imageview];
}

- (void)addbuttonInView:(UIView *)view
{
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(kScreenW * 0.3, 5, kScreenW * 0.2, 35);
    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:self.model.likenum forState:UIControlStateNormal];
    button.titleLabel.font = kFont(12);
    [button setImage:[UIImage imageNamed:@"btn-fav-off"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"mesBgGray"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"btn-fav-on"] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:@"mesBgRed"] forState:UIControlStateSelected];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
    [button setBackgroundImage:[UIImage imageNamed:@"usercenter-blackback"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(leftBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    self.likeBtn = button;
    
    UIButton *button1 = [[UIButton alloc] init];
    NSString *str = [self.model.price stringByReplacingOccurrencesOfString:@".00" withString:@""];
    [button1 setTitle:str forState:UIControlStateNormal];
    button1.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    button1.layer.cornerRadius = 5;
    button1.clipsToBounds = YES;
    button1.titleLabel.font = kFont(12);
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.frame = CGRectMake(kScreenW * 0.52, 5, kScreenW * 0.25, 35);
    [button1 setImage:[UIImage imageNamed:@"btn-cart"] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@"mesBgRed"] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@"usercenter-blackback"] forState:UIControlStateHighlighted];
     [button1 addTarget:self action:@selector(rightBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button1];
    
}
#pragma mark ------------------------收藏与添加购物车按钮点击处理--------------------------
- (void)leftBtnDidClick:(UIButton *)button
{
    if (!self.islike) {
        self.like = YES;
        [self.likeBtn setTitleColor:YTRed forState:UIControlStateNormal];
        [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"mesBgRed"] forState:UIControlStateNormal];
        [self.likeBtn setImage:[UIImage imageNamed:@"btn-fav-on"] forState:UIControlStateNormal];
        [MBProgressHUD showSuccess:@"收藏成功"];
        
        goodsModel *model = self.model;
        DBManager *manager = [DBManager shareManager];
        [manager insertDataWithGoodModel:model];
        
    }else
    {
        [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"mesBgGray"] forState:UIControlStateNormal];
        [self.likeBtn setImage:[UIImage imageNamed:@"btn-fav-off"] forState:UIControlStateNormal];
        [self.likeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.like = NO;
        [MBProgressHUD showSuccess:@"取消收藏成功"];
        
        goodsModel *model = self.model;
        DBManager *manager = [DBManager shareManager];
        [manager deleteDataWithProductname:model.productname];
    }
}

- (void)rightBtnDidClick:(UIButton *)button
{
    BOOL isrepeat = NO;
    //当前点击的
    goodsModel *model = self.model;
    YTShopsModel *shopmodel = [[YTShopsModel alloc]init];
    shopmodel.model = model;
    
    NSMutableArray *array  = [YTShopCarTool allData];
    
    if (array.count == 0) {
        [YTShopCarTool addShopS:shopmodel];
    }else
    {
        for (YTShopsModel *model in array) {
            if ([shopmodel.model.productname isEqualToString:model.model.productname]) {
                model.num++;
                isrepeat = YES;
                break;
            }
        }
        
        if (isrepeat == NO) {
            [array addObject:shopmodel];
        }
        
    }
    
    self.path = [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(50, kScreenH * 0.8)];
    [_path addQuadCurveToPoint:CGPointMake(300 * kScaleW, 20) controlPoint:CGPointMake(300 * kScaleW, 300 *kScaleW)];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.frame = CGRectMake(50, 400, 100, 100);
    [imageview setImageWithURL:[NSURL URLWithString:model.img]];
    [window addSubview:imageview];
    self.animationView = imageview;
    
    [self groupAnimation];
}

-(void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = 0.5f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
    expandAnimation.toValue = [NSNumber numberWithFloat:2.0f];
    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = 0.5;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:2.0f];
    narrowAnimation.duration = 0.5f;
    narrowAnimation.toValue = [NSNumber numberWithFloat:0];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = 1.0f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [self.animationView.layer addAnimation:groups forKey:@"group"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [MBProgressHUD showSuccess:@"添加购物车成功"];
    self.shopbtnred.badgeValue = [YTShopCarTool shopsCarCount];
    self.shopbtnwhite.badgeValue = [YTShopCarTool shopsCarCount];
}

- (void)setUpNavView
{
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        YTDetailCell *cell = [YTDetailCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detframe = self.detframe;
        return cell;
    }else if (indexPath.row == 1)
    {
        YTIntroductuinCell *cell = [YTIntroductuinCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.intrframe = self.introframe;
        return cell;
    }else if(indexPath.row == 2)
    {
        YTXJCell *cell = [YTXJCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.xjframe;
        cell.delegate = self;
        return cell;
    }else
    {
        static NSString *ID = @"cell";
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return self.detframe.cellHeight;
    }else if (indexPath.row == 1)
    {
        return self.introframe.cellHeight;
    }else if (indexPath.row == 2)
    {
        return self.xjframe.cellHeight;
    }else
    {
        return 49;
    }
}

#pragma mark UIScrollerView的代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
        UIColor * color = [UIColor whiteColor];
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY > NAVBAR_CHANGE_POINT) {
            CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
            [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
            [self setRedItem];
        } else {
            [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
            [self setWhiteItem];
        }

    }
}

- (void)XJCelldidClickButton:(UIButton *)button
{
    YTWebViewController *webVc = [[YTWebViewController alloc] init];
    NSString *productid = [self.model.gallery[0] valueForKey:@"productid"];
    webVc.url = productid;
    [self.navigationController pushViewController:webVc animated:YES];
}

@end
