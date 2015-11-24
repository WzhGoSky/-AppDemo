//
//  YTShopCarCell.m
//  YT
//
//  Created by wangzhenhai on 15/10/20.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTShopCarCell.h"
#import "goodsModel.h"
#import "YTShopsModel.h"
@interface YTShopCarCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (weak, nonatomic) IBOutlet UILabel *allPrice;
@property (weak, nonatomic) IBOutlet UILabel *produceName;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@property (nonatomic ,assign) int count;
@property (nonatomic, assign) CGFloat price;
@end

@implementation YTShopCarCell

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    return [[[NSBundle mainBundle]loadNibNamed:@"YTShopCarCell" owner:self options:nil]lastObject];
    
}
- (void)awakeFromNib {
    self.selectBtn.selected = YES;
}

- (void)setModel:(YTShopsModel *)model
{
    _model = model;
    
    goodsModel *goodmodel = model.model;
    [self.iconImage setImageWithURL:[NSURL URLWithString:goodmodel.img] placeholderImage:[UIImage imageNamed:@"holder-item"]];
    
    self.numLabel.text = [NSString stringWithFormat:@"%d",model.num];
    
    self.produceName.text = goodmodel.productname;
    
    self.priceLabel.text = [NSString stringWithFormat:@"单价:￥%.1f",[goodmodel.price floatValue]];
    self.allPrice.text = [NSString stringWithFormat:@"小计:￥%.1f",[goodmodel.price floatValue] * model.num];
    
    self.price = [goodmodel.price floatValue];
    
    _count = model.num;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (IBAction)SelectBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ShopCarCell:shopsmodel:selectBtnIsSelectedL:)]) {
        [self.delegate ShopCarCell:self shopsmodel:self.model selectBtnIsSelectedL:sender.isSelected];
    }
        sender.selected = !sender.selected;
}
- (IBAction)leftBtn:(UIButton *)sender {
    if (_count == 1) {
        _count = 1;
    }else
    {
        _count--;
        self.numLabel.text = [NSString stringWithFormat:@"%d",_count];
        self.allPrice.text = [NSString stringWithFormat:@"小计:￥%.1f",self.price * _count];
    }
    if ([self.delegate respondsToSelector:@selector(ShopCarCell:shopsmodel:andShopNum:)]) {
        [self.delegate ShopCarCell:self shopsmodel:self.model andShopNum:_count];
    }
    
}
- (IBAction)rightBtn:(UIButton *)sender {
    _count++;
    self.numLabel.text = [NSString stringWithFormat:@"%d",_count];
    self.allPrice.text = [NSString stringWithFormat:@"小计:￥%.1f",self.price * _count];
    
    if ([self.delegate respondsToSelector:@selector(ShopCarCell:shopsmodel:andShopNum:)]) {
        [self.delegate ShopCarCell:self shopsmodel:self.model andShopNum:_count];
    }
}

@end
