//
//  MusicCollectionReusableView.m
//  LoveLife
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 QF. All rights reserved.
//

#import "MusicCollectionReusableView.h"

@implementation MusicCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) text:nil textColor:nil font:[UIFont systemFontOfSize:15]];
        [self addSubview:self.titleLabel];
    }
    return self;
}
@end
