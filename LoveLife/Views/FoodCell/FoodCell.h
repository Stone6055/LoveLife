//
//  FoodCell.h
//  LoveLife
//
//  Created by qianfeng on 15/12/31.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"
#import <MediaPlayer/MediaPlayer.h>

@interface FoodCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * desLabel;


@property (nonatomic,strong) UIButton * playButton;
//@property (nonatomic,weak) id<playDelegate>delegate;
-(void)refreshUI:(FoodModel *)model;

@end
