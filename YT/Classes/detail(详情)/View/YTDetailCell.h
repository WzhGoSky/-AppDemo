//
//  YTDetailCell.h
//  YT
//
//  Created by wangzhenhai on 15/10/16.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class detailFrame;
@interface YTDetailCell : UITableViewCell

@property (nonatomic, strong) detailFrame *detframe;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
