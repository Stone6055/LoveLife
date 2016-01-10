//
//  AboutMeViewController.m
//  LoveLife
//
//  Created by qianfeng on 16/1/5.
//  Copyright (c) 2016年 QF. All rights reserved.
//

#import "AboutMeViewController.h"
#import "QRCodeGenerator.h"

@interface AboutMeViewController ()

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.image = [QRCodeGenerator qrImageForString:@"www.baidu.com" imageSize:300];
    [self.view addSubview:imageView];
    
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
