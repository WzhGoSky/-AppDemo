//
//  YTSearchShowController.m
//  YT
//
//  Created by wangzhenhai on 15/10/19.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTSearchShowController.h"
#import "HttpTool.h"
#import "goodsModel.h"
#import "YTCollectionCell.h"
#import "YTDeatilTableViewController.h"
@interface YTSearchShowController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) int page;
@end

@implementation YTSearchShowController
#pragma mark  懒加载
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma mark 初始化数据
- (void)initData
{
    if (self.gender==nil) {
        self.gender = [NSString stringWithFormat:@"%d",arc4random_uniform(2)];
    }
    if (self.cid==nil) {
        self.cid = [NSString stringWithFormat:@"%d",arc4random_uniform(5)];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self creatUI];
    
    [self setRefersh];
    
}

- (void)setRefersh
{
    //设置回调一旦刷新就会调用此方法
    __weak __typeof(self) weakself = self;
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [weakself connectionWithPage:_page carStr:weakself.cid gender:weakself.gender RemoveAll:YES];
    }];
    [self.collectionView.header beginRefreshing];
    self.collectionView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}
#pragma mark loadMoreData
- (void)loadMoreData
{
    _page++;
    [self connectionWithPage:_page carStr:self.cid gender:self.gender RemoveAll:NO];
}
- (void)setUpRightButton
{
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"btn-cart"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStyleDone target:self action:@selector(shopCart:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)shopCart:(UIButton *)button
{
    
}
- (void)creatUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    UICollectionView *collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) collectionViewLayout:layout];
    collectionview.delegate = self;
    collectionview.dataSource = self;
    [collectionview registerClass:[YTCollectionCell class] forCellWithReuseIdentifier:@"collectioncell"];
    [self.view addSubview:collectionview];
    collectionview.backgroundColor = [UIColor whiteColor];
    self.collectionView = collectionview;
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
        [self.collectionView.header endRefreshing];
        [self.collectionView.footer endRefreshing];
        if (obj) {
            if(isRemoveAll)
            {
                [self.dataArr removeAllObjects];
            }
            NSArray *list = [self objectArrWithDict:obj];
            
            for (int i=0; i<list.count; i++) {
                goodsModel *goodmodel = [goodsModel objectWithKeyValues:list[i]];
                [self.dataArr addObject:goodmodel];
            }
            [self.collectionView reloadData];
        }
        
    } failure:^(NSError *error) {
        [self.collectionView.header endRefreshing];
        [self.collectionView.footer endRefreshing];

    }];
}

- (NSArray *)objectArrWithDict:(NSDictionary *)dict
{
    NSDictionary *data = dict[@"data"];
    NSArray *list = data[@"productlist"];
    return list;
}

#pragma mark collectionDelegate && dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YTCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectioncell" forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.item];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake((kScreenW - 30)/2, 0.60 * kScreenW);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kScreenW * 0.05,10, kScreenW * 0.1, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YTDeatilTableViewController *detailVc = [[YTDeatilTableViewController alloc] init];
    detailVc.model = self.dataArr[indexPath.row];
    
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [YTTabBarTool mainTabbarshow];
}

@end
