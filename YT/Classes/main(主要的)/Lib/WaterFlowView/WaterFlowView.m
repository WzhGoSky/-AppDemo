//
//  WaterFlowView.m
//  WaterFlow
//
//  Created by 王振海 on 15/9/26.
//  Copyright (c) 2015年 王振海. All rights reserved.
//

#define WaterFlowViewDefaultHeight 70
#define WaterFlowViewDefaultMargin 8
#define WaterFlowViewDefaultColumns 3
#define waterFlowFromValueDefault 0 //在使用中view的y值 默认为0 
#import "WaterFlowView.h"
#import "WaterFlowCell.h"
@interface WaterFlowView ()

@property (nonatomic, strong) NSMutableArray *cellFrameArr;
@property (nonatomic, strong) NSMutableDictionary *displayingDict;
@property (nonatomic, strong) NSMutableSet *reusableSet;

@property (nonatomic, assign) CGFloat cellWidth;
@end


@implementation WaterFlowView

- (NSMutableArray *)cellFrameArr
{
    if (!_cellFrameArr) {
        _cellFrameArr = [NSMutableArray array];
    }
    return _cellFrameArr;
}

- (NSMutableDictionary *)displayingDict
{
    if (!_displayingDict) {
        _displayingDict = [NSMutableDictionary dictionary];
    }
    return _displayingDict;
}

- (NSMutableSet *)reusableSet
{
    if (!_reusableSet) {
        _reusableSet = [NSMutableSet set];
    }
    return _reusableSet;
}
- (void)reloadData
{
    //重新刷新的时候移除所有的值
    NSArray * allCells = [self.displayingDict allValues];
    for (WaterFlowCell *cell in allCells) {
        [cell  removeFromSuperview];
    }
    [self.displayingDict removeAllObjects];
    [self.cellFrameArr removeAllObjects];
    [self.reusableSet removeAllObjects];
    
    //获取总的cell的个数
    NSUInteger cellNum = [self.dataSource numberOfCell:self];
    
    //获取列数
    NSUInteger columnNum = [self numberOfColumns];
    
    //获取cell的间距
    CGFloat leftM = [self MarginWithType:WaterFlowViewTypeLeft];
    CGFloat rightM = [self MarginWithType:WaterFlowViewTypeRight];
    CGFloat bottomM = [self MarginWithType:WaterFlowViewTypeBottom];
    CGFloat topM = [self MarginWithType:WaterFlowViewTypeTop];
    CGFloat rowM = [self MarginWithType:WaterFlowViewTypeRow];
    CGFloat columnM = [self MarginWithType:WaterFlowViewTypeColumn];
    
    //计算每个cell的width
    CGFloat cellW = (self.bounds.size.width - rightM - leftM - (columnNum -1)*columnM)/columnNum;
    _cellWidth = cellW;
    //创建一个C数组存放每列的最大Y值
    CGFloat maxYOfColumns[columnNum];
    //初始化
    for (int i=0; i<columnNum; i++) {
        maxYOfColumns[i] = 0.0;
    }
    
    //计算每个cell的Frame
    for (int i=0; i<cellNum; i++) {
        //获得列Y值最小的列号和Y
        NSUInteger minYcolumNum = 0;
        CGFloat minYcolumValue = maxYOfColumns[minYcolumNum];
        
        for (int i = 1; i < columnNum; i++) {
            if (maxYOfColumns[i] < minYcolumValue) {
                minYcolumValue = maxYOfColumns[i];
                minYcolumNum = i;
            }
        }
        
        CGFloat cellX = leftM + minYcolumNum * (cellW + columnM);
        CGFloat cellY = 0;
        if (minYcolumValue == 0) {
            cellY = topM;
        }else
        {
            cellY = minYcolumValue + rowM;
        }
        CGFloat cellH = [self cellHeightAtIndex:i];
        
        //获取到了每个cell的frame
        CGRect frame = CGRectMake(cellX, cellY, cellW, cellH);
        //NSLog(@"%@",NSStringFromCGRect(frame));
        [self.cellFrameArr addObject:[NSValue valueWithCGRect:frame]];
        
        //更新c语言数组数据
        maxYOfColumns[minYcolumNum] = CGRectGetMaxY(frame);
    }
    //获得waterFlow的contentSize
    NSInteger maxYInColumsNum = 0;
    CGFloat maxYInColumnsValue = maxYOfColumns[maxYInColumsNum];
    for (int i =1; i<columnNum; i++) {
        if (maxYInColumnsValue < maxYOfColumns[i]) {
            maxYInColumnsValue = maxYOfColumns[i];
        }
    }
    
    self.contentSize = CGSizeMake(0, maxYInColumnsValue + bottomM + waterFlowFromValueDefault);
}

