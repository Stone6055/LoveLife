//
//  LeftViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "LeftViewController.h"


@interface LeftViewController ()
{
    UIImageView * _headerImageView;
    UILabel * _nickNameLabel;
}
@end

@implementation LeftViewController

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:[user objectForKey:@"iconURL"]] placeholderImage:[UIImage imageNamed:@""]];
    _nickNameLabel.text = [user objectForKey:@"userName"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _headerImageView = [FactoryUI createImageViewWithFrame:CGRectMake((SCREEN_WIDTH-80-100)/2, 80, 80, 80) imageName:nil];
    _headerImageView.layer.cornerRadius = 40;
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_headerImageView];
    
    _nickNameLabel = [FactoryUI createLabelWithFrame:CGRectMake(0,_headerImageView.frame.size.height + _headerImageView.frame.origin.y+20, SCREEN_WIDTH-100, 30) text:nil textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
    _nickNameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_nickNameLabel];
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
