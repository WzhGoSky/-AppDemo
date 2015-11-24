//
//  YTShopCarCell.h
//  YT
//
//  Created by wangzhenhai on 15/10/20.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YTShopsModel,YTShopCarCell;

@protocol YTShopCarCellDelegate <NSObject>

- (void)ShopCarCell:(YTShopCarCell *)cell shopsmodel:(YTShopsModel *)model andShopNum:(int)num;

- (void)ShopCarCell:(YTShopCarCell *)cell shopsmodel:(YTShopsModel *)model selectBtnIsSelectedL:(BOOL)selected;
@end
@interface YTShopCarCell : UITableViewCell

@property (nonatomic, strong) YTShopsModel *model;

@property (nonatomic, weak) id<YTShopCarCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
