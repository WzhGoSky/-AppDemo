//
//  YTMainViewController.m
//  YT
//
//  Created by wangzhenhai on 15/10/19.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTMainViewController.h"
#import "YTFemaleViewController.h"
#import "YTMaleViewController.h"
@interface YTMainViewController ()
{
    YTFemaleViewController *_femaleVc;
    YTMaleViewController *_maleVc;
}
@end

@implementation YTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createSegmentController];
}

- (void)createSegmentController
{
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"女士专题" ,@"男士专题"]];
    [segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
    
    _femaleVc = [[YTFemaleViewController alloc] init];
    _femaleVc.view.frame = CGRectMake(0, 0, kScreenW, kScreenH - 49);
    [self addChildViewController:_femaleVc];
    [self.view addSubview:_femaleVc.view];
    
    _maleVc = [[YTMaleViewController alloc] init];
    _maleVc.view.frame = CGRectMake(0, 0, kScreenW, kScreenH - 49);
    [self addChildViewController:_maleVc];
    
    segment.tintColor = YTRed;
    segment.selectedSegmentIndex = 0;
    
}

- (void)segmentClick:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 1) {
        [_femaleVc.view removeFromSuperview];
        [self.view addSubview:_maleVc.view];
    }else
    {
        [self.view addSubview:_femaleVc.view];
        [_maleVc.view removeFromSuperview];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
