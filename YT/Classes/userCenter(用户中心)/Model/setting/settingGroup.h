//
//  settingGroup.h
//  Lottery
//
//  Created by 王振海 on 15/9/11.
//  Copyright (c) 2015年 王振海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface settingGroup : NSObject

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, copy) NSString *header;

@property (nonatomic, copy) NSString *footer;
@end
