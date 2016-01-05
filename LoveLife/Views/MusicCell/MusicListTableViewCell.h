//
//  MusicListTableViewCell.h
//  LoveLife
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

@interface MusicListTableViewCell : UITableViewCell
{
    UIImageView * _imageView;
    UILabel * _authorLabel;
    UILabel * _nameLabel;
}

-(void)refreshUI:(MusicModel *)model;

@end
