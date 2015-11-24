//
//  YTFemaleViewController.m
//  YT
//
//  Created by wangzhenhai on 15/10/19.
//  Copyright (c) 2015年 wangzhenhai. All rights reserved.
//

#import "YTFemaleViewController.h"
#import "YTChildModel.h"
#import "YTModel.h"
#import "YTRightMenuCell.h"
#import "YTSearchShowController.h"
@interface YTFemaleViewController () <YTRightMenuCell>

@property (nonatomic, strong) NSMutableArray *femaleArr;

@property (nonatomic, strong) NSMutableArray *resultArr;

@property (nonatomic, strong) UITableView *leftMenu;
@property (nonatomic, strong) UITableView *rightMenu;

@property (nonatomic, strong) UIView *lineindex;
@end

@implementation YTFemaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
}
- (NSMutableArray *)resultArr
{
    if (!_resultArr) {
        _resultArr = [NSMutableArray array];
    }
    return _resultArr;
}
#pragma mark  获取leftMenu的标题
- (void)setUpData
{
    for (int i=0; i<self.femaleArr.count; i++) {
        if (i>0 && i<10) {
            YTModel *model = self.femaleArr[i];
            [self.resultArr addObject:model];
        }
        else if(i>10)
        {
            YTModel *model = self.femaleArr[i];
            [self.resultArr addObject:model];
        }
    
    }
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.leftMenu selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    UIView *lineindex = [[UIView alloc]init];
    lineindex.frame = CGRectMake(0, 0, 5, 44);
    lineindex.backgroundColor = YTRed;
    [self.leftMenu addSubview:lineindex];
    self.lineindex = lineindex;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(self.leftMenu == tableView)
   {
       static NSString *ID = @"female";
       
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
       
       if (!cell) {
           cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
       }
       cell.backgroundColor = [UIColor whiteColor];
       cell.selectionStyle = UITableViewCellSelectionStyleGray;
       cell.textLabel.textAlignment = NSTextAlignmentCenter;
       cell.textLabel.font = kFont(15);
       YTModel *model = self.resultArr[indexPath.row];
       cell.textLabel.text = model.cname;
       return cell;
   }else
   {
       
       YTRightMenuCell *cell = [YTRightMenuCell cellWithTableview:tableView];
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       cell.delegate = self;
       cell.childs =  [self.resultArr[indexPath.row] childs];
       
       return cell;
   }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [YTTabBarTool mainTabbarshow];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.leftMenu == tableView) {
        
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        [UIView animateWithDuration:0.25 animations:^{
            self.lineindex.transform = CGAffineTransformMakeTranslation(0, indexPath.row * 44);
        }];
        [self.rightMenu scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

- (void)rightMenuCell:(YTRightMenuCell *)rightcell DidClickedModel:(YTChildModel *)model
{
    YTSearchShowController *searchShow = [[YTSearchShowController alloc] init];
    searchShow.title = model.cname;
    searchShow.gender = [model.gender stringValue];
    searchShow.cid = model.cid;
    [self.navigationController pushViewController:searchShow animated:YES];
}
@end
