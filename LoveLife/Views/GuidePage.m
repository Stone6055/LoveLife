//
//  GuidePage.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "GuidePage.h"

@implementation GuidePage
{
    UIScrollView * _scrollView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray
{
    if (self = [super initWithFrame:frame]) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT+64)];
        
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(imageArray.count*SCREEN_WIDTH, SCREEN_HIGHT+64);
        
        [self addSubview:_scrollView];
        
        for (int i = 0; i < imageArray.count; i++) {
            UIImageView * imageView = [FactoryUI createImageViewWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HIGHT+64) imageName:imageArray[i]];
            imageView.userInteractionEnabled = YES;
            [_scrollView addSubview:imageView];
            if (i == imageArray.count - 1) {
                self.goInButton = [UIButton buttonWithType:UIButtonTypeCustom];
                self.goInButton.frame = CGRectMake(100, 100, 50, 50);
                [self.goInButton setImage:[UIImage imageNamed:@"LinkedIn"] forState:UIControlStateNormal];
                
                
                [imageView addSubview:self.goInButton];
            }
        }
    }
    return self;
}

@end
