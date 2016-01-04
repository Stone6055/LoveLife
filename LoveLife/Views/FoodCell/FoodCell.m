//
//  FoodCell.m
//  LoveLife
//
//  Created by qianfeng on 15/12/31.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "FoodCell.h"
#import "FoodModel.h"

@implementation FoodCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, (SCREEN_WIDTH-20)/2-20, 130) imageName:nil];
    _imageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_imageView];
    
    _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _imageView.frame.size.height+10, _imageView.frame.size.width, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:15]];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    
    _desLabel = [FactoryUI createLabelWithFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.size.height + _titleLabel.frame.origin.y, _titleLabel.frame.size.width, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:12]];
    _desLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_desLabel];
    
    _playButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 40, 40) title:nil titleColor:nil imageName:@"iconfont-musicbofang" backgroundImageName:nil target:self selector:@selector(playButtonClick)];
    _playButton.center = _imageView.center;
    [_imageView addSubview:_playButton];
}
-(void)playButtonClick
{
    
    
}

-(void)refreshUI:(FoodModel *)model
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text = model.title;
    _desLabel.text = model.detail;
    
    
    
}

@end
