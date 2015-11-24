//
//  SettingCell.h
//  Lottery
//
//  Created by 王振海 on 15/9/11.
//  Copyright (c) 2015年 王振海. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingItem;
@interface SettingCell : UITableViewCell

@property (nonatomic, strong) SettingItem *item;
+ (instancetype)cellWithtableView:(UITableView *)tableview;
@end
