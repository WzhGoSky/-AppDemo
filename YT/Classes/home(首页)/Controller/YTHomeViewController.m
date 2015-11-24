//
//  YTHomeViewController.m
//  野糖（仿）
//
//  Created by wangzhenhai on 15/10/14.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTHomeViewController.h"
#import "HttpTool.h"
#import "goodsModel.h"
#import "goodsFrame.h"
#import "homeGoodCell.h"
#import "YTDeatilTableViewController.h"
#import "YTShopCarButton.h"
#import "YTShopCarController.h"
#import "YTShopsModel.h"
#import "DBManager.h"
@interface YTHomeViewController ()<YTShopCarButtonDelegate>

@property (nonatomic, strong) NSMutableArray *goodsArr;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) YTShopCarButton *shopbtn;
@property (nonatomic, assign, getter=islike) BOOL like;

@property (nonatomic, strong) UIImageView *animationView;
@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation YTHomeViewController

- (NSMutableArray *)goodsArr
{
    if (!_goodsArr) {
        _goodsArr = [NSMutableArray array];
    }
    return _goodsArr;
}
#pragma mark ---------------------------view的方法-----------------------
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.shopbtn.badgeValue = [YTShopCarTool shopsCarCount];
    [YTTabBarTool mainTabbarshow];
    
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRedItem];
    [self setRefersh];
    self.tableView.backgroundColor = kColor(211, 211, 211);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapImage:) name:KtapKey object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(priceBtnClick:) name:kPriceBtn object:nil];
}


#pragma mark ------------------------创建UI------------------------
- (void)setRedItem{
    
    YTShopCarButton *shopCarBtn = [[YTShopCarButton alloc] init];
    shopCarBtn.image = [UIImage imageNamed:@"btn-cart"];
    shopCarBtn.width = 20;
    shopCarBtn.height = 18;
    shopCarBtn.delegate = self;
    self.shopbtn = shopCarBtn;
    self.shopbtn.badgeValue = [YTShopCarTool shopsCarCount];
    UIBarButtonItem *rightbutton = [[UIBarButtonItem alloc] initWithCustomView:shopCarBtn];
    self.navigationItem.rightBarButtonItem = rightbutton;
    
    //创建添加购物车动画的图片
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.frame = CGRectMake(50, 400, 100, 100);
    imageview.hidden = YES;
    [window addSubview:imageview];
    self.animationView = imageview;
}

#pragma mark ------------------------实现购物车的代理方法------------------------
- (void)shopCharDidClick:(YTShopCarButton *)shopchar
{
    YTShopCarController *shopCar = [[YTShopCarController alloc] init];
    [self.navigationController pushViewController:shopCar animated:YES];
}

#pragma mark ------------------------refersh------------------------
- (void)setRefersh
{
    __weak __typeof(self) weakself = self;
    //设置回调一旦刷新就会调用此方法
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [weakself sendNetWorkWithPage:_page isRemoveAll:YES];
    }];
    [self.tableView.header beginRefreshing];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)loadMoreData
{
    _page++;
    [self sendNetWorkWithPage:_page isRemoveAll:NO];
}

- (void)sendNetWorkWithPage:(NSInteger)page isRemoveAll:(BOOL)isRemoveAll
{
    NSMutableDictionary *parameters =[NSMutableDictionary dictionary];
    
    parameters[@"gender"] = @"2";
    
    parameters[@"p"] = [NSString stringWithFormat:@"%ld",page];
    
    parameters[@"token"] = @"1.00NMcP6FKvfyiPw";
    
    parameters[@"userid"] = @"735385";
    
    NSString *url=@"http://app.yetang.com/appgate/Indexgate/indexFeedList";
    
    __weak __typeof(self) weakSelf = self;
    
    [HttpTool POST:url Parameters:parameters success:^(id obj) {
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
        if (isRemoveAll) {
            
            [self.goodsArr removeAllObjects];
        }
        NSArray *list = [self projectWithDict:obj];
        NSUInteger count = [self reallist:list];
        for (int i=0; i<list.count; i++) {
            if (page == 1) {
                if (i>=count) {
                    goodsModel *good = [goodsModel objectWithKeyValues:list[i]];

                    goodsFrame *goodFrame = [[goodsFrame alloc]init];
                    goodFrame.model = good;
                    [self.goodsArr addObject:goodFrame];
                }
            }else
            {
                goodsModel *good = [goodsModel objectWithKeyValues:list[i]];
                goodsFrame *goodFrame = [[goodsFrame alloc]init];
                goodFrame.model = good;
                [self.goodsArr addObject:goodFrame];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
    }];
}

#pragma mark ------------------------私有方法 从大字典中取得小字典------------------------
- (NSArray *)projectWithDict:(NSDictionary *)dict
{
    NSDictionary *data = dict[@"data"];
    NSDictionary *data2 = data[@"data"];
    NSArray *list = data2[@"list"];
    return list;
}

- (NSUInteger)reallist:(NSArray *)list
{
    NSUInteger count = 0;
    for (NSDictionary *dict in list) {
        if (dict.count < 40) {
            count++;
        }
        if (dict.count>40) {
            break;
        }
    }
    return count;
}
#pragma mark ---------------------------TableView的delegate&&datasource------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio
{

    return self.goodsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    homeGoodCell *cell = [homeGoodCell cellWithTableView:tableView];
    cell.goodFrame = self.goodsArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        cell.alpha = 1;
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.goodsArr[indexPath.row] cellHeight];
}

#pragma mark ---------------------------跳转界面-----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTDeatilTableViewController *detailVC = [[YTDeatilTableViewController alloc] init];
    goodsFrame *frame = self.goodsArr[indexPath.row];
    detailVC.model = frame.model;
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark --------------------通知事件方法实现-----------------------------------------
- (void)tapImage:(NSNotification *)noti
{
    YTDeatilTableViewController *detailVC = [[YTDeatilTableViewController alloc] init];
    detailVC.model = noti.object;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark ---------------------------点击了价格按钮-----------------------
- (void)priceBtnClick:(NSNotification *)noti
{
    BOOL isrepeat = NO; //判断是否重复
    //当前点击的
    goodsModel *model = noti.object;
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
    self.animationView.hidden = NO;
    [self.animationView setImageWithURL:[NSURL URLWithString:model.img]];
    
    [self groupAnimation];
}

#pragma mark ------------------------Animation------------------------
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
    [self.animationView.layer removeAnimationForKey:@"group"];
    self.animationView.hidden = YES;
    [MBProgressHUD showSuccess:@"添加购物车成功"];
    self.shopbtn.badgeValue = [YTShopCarTool shopsCarCount];
}
@end
