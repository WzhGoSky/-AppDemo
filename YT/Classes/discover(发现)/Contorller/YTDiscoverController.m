//
//  YTDiscoverController.m
//  YT
//
//  Created by wangzhenhai on 15/10/18.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTDiscoverController.h"
#import "WaterFlowView.h"
#import "YTDiscoverCell.h"
#import "HttpTool.h"
#import "goodsModel.h"
#import "YTWeightHeightModel.h"
#import "YTDeatilTableViewController.h"
#import "YTShopCarButton.h"
#import "YTShopCarController.h"
@interface YTDiscoverController() <WaterFlowViewDataSource,WaterFlowViewDelegate,YTShopCarButtonDelegate>

@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *carStr;
@property (nonatomic, assign) int page;

@property (nonatomic, strong) WaterFlowView *waterview;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *widthHightArr;
@property (nonatomic, strong) YTShopCarButton *shopBtn;

@end
@implementation YTDiscoverController

- (void)loadView
{
    self.view = [[WaterFlowView alloc] init];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    
    [self setRedItem];
    
    [self setUpwaterFlowView];
    
    [self setRefersh];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.shopBtn.badgeValue = [YTShopCarTool shopsCarCount];
    [YTTabBarTool mainTabbarshow];
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)widthHightArr
{
    if (!_widthHightArr) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"1.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        _widthHightArr = [NSMutableArray arrayWithCapacity:50];
        for (NSDictionary *dict in array) {
            YTWeightHeightModel *model = [YTWeightHeightModel modelWithDict:dict];
            [_widthHightArr addObject:model];
        }
    }
    return _widthHightArr;
}
- (void)initData
{
    if (self.gender==nil) {
        self.gender = [NSString stringWithFormat:@"%d",arc4random_uniform(2)];
    }
    if (self.carStr==nil) {
        self.carStr = [NSString stringWithFormat:@"%d",arc4random_uniform(5)];
    }
    
    self.page = 1;
}

- (void)setRefersh
{
    //设置回调一旦刷新就会调用此方法
    __weak __typeof(self) weakself = self;
    self.waterview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [weakself connectionWithPage:_page carStr:weakself.carStr gender:weakself.gender RemoveAll:YES];
    }];
    [self.waterview.header beginRefreshing];
    self.waterview.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)setRedItem{
    
    YTShopCarButton *shopCarBtn = [[YTShopCarButton alloc] init];
    shopCarBtn.image = [UIImage imageNamed:@"btn-cart"];
    shopCarBtn.width = 20;
    shopCarBtn.height = 18;
    shopCarBtn.delegate = self;
    self.shopBtn = shopCarBtn;
    self.shopBtn.badgeValue = 1;
    UIBarButtonItem *rightbutton = [[UIBarButtonItem alloc] initWithCustomView:shopCarBtn];
    self.navigationItem.rightBarButtonItem = rightbutton;
}

#pragma mark 实现购物车的代理方法
- (void)shopCharDidClick:(YTShopCarButton *)shopchar
{
    YTShopCarController *shopCar = [[YTShopCarController alloc] init];
    [self.navigationController pushViewController:shopCar animated:YES];
}
#pragma mark loadMoreData
- (void)loadMoreData
{
    _page++;
    [self connectionWithPage:_page carStr:self.carStr gender:self.gender RemoveAll:NO];
}

- (void)setUpwaterFlowView
{
    _waterview = (WaterFlowView *)self.view;
    _waterview.delegate = self;
    _waterview.dataSource = self;
}

#pragma mark netWorking
- (void)connectionWithPage:(int)page carStr:(NSString *)carStr gender:(NSString *)gender RemoveAll:(BOOL)isRemoveAll
{
    NSMutableDictionary *parameters =[NSMutableDictionary dictionary];
    
    parameters[@"cat"] = carStr;
    
    parameters[@"gender"]=gender;
    
    parameters[@"p"] = [NSString stringWithFormat:@"%d",page];
    
    parameters[@"token"] = @"1.00NMcP6FKvfyiPw";
    
    parameters[@"type"] = @"0";
    
    parameters[@"userid"] = @"735385";
    
    NSString *url=@"http://app.yetang.com/appgate/Searchgate/searchList";
    
    [HttpTool POST:url Parameters:parameters success:^(id obj) {
        if (obj) {
            [self.waterview.header endRefreshing];
            [self.waterview.footer endRefreshing];
            if(isRemoveAll)
            {
                [self.dataArr removeAllObjects];
            }
            NSArray *list = [self objectArrWithDict:obj];
            
            for (int i=0; i<list.count - 1; i++) {
                NSUInteger randomcount = arc4random()%50;
                YTWeightHeightModel *WHmodel = self.widthHightArr[randomcount];
                
                goodsModel *goodmodel = [goodsModel objectWithKeyValues:list[i]];
                goodmodel.WHmodel = WHmodel;
                [self.dataArr addObject:goodmodel];
            }
            [self.waterview reloadData];
        }
        
    } failure:^(NSError *error) {
        [self.waterview.header endRefreshing];
        [self.waterview.footer endRefreshing];
    }];
}
#pragma mark 私有方法
- (NSArray *)objectArrWithDict:(NSDictionary *)dict
{
    NSDictionary *data = dict[@"data"];
    NSArray *list = data[@"productlist"];
    return list;
}
#pragma mark waterflow delegate && datasource
- (NSUInteger)numberOfCell:(WaterFlowView *)waterFlow
{
    return self.dataArr.count;
}

- (NSUInteger)numberofColumns:(WaterFlowView *)waterFlow
{
    return 3;
}
- (WaterFlowCell *)waterFlowView:(WaterFlowView *)waterFlow cellAtIndex:(NSUInteger)index
{
    YTDiscoverCell *cell = [YTDiscoverCell cellWithTableView:waterFlow];
    cell.model = self.dataArr[index];
    return cell;
}

- (CGFloat)waterFlowView:(WaterFlowView *)waterFlow MarginForCellAtIndex:(WaterFlowViewType)type
{
    switch (type) {
        case WaterFlowViewTypeColumn:
            return 10;
            break;
        case WaterFlowViewTypeRow:
            return 10;
            break;
        default: return 8;
            break;
    }
}
- (CGFloat)waterFlowView:(WaterFlowView *)waterFlow heightForCellAtIndex:(NSUInteger)index
{
    CGFloat cellwidth = [waterFlow cellWidth];
    goodsModel *goodmodel = self.dataArr[index];
    YTWeightHeightModel *WHmodel = goodmodel.WHmodel;
    CGFloat h = WHmodel.h;
    CGFloat w = WHmodel.w;
    return cellwidth * (h/w);
}

- (void)waterFlow:(WaterFlowView *)waterFlow didSelectCellAtIndex:(NSUInteger)index
{
    YTDeatilTableViewController *detailVC = [[YTDeatilTableViewController alloc] init];
    detailVC.model = self.dataArr[index];
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
