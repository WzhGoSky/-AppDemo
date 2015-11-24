//
//  YTUserCenterViewController.m
//  YT
//
//  Created by wangzhenhai on 15/10/19.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#define NAVBAR_CHANGE_POINT 45

#import "YTUserCenterViewController.h"
#import "YTUserCenterHeaderView.h"
#import "SettingArrowItem.h"
#import "settingGroup.h"
#import "SettingLabelItem.h"
#import "YTCacheSizeTool.h"
#import "YTShopCarController.h"
#import "YTShopCarButton.h"
#import "DBManager.h"
#import "YTShopCarTool.h"
@interface YTUserCenterViewController () <UIScrollViewDelegate,UIAlertViewDelegate,YTShopCarButtonDelegate,userCenterHeaderViewDelegate>

@property (nonatomic, strong) YTUserCenterHeaderView *headerview;
@property (nonatomic, strong) YTShopCarButton *shopbtnred;
@property (nonatomic, strong) YTShopCarButton *shopbtnwhite;

@end

@implementation YTUserCenterViewController
#pragma mark ------------------------view方法--------------------------
- (void)loadView
{
    [super loadView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64 ) style:UITableViewStyleGrouped];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.delegate = self;
    [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0]];
    self.navigationItem.title = nil;
    self.shopbtnwhite.badgeValue = [YTShopCarTool shopsCarCount];;
    self.shopbtnred.badgeValue = [YTShopCarTool shopsCarCount];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    [YTTabBarTool mainTabbarshow];
    
    //获取收藏的个数
    DBManager *manager = [DBManager shareManager];
    NSArray *array = [manager selectAllData];
    self.headerview.collectionCount = array.count;
    
    //获取购物车个数
    self.headerview.goodsNum = [YTShopCarTool shopsCarGoodsKindNum];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}

#pragma mark ------------------------viewDidLoad--------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.tableView.delegate = self;
    [self setWhiteItem];
    [self setUpHeaderView];
    
    [self group0];
    [self group1];
    [self group2];
    [self group3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setUpHeaderView
{
    YTUserCenterHeaderView *backImageView = [[YTUserCenterHeaderView alloc] init];
    backImageView.frame = CGRectMake(0, 0, kScreenW, 0.8 * kScreenW);
    backImageView.image = [UIImage imageNamed:@"usercenter-blackback"];
    self.headerview = backImageView;
    self.headerview.delegate = self;
    self.tableView.tableHeaderView = self.headerview;
}

#pragma mark 添加导航栏的左右按钮
- (void)setWhiteItem{
    
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
    
    YTShopCarButton *shopCarBtn = [[YTShopCarButton alloc] init];
    shopCarBtn.image = [UIImage imageNamed:@"btn-cart"];
    shopCarBtn.width = 20;
    shopCarBtn.height = 18;
    shopCarBtn.delegate = self;
    self.shopbtnred = shopCarBtn;
    self.shopbtnred.badgeValue = [YTShopCarTool shopsCarCount];;
    UIBarButtonItem *rightbutton = [[UIBarButtonItem alloc] initWithCustomView:shopCarBtn];
    self.navigationItem.rightBarButtonItem = rightbutton;
    self.title = @"用户中心";
}

#pragma mark 实现购物车的代理方法
- (void)shopCharDidClick:(YTShopCarButton *)shopchar
{
    YTShopCarController *shopCar = [[YTShopCarController alloc] init];
    [self.navigationController pushViewController:shopCar animated:YES];
}

#pragma mark UITableView delegate && datasource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 65;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
#pragma mark UIScrollerView的代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
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

#pragma mark ------------------------商品按钮和关注按钮------------------------
- (void)userCenterHeaderView:(YTUserCenterHeaderView *)userView didClickGoodsButton:(UIButton *)goodsButton
{
    YTShopCarController *shopCarVc = [[YTShopCarController alloc] init];
    
    [self.navigationController pushViewController:shopCarVc animated:YES];
}

- (void)userCenterHeaderView:(YTUserCenterHeaderView *)userView didClickFocusButton:(UIButton *)focusButton
{
    NSLog(@"--focus--");
}
#pragma mark ------------------------cell的设置------------------------

/**
 *  第0组
 */
- (void)group0
{
    SettingArrowItem *MyOrder = [SettingArrowItem settingItemWithImage:@"usercenter-order" andWithTitle:@"我的订单" andWithClass:nil];
    SettingArrowItem *MyEvaluation = [SettingArrowItem settingItemWithImage:@"usetcenter-comment" andWithTitle:@"我的评价" andWithClass:nil];
    SettingArrowItem *coupon = [SettingArrowItem settingItemWithImage:@"usercenter-coupon" andWithTitle:@"我的代金券"];
    settingGroup *group0 = [[settingGroup alloc]init];
    group0.items = @[MyOrder,MyEvaluation,coupon];
    [self.dataArr addObject:group0];
}

/**
 *  第一组
 */
- (void)group1
{
     SettingArrowItem *setting = [SettingArrowItem settingItemWithImage:@"usetcenter-setup" andWithTitle:@"账户设置" andWithClass:nil];
    
    settingGroup *group1 = [[settingGroup alloc]init];
    
    group1.items = @[setting];
    
    [self.dataArr addObject:group1];
}

/**
 *  第2组
 */
- (void)group2
{
    SettingLabelItem *phone = [SettingLabelItem settingItemWithTitle:@"客服中心" andWithLabelTitle:@"400-079-6990" andWithIcon:@"usercenter-phone"];
    SettingArrowItem *feedback = [SettingArrowItem settingItemWithImage:@"usercenter-feedback" andWithTitle:@"意见反馈" andWithClass:nil];
    settingGroup *group2 = [[settingGroup alloc]init];
    group2.items = @[phone,feedback];
    [self.dataArr addObject:group2];
}

/**
 *  第3组
 */
- (void)group3
{
    SettingArrowItem *clear = [SettingArrowItem settingItemWithImage:@"usercenter-cache" andWithTitle:@"清除缓存" andWithClass:nil];
    clear.option = ^(){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否清除缓存?" message:[YTCacheSizeTool getCacheSize] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alertView.delegate = self;
        [alertView show];
        [[SDImageCache sharedImageCache] clearDisk];
        
    };
    settingGroup *group3 = [[settingGroup alloc]init];
    
    group3.items = @[clear];
    
    [self.dataArr addObject:group3];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     [[SDImageCache sharedImageCache] clearDisk];
     [MBProgressHUD showSuccess:@"清除成功"];
}

@end
