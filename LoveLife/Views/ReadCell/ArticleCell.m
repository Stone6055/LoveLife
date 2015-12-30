//
//  ArticleCell.m
//  LoveLife
//
//  Created by qianfeng on 15/12/30.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "ArticleCell.h"

@implementation ArticleCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 120, 90) imageName:nil];
    [self.contentView addSubview:_imageView];
    
    _timeLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _imageView.frame.size.height + _imageView.frame.origin.x, 120, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:12]];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_timeLabel];
    
    _authorLabel = [FactoryUI createLabelWithFrame:CGRectMake(SCREEN_WIDTH-120, _timeLabel.frame.origin.y, 110, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:14]];
    _authorLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_authorLabel];
    
    _titleLabe = [FactoryUI createLabelWithFrame:CGRectMake(_imageView.frame.origin.x + _imageView.frame.size.width+10, 30, 200, 40) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:16]];
    _titleLabe.numberOfLines = 0;
    _titleLabe.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:_titleLabe];
    
    
}
-(void)refreshUI:(ReadModel *)model
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabe.text = model.title;
    _authorLabel.text = model.author;
    _timeLabel.text = model.createtime;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
