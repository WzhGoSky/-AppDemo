//
//  YTLeftMenuCell.h
//  YT
//
//  Created by wangzhenhai on 15/10/19.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTLeftMenuCell;

@protocol YTLeftMenuCellDelegate <NSObject>

- (void)leftMenuCell:(YTLeftMenuCell *)cell DidClick:(UIButton *)button;

@end
@interface YTLeftMenuCell : UITableViewCell

@property (nonatomic, copy) NSString *title;
+ (instancetype)cellWithTableview:(UITableView *)tableview;

@end
