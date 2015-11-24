//
//  SettingCell.m
//  Lottery
//
//  Created by 王振海 on 15/9/11.
//  Copyright (c) 2015年 王振海. All rights reserved.
//

#import "SettingCell.h"
#import "SettingItem.h"
#import "SettingArrowItem.h"
#import "SettingSwitchItem.h"
#import "SettingLabelItem.h"
@interface SettingCell()

@property (nonatomic, strong) UISwitch *setSwitch;

@property (nonatomic, strong) UIImageView *imageVI;

@property (nonatomic, strong) UILabel *label;

@end
@implementation SettingCell

- (UISwitch *)setSwitch
{
    if (!_setSwitch) {
        _setSwitch = [[UISwitch alloc]init];
    }
    return _setSwitch;
}

- (UIImageView *)imageVI
{
    if (!_imageVI) {
        _imageVI = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"usercenter-right"]];
    }
    return _imageVI;
}
- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.bounds = CGRectMake(0, 0, 120, 30);
        _label.font = kFont(14);
    }
    return _label;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithtableView:(UITableView *)tableview
{
    static NSString *ID = @"setting";
    SettingCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setItem:(SettingItem *)item
{
    _item = item;
    
    self.textLabel.text = item.title;
    self.label.text = item.labelTitle;
    if (item.iconimage) {
        self.imageView.image = [UIImage imageNamed:item.iconimage];
    }
    if ([item isKindOfClass:[SettingSwitchItem class]]) {
        self.accessoryView = self.setSwitch;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if ([item isKindOfClass:[SettingArrowItem class]])
    {
        self.accessoryView = self.imageVI;
    }else if ([item isKindOfClass:[SettingLabelItem class]])
    {
        self.accessoryView = self.label;
    }
    else
    {
        self.accessoryView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}


@end
