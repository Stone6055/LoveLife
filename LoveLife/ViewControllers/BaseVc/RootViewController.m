//
//  RootViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createRootNav];
    
}
-(void)createRootNav
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = RGB(98, 172, 215, 1);
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(0, 0, 44, 44);
    [self.leftButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftButton];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 25)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView = self.titleLabel;
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(0, 0, 44, 44);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    
    
}

-(void)setLeftButtonClick:(SEL)selector
{
    [self.leftButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}

-(void)setRightButtonClick:(SEL)selector
{
    [self.rightButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
