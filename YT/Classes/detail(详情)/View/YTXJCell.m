//
//  YTXJCell.m
//  YT
//
//  Created by wangzhenhai on 15/10/17.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTXJCell.h"
#import "goodsModel.h"
#import "XJFrame.h"
#import "brandModel.h"
#import "HDTitleButton.h"
@interface YTXJCell()

@property (nonatomic, weak) UILabel *originlabel;

@property (nonatomic, weak) UILabel *brandOriginLabel;

@property (nonatomic, weak) UILabel *weightlabel;

@property (nonatomic, weak) UILabel *materiallabel;

@property (nonatomic, weak) UILabel *measurelabel;

@property (nonatomic, weak) UIView *view;

@property (nonatomic, weak) UILabel *label;

@property (nonatomic, weak) UIView *footerview;

@end
@implementation YTXJCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor lightGrayColor];
        view.frame = CGRectMake(0, 0, kScreenW, kFont(12).lineHeight + 10);
        [self.contentView addSubview:view];
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont boldSystemFontOfSize:12];
        label.text = @"产品细节";
        label.frame = CGRectMake(5, 2.5, kScreenW, kFont(12).lineHeight + 5);
        [view addSubview:label];
        self.label = label;
        
        UILabel *originlabel = [[UILabel alloc] init];
        originlabel.font = kFont(12);
        [self.contentView addSubview:originlabel];
        self.originlabel = originlabel;
        
        UILabel *brandOriginLabel = [[UILabel alloc] init];
        brandOriginLabel.font = kFont(12);
        [self.contentView addSubview:brandOriginLabel];
        self.brandOriginLabel = brandOriginLabel;
        
        UILabel *weightlabel = [[UILabel alloc] init];
        weightlabel.font = kFont(12);
        [self.contentView addSubview:weightlabel];
        self.weightlabel = weightlabel;
        
        UILabel *materiallabel = [[UILabel alloc] init];
        materiallabel.font = kFont(12);
        [self.contentView addSubview:materiallabel];
        self.materiallabel = materiallabel;
        
        UILabel *measurelabel = [[UILabel alloc] init];
        measurelabel.font = kFont(12);
        [self.contentView addSubview:measurelabel];
        self.measurelabel = measurelabel;
        
        UIView *footerview = [[UIView alloc] init];
        footerview.userInteractionEnabled = YES;
        footerview.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:footerview];
        self.footerview = footerview;
        
        HDTitleButton *button = [[HDTitleButton alloc] init];
        button.frame = CGRectMake(-7, 2.5, 20, kFont(12).lineHeight + 5);
        [button setTitle:@"图文详情" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"arrow-right"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.height = kFont(12).lineHeight + 8;
        [self.footerview addSubview:button];
    }
    
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"XJCell";
    YTXJCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YTXJCell alloc] init];
    }
    return cell;
}

- (void)setModel:(XJFrame *)model
{
    goodsModel *goodmodel = model.model;
    
    self.originlabel.text = [NSString stringWithFormat:@"货品产地: %@",goodmodel.origin];
    self.originlabel.frame = model.originFrame;
    
    self.brandOriginLabel.text = [NSString stringWithFormat:@"品牌属地: %@",goodmodel.brandorigin];
    self.brandOriginLabel.frame = model.brandOriginFrame;
    
    self.weightlabel.text = [NSString stringWithFormat:@"重量: %@",goodmodel.weight];
    self.weightlabel.frame = model.weightFrame;
    
    self.materiallabel.text = [NSString stringWithFormat:@"材料: %@",goodmodel.material];
    self.materiallabel.frame = model.materialFrame;
    
    self.measurelabel.text = [NSString stringWithFormat:@"尺寸: %@",goodmodel.measure];
    self.measurelabel.frame = model.measureFrame;
    
    self.footerview.frame = model.viewFrame;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)btnClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(XJCelldidClickButton:)]) {
        [self.delegate XJCelldidClickButton:button];
    }
}
@end
