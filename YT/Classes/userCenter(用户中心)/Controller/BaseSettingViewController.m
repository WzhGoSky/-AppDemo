//
//  settingController.m
//  Lottery
//
//  Created by 王振海 on 15/9/11.
//  Copyright (c) 2015年 王振海. All rights reserved.
//

#import "SettingItem.h"
#import "SettingArrowItem.h"
#import "settingGroup.h"
#import "SettingCell.h"
#import "BaseSettingViewController.h"
@interface BaseSettingViewController ()

@end

@implementation BaseSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}
- (id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma mark tableviewcell 组
/**
 *  第0组
 */

#pragma mark tableview delegate && datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    settingGroup *item = self.dataArr[section];
    return item.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    SettingCell *cell = [SettingCell cellWithtableView:tableView];
    
    settingGroup *group = self.dataArr[indexPath.section];
    SettingItem *item = group.items[indexPath.row];
    
    cell.item = item;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    settingGroup *group = self.dataArr[indexPath.section];
    SettingItem *item = group.items[indexPath.row];
    if (item.option) {
        item.option();
    }
    if (![item isKindOfClass:[SettingArrowItem class]]) {
        return;
    }else if ([item isKindOfClass:[SettingArrowItem class]])
    {
        SettingArrowItem *arrowitem = (SettingArrowItem *)item;
        Class VC = arrowitem.destVC;
        if (!VC) {
            return;
        }else
        {
            UIViewController *destvc = [[VC alloc]init];
            destvc.title = arrowitem.title;
            [self.navigationController  pushViewController:destvc animated:YES];
        }
        
    }
}

@end
