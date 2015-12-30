//
//  RootViewController.h
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

@property (nonatomic,strong) UIButton * leftButton;
@property (nonatomic,strong) UIButton * rightButton;
@property (nonatomic,strong) UILabel * titleLabel;
-(void)setLeftButtonClick:(SEL)selector;
-(void)setRightButtonClick:(SEL)selector;
@end