- (void)layoutSubviews
{
    //遍历数组
    for(int i = 0;i < self.cellFrameArr.count;i++)
    {
        CGRect cellFrame = [self.cellFrameArr[i] CGRectValue];
        
        //先从正在显示的字典中找
        WaterFlowCell *cell = self.displayingDict[@(i)];
        
        if ([self isInScreen:cellFrame]) { //在屏幕上
            if(!cell) //是新的cell 会去缓存池中找 找不到就创建
            {
                cell = [self.dataSource waterFlowView:self cellAtIndex:i];
                cell.frame = cellFrame;
                [self addSubview:cell];
                self.displayingDict[@(i)] = cell;
            }
        }else//如果不在屏幕上
        {
            if(cell)
            {
                [cell removeFromSuperview];
                [self.displayingDict removeObjectForKey:@(i)];
                [self.reusableSet addObject:cell];
            }
        }
    }
}

- (id)dequeueReusableCellWithIdentifity:(NSString *)identifity
{
     __block WaterFlowCell *ResuableCell = nil;
    //遍历集合 去缓存池中找
    [self.reusableSet enumerateObjectsUsingBlock:^(WaterFlowCell *cell, BOOL *stop) {
        if ([cell.identifity isEqualToString:identifity])
        {
            ResuableCell = cell;
            *stop = YES;
        }
    }];
    
    if (ResuableCell) { //如果resuablecell 找到了 就把他从缓存池中清除
        [self.reusableSet removeObject:ResuableCell];
    }
    return ResuableCell;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(![self.delegate respondsToSelector:@selector(waterFlow:didSelectCellAtIndex:)]) return;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    //遍历在屏幕上显示的字典 displaying
    __block NSNumber *selectedNum = nil;
    
    [self.displayingDict enumerateKeysAndObjectsUsingBlock:^(id key, WaterFlowCell *cell, BOOL *stop) {
        CGRect Frame = CGRectMake(cell.x + cell.width/4, cell.y + cell.height/4, cell.width/2, cell.height/2);
        if (CGRectContainsPoint(Frame, point)) {
            selectedNum  = key;
        }
    }];
    
    if (selectedNum) {
        [self.delegate waterFlow:self didSelectCellAtIndex:selectedNum.unsignedIntegerValue];
    }
}
/**
    将要移到父视图的时候调用此方法
 */
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self reloadData];
}

//返回cell的宽度
- (CGFloat)cellWidth
{
    return _cellWidth;
}
#pragma mark 私有方法

- (BOOL)isInScreen:(CGRect)rect
{
    return (CGRectGetMaxY(rect) > self.contentOffset.y) && (CGRectGetMinY(rect) < self.contentOffset.y + self.bounds.size.height);
}
- (NSInteger)numberOfColumns
{
    if ([self.dataSource respondsToSelector:@selector(numberofColumns:)]) {
        return [self.dataSource numberofColumns:self];
    }else
    {
        return WaterFlowViewDefaultColumns;
    }
}
- (CGFloat)MarginWithType:(WaterFlowViewType)type
{
    if([self.delegate respondsToSelector:@selector(waterFlowView:MarginForCellAtIndex:)])
    {
        return [self.delegate waterFlowView:self MarginForCellAtIndex:type];
    }else
    {
        return WaterFlowViewDefaultMargin;
    }
}
- (CGFloat)cellHeightAtIndex:(NSUInteger)index
{
    if ([self.delegate respondsToSelector:@selector(waterFlowView:heightForCellAtIndex:)]) {
        return [self.delegate waterFlowView:self heightForCellAtIndex:index];
    }else
    {
        return WaterFlowViewDefaultHeight;
    }
}
@end
