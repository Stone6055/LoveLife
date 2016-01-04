//
//  FoodTitleCell.m
//  LoveLife
//
//  Created by qianfeng on 15/12/31.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "FoodTitleCell.h"

@implementation FoodTitleCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH-20)/2, 30) text:nil textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}
@end
