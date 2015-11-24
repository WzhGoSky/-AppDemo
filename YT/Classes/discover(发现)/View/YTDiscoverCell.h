//
//  YTDiscoverCell.h
//  YT
//
//  Created by wangzhenhai on 15/10/18.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "WaterFlowCell.h"

@class WaterFlowView,goodsModel;
@interface YTDiscoverCell : WaterFlowCell

@property (nonatomic, strong) goodsModel *model;

+ (instancetype)cellWithTableView:(WaterFlowView *)waterflowView;

@end
