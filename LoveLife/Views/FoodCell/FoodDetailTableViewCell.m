//
//  FoodDetailTableViewCell.m
//  LoveLife
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 QF. All rights reserved.
//

#import "FoodDetailTableViewCell.h"


@implementation FoodDetailTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}
-(void)configUI
{
    _detailImageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, SCREEN_HIGHT/3) imageName:nil];
    [self.contentView addSubview:_detailImageView];
    
    _detailLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, 15+_detailImageView.frame.size.height, SCREEN_WIDTH, 20) text:nil textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:_detailLabel];
    
}
-(void)refreshUI:(FoodDetailModel *)model
{
    static int i = 1;
    [_detailImageView sd_setImageWithURL:[NSURL URLWithString:model.dishes_step_image] placeholderImage:nil];
    _detailLabel.text = [NSString stringWithFormat:@"%d.%@",i++,model.dishes_step_desc];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
