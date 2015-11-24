//
//  YTShopCarController.m
//  YT
//
//  Created by wangzhenhai on 15/10/20.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTShopCarController.h"
#import "goodsModel.h"
#import "YTShopsModel.h"
#import "YTShopCarCell.h"
#import "YTTabBarManager.h"
@interface YTShopCarController () <YTShopCarCellDelegate>

@property (nonatomic, strong) NSMutableArray *shopsArr;
@property (nonatomic, assign) CGFloat allPrice;


@property (nonatomic, weak) UILabel *showallPriceLabel;
@property (nonatomic, weak) UIButton *payButton;
@end

@implementation YTShopCarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.shopsArr = [YTShopCarTool allData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"购物车";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    
    [self setUpimageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark ------------------------创建UI--------------------------
- (CGFloat)Price
{
    for (YTShopsModel *model in self.shopsArr) {
        int count = model.num;
        CGFloat price = [model.model.price floatValue];
        _allPrice = _allPrice + count * price;
    }
    return _allPrice;
}
- (void)setUpimageView
{
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.userInteractionEnabled = YES;
    imageview.backgroundColor = [UIColor whiteColor];
    imageview.frame = CGRectMake(0, kScreenH - 49, kScreenW, 49);
    [self.navigationController.view addSubview:imageview];
    YTTabBarManager *manager = [YTTabBarManager shareManager];
    manager.shopCarTabbar = imageview;
    [self addbuttonInView:imageview];
}

- (void)addbuttonInView:(UIView *)imageview
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 10, 150, 30);
    label.text = [NSString stringWithFormat:@"总计：￥%.1f",[self Price]];
    self.showallPriceLabel = label;
    [imageview addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"去结算" forState:UIControlStateNormal];
    button.frame = CGRectMake(kScreenW - 20 - 100, 10, 100, 30);
    [button setTitleColor:YTRed forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"mesBgRed"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"mesBgGray"] forState:UIControlStateDisabled];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [imageview addSubview:button];
    self.payButton = button;
}

#pragma mark ------------------------view方法--------------------------
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self judgedPayButtonEnable];
    
    [YTTabBarTool detailTabbarhidden];
    [YTTabBarTool mainTabbarhidden];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [YTTabBarTool shopCarTabbarhidden];
}
#pragma mark ------------------------私有方法--------------------------
- (void)judgedPayButtonEnable
{
    if (self.shopsArr.count == 0) {
        self.payButton.enabled = NO;
    }else
    {
        self.payButton.enabled = YES;
    }
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shopsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTShopCarCell *cell = [YTShopCarCell cellWithTableView:tableView];
    cell.model = self.shopsArr[indexPath.row];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
//删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除数据的操作
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //数据源删除
        YTShopsModel *model = self.shopsArr[indexPath.row];
        [self.shopsArr removeObject:model];
        
        [self judgedPayButtonEnable];
        //刷新表格视图
        [self.tableView reloadData];
        
        _allPrice = 0; //将总价清零 重新计算总价
        self.showallPriceLabel.text = [NSString stringWithFormat:@"总计:￥%.1f",[self Price]];
    }
    
}
#pragma mark ------------------------YTShopCarCellDelegate--------------------------
- (void)ShopCarCell:(YTShopCarCell *)cell shopsmodel:(YTShopsModel *)model andShopNum:(int)num
{
    //修改数组中model的num
    for (YTShopsModel *shopmodel in self.shopsArr) {
        if ([shopmodel.model.productname isEqualToString:model.model.productname]) {
            shopmodel.num = num;
            break;
        }
    }
    _allPrice = 0; //将总价清零 重新计算总价
    self.showallPriceLabel.text = [NSString stringWithFormat:@"总计:￥%.1f",[self Price]];
    
}

//- (void)ShopCarCell:(YTShopCarCell *)cell shopsmodel:(YTShopsModel *)model selectBtnIsSelectedL:(BOOL)selected
//{
//    YTShopsModel *removeShopModel;
//    BOOL isAdd = NO;//设置标志位 判断是否要添加
//    
//    if (selected == NO) { //判断不是选中的话 就从数组中移除
//        for (YTShopsModel *shopmodel in self.shopsArr) {
//            if ([model.model.productname isEqualToString:shopmodel.model.productname]) {
//                removeShopModel = shopmodel;
//            }
//        }
//        [self.shopsArr removeObject:removeShopModel];
//    }else
//    {
//        for (YTShopsModel *shopmodel in self.shopsArr) {
//            if ([model.model.productname isEqualToString:shopmodel.model.productname]) {
//                isAdd = NO;
//                break;
//            }
//        }
//        if (isAdd) {
//           [self.shopsArr addObject:model];
//        }
//    }
//    
//    _allPrice = 0; //将总价清零 重新计算总价
//    self.showallPriceLabel.text = [NSString stringWithFormat:@"总计:￥%.1f",[self Price]];
//}
#pragma mark ---------------------------跳转界面-----------------------
- (void)back:(UIButton *)button
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
