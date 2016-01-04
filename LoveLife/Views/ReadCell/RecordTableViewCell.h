 //
//  RecordTableViewCell.h
//  LoveLife
//
//  Created by qianfeng on 15/12/31.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordModel.h"

@interface RecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *publish_iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *image_urlImageView;
@property (weak, nonatomic) IBOutlet UILabel *publicer_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pub_timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *TextLabel;
-(void)refreshUI:(RecordModel *)model;
@end
