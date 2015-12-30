//
//  ArticleCell.h
//  LoveLife
//
//  Created by qianfeng on 15/12/30.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadModel.h"

@interface ArticleCell : UITableViewCell
{
    UIImageView * _imageView;
    UILabel * _timeLabel;
    UILabel * _authorLabel;
    UILabel * _titleLabe;
}

-(void)refreshUI:(ReadModel *)model;
@end
