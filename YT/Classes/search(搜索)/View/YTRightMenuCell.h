//
//  YTRightMenuCell.h
//  YT
//
//  Created by wangzhenhai on 15/10/19.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTChildModel,YTRightMenuCell,YTModel;

@protocol YTRightMenuCell <NSObject>

- (void)rightMenuCell:(YTRightMenuCell *)rightcell DidClickedModel:(YTChildModel *)model;

@end
@interface YTRightMenuCell : UITableViewCell


@property (nonatomic, strong) NSArray *childs;

@property (nonatomic, weak) id <YTRightMenuCell> delegate;

+ (instancetype)cellWithTableview:(UITableView *)tableview;

@end
