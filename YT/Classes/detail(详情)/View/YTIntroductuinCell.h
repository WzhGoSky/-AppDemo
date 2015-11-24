//
//  YTIntroductuinCell.h
//  YT
//
//  Created by wangzhenhai on 15/10/16.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IntroductionFrame;
@interface YTIntroductuinCell : UITableViewCell

@property (nonatomic, strong) IntroductionFrame *intrframe;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
