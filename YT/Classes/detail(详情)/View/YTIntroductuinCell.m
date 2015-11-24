//
//  YTIntroductuinCell.m
//  YT
//
//  Created by wangzhenhai on 15/10/16.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTIntroductuinCell.h"
#import "IntroductionFrame.h"
#import "goodsModel.h"
@interface YTIntroductuinCell()

@property (nonatomic, weak) UILabel *desclabel;

@property (nonatomic, weak) UIView *view;

@property (nonatomic, weak) UILabel *label;
@end
@implementation YTIntroductuinCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor lightGrayColor];
        view.frame = CGRectMake(0, 0, kScreenW, kFont(12).lineHeight + 10);
        [self.contentView addSubview:view];
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont boldSystemFontOfSize:12];
        label.text = @"产品介绍";
        label.frame = CGRectMake(5, 2.5, kScreenW, kFont(12).lineHeight + 5);
        [view addSubview:label];
        self.label = label;
        
        UILabel *desclabel = [[UILabel alloc] init];
        desclabel.font = homedescFont;
        desclabel.textColor = [UIColor lightGrayColor];
        desclabel.numberOfLines = 0;
        [self.contentView addSubview:desclabel];
        self.desclabel = desclabel;
    }
    
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"IntroductuinCell";
    YTIntroductuinCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YTIntroductuinCell alloc] init];
    }
    return cell;
}

- (void)setIntrframe:(IntroductionFrame *)intrframe
{
    goodsModel *model = intrframe.model;
    self.desclabel.text = model.desc;
    self.desclabel.frame = intrframe.descFrame;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
