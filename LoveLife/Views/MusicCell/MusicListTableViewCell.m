//
//  MusicListTableViewCell.m
//  LoveLife
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 QF. All rights reserved.
//

#import "MusicListTableViewCell.h"


@implementation MusicListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 5, 100, 70) imageName:nil];
    [self.contentView addSubview:_imageView];
    
    _nameLabel = [FactoryUI createLabelWithFrame:CGRectMake(_imageView.frame.size.width+10, 20, 150, 30) text:nil textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:17]];
    [self.contentView addSubview:_nameLabel];
    
    _authorLabel = [FactoryUI createLabelWithFrame:CGRectMake(_imageView.frame.size.width+10, 50, 150, 30) text:nil textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:_authorLabel];
    
    
    
}
-(void)refreshUI:(MusicModel *)model
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.coverURL] placeholderImage:nil];
    _nameLabel.text = model.title;
    _authorLabel.text = model.artist;
    
}

- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
