//
//  MusciCollectionViewCell.m
//  LoveLife
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 QF. All rights reserved.
//

#import "MusciCollectionViewCell.h"

@implementation MusciCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    self.imageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) imageName:nil];
    [self.contentView addSubview:self.imageView];
    
    self.titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, self.imageView.frame.size.width, 30) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
    self.titleLabel.center = self.imageView.center;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.imageView addSubview:self.titleLabel];
    
}
@end
