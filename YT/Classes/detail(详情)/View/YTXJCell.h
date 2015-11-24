//
//  YTXJCell.h
//  YT
//
//  Created by wangzhenhai on 15/10/17.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XJFrame;

@protocol YTXJCellDelegate <NSObject>

@optional
- (void)XJCelldidClickButton:(UIButton *)button;

@end


@interface YTXJCell : UITableViewCell

@property (nonatomic, weak) id<YTXJCellDelegate> delegate;
@property (nonatomic, strong) XJFrame *model;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
