//
//  YTSearchViewController.m
//  野糖（仿）
//
//  Created by wangzhenhai on 15/10/14.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTSearchViewController.h"
#import "YTModel.h"
@interface YTSearchViewController ()

@property (nonatomic, strong) NSMutableArray *femaleArr;
@property (nonatomic, strong) NSMutableArray *funArr;
@property (nonatomic, strong) NSMutableArray *maleArr;

@property (nonatomic, strong) UITableView *leftMenu;
@property (nonatomic, strong) UITableView *rightMenu;

@end

@implementation YTSearchViewController

- (NSMutableArray *)femaleArr
{
    if (!_femaleArr) {
        _femaleArr = [NSMutableArray array];
    }
    
    return _femaleArr;
}

- (NSMutableArray *)funArr
{
    if (!_funArr) {
        _funArr = [NSMutableArray array];
    }
    return _funArr;
}

- (NSMutableArray *)maleArr
{
    if (!_maleArr) {
        _maleArr = [NSMutableArray array];
    }
    return _maleArr;
}

- (void)initData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"searchMenu.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    self.maleArr = [YTModel objectArrayWithKeyValuesArray:dict[@"male"]];
    self.funArr = [YTModel objectArrayWithKeyValuesArray:dict[@"fun"]];
    self.femaleArr = [YTModel objectArrayWithKeyValuesArray:dict[@"female"]];
    
    NSRange range = NSMakeRange(self.maleArr.count, self.funArr.count);
    NSIndexSet *indexset = [NSIndexSet indexSetWithIndexesInRange:range];
    [self.maleArr insertObjects:self.funArr atIndexes:indexset];
    
    NSRange range1 = NSMakeRange(self.femaleArr.count, self.funArr.count);
    NSIndexSet *indexset1 = [NSIndexSet indexSetWithIndexesInRange:range1];
    [self.femaleArr insertObjects:self.funArr atIndexes:indexset1];
}

- (void)crateUI
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,64, kScreenW * 0.3, kScreenH - 64 - 49) style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    self.leftMenu = tableview;
    self.leftMenu.showsVerticalScrollIndicator = NO;
    self.leftMenu.delegate = self;
    self.leftMenu.dataSource = self;
    
    UITableView *tableview1 = [[UITableView alloc] initWithFrame:CGRectMake(kScreenW * 0.3, 64, kScreenW * 0.7, kScreenH - 64 - 49)  style:UITableViewStylePlain];
    [self.view addSubview:tableview1];
    self.rightMenu = tableview1;
    self.rightMenu.backgroundColor = [UIColor lightGrayColor];
    self.rightMenu.scrollEnabled = NO;
    self.rightMenu.delegate = self;
    self.rightMenu.dataSource = self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self crateUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.rightMenu == tableView) {
        return kScreenH - 64 - 49;
    }
    return 44;
}


@end
