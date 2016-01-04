//
//  RecordTableViewCell.m
//  LoveLife
//
//  Created by qianfeng on 15/12/31.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "RecordTableViewCell.h"

@implementation RecordTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}
-(void)refreshUI:(RecordModel *)model
{
    [self.publish_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.publisher_icon_url] placeholderImage:[UIImage imageNamed:@""]];
    
    [self.image_urlImageView sd_setImageWithURL:[NSURL URLWithString:model.image_urls[0][@"large"]] placeholderImage:[UIImage imageNamed:@""]];
    
    self.publicer_nameLabel.text = model.publisher_name;
    self.pub_timeLabel.text = model.pub_time;
    self.textLabel.text = model.text;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
