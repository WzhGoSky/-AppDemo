//
//  YTTabbarViewController.m
//  野糖（仿）
//
//  Created by wangzhenhai on 15/10/14.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTTabbarViewController.h"
#import "YTNavViewController.h"
#import "YTHomeViewController.h"
#import "YTMainViewController.h"
#import "YTDiscoverController.h"
#import "YTUserCenterViewController.h"
#import "YTTabBarManager.h"
@interface YTTabbarViewController ()

@property (nonatomic, weak) UIButton *lastButton;
@property (nonatomic, weak) UIImageView *tabbar;
@end

@implementation YTTabbarViewController


- (void)creatUIcontrollers
{
  
    
    YTHomeViewController *home = [[YTHomeViewController alloc]init];
    YTNavViewController *homeNav =[[YTNavViewController alloc] initWithRootViewController:home];
    home.title = @"野糖";
    
    YTDiscoverController *discover = [[YTDiscoverController alloc]init];
    YTNavViewController *discoverNav = [[YTNavViewController alloc] initWithRootViewController:discover];
    discover.title= @"发现";
    
    YTMainViewController *search = [[YTMainViewController alloc]init];
    YTNavViewController *searchNav = [[YTNavViewController alloc] initWithRootViewController:search];
    search.title = @"搜索";
    
    YTUserCenterViewController *userCenter = [[YTUserCenterViewController alloc]init];
    YTNavViewController *usercenterNav = [[YTNavViewController alloc] initWithRootViewController:userCenter];
    userCenter.title = @"用户中心";
    
     NSArray *controllers = @[homeNav,discoverNav,searchNav,usercenterNav];
    self.viewControllers = controllers;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    [self creatUI];
    [self creatUIcontrollers];
}

- (void)creatUI
{
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0,kScreenH-49, kScreenW, 49)];
    imageview.backgroundColor = [UIColor whiteColor];
    imageview.userInteractionEnabled = YES;
    [self.view addSubview:imageview];
    self.tabbar = imageview;
    
    YTTabBarManager *manager = [YTTabBarManager shareManager];
    manager.mainTabbar = imageview;
    
    //创建4个对象
    for (int index=0; index<4; index++) {
        CGFloat btnW = kScreenW / 4;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(index * btnW, 0, btnW, 48);
        
        NSString *str1 = [NSString stringWithFormat:@"CostomTabBar%d",index+1];
        NSString *str2 = [NSString stringWithFormat:@"CostomTabBar%dSel",index+1];
        
        [btn setImage:[UIImage imageNamed:str1] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:str2] forState:UIControlStateSelected];
        
        //设置默认状态下显示第一个视图控制器，第一个按钮处于选中状态
        if (index==0) {
            [self btnClick:btn];
        }
        
        btn.tag = index;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [imageview addSubview:btn];
    }
    
}

- (void)btnClick:(UIButton *)sender
{
    self.lastButton.selected = NO;
    sender.selected = YES;
    self.lastButton = sender;
    
    //跳转控制器
    self.selectedIndex = sender.tag;
}

@end
