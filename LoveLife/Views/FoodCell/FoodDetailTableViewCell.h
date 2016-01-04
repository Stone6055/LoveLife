//
//  FoodDetailTableViewCell.h
//  LoveLife
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodDetailModel.h"

@interface FoodDetailTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel * detailLabel;
@property(nonatomic,strong) UIImageView * detailImageView;

-(void)refreshUI:(FoodDetailModel *)model;
@end
