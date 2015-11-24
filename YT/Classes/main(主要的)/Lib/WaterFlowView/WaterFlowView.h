//
//  WaterFlowView.h
//  WaterFlow
//
//  Created by 王振海 on 15/9/26.
//  Copyright (c) 2015年 王振海. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WaterFlowViewTypeLeft,
    WaterFlowViewTypeRight,
    WaterFlowViewTypeTop,
    WaterFlowViewTypeBottom,
    WaterFlowViewTypeRow,
    WaterFlowViewTypeColumn
}WaterFlowViewType;

@class WaterFlowView,WaterFlowCell;

@protocol WaterFlowViewDataSource <NSObject>

@required
/**
 Cell个数
 */
- (NSUInteger)numberOfCell:(WaterFlowView *)waterFlow;
/**
 数据源
 */
- (WaterFlowCell *)waterFlowView:(WaterFlowView *)waterFlow cellAtIndex:(NSUInteger)index;
@optional
/**
 列数
 */
- (NSUInteger)numberofColumns:(WaterFlowView *)waterFlow;

@end


@protocol WaterFlowViewDelegate <UIScrollViewDelegate>

@optional
/**
 cell高度
 */
- (CGFloat)waterFlowView:(WaterFlowView *)waterFlow heightForCellAtIndex:(NSUInteger)index;

/**
 cell之间的间距
 */
- (CGFloat)waterFlowView:(WaterFlowView *)waterFlow MarginForCellAtIndex:(WaterFlowViewType)type;

/**
 cell选中事件
 */
- (void)waterFlow:(WaterFlowView *)waterFlow didSelectCellAtIndex:(NSUInteger)index;

@end
@interface WaterFlowView : UIScrollView

@property (nonatomic, weak) id<WaterFlowViewDataSource> dataSource;

@property (nonatomic, weak) id<WaterFlowViewDelegate> delegate;

/**
 刷新数据
 */
- (void)reloadData;

/**
 从缓存池中取
 */
- (id)dequeueReusableCellWithIdentifity:(NSString *)identifity;

/**
   cell的宽度
 */
- (CGFloat)cellWidth;
@end
