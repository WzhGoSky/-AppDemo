//
//  homeGoodCell.h
//  YT
//
//  Created by wangzhenhai on 15/10/14.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class goodsFrame,goodsView;
@interface homeGoodCell : UITableViewCell

@property (nonatomic, strong) goodsFrame *goodFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
