//
//  HomeCell.h
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface HomeCell : UITableViewCell
{
    UIImageView * _imageView;
    UILabel * _titleLabel;
}


-(void)refreshUI:(Model *)model;

@end
