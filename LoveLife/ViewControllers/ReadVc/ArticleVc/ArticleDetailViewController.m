//
//  ArticleDetailViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/30.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "ArticleDetailViewController.h"

@interface ArticleDetailViewController ()

@end

@implementation ArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self createNav];
    [self createUI];
    
}

-(void)createUI
{
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];
//    loadHTMLString加载的是类似标签式的字符串
//    loadRequest加载的是网页
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:ARTICALDETAILURL,self.model.dataID]]]];
    
//    适配屏幕
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
//    webView 与javasript的交互
}

-(void)createNav
{
    self.titleLabel.text = @"详情页";
    [self.leftButton setImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [self setLeftButtonClick:@selector(leftButtonClick)];
    
    [self.rightButton setImage:[UIImage imageNamed:@"iconfont_share"] forState:UIControlStateNormal];
    [self setRightButtonClick:@selector(rightButtonClick)];
}

-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)rightButtonClick
{
//    从一个网址获取图片
    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.pic]]];
    [UMSocialSnsService presentSnsIconSheetView:self appKey:APPKEY shareText:[NSString stringWithFormat:ARTICALDETAILURL,self.model.dataID] shareImage:image shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline] delegate:self];
    
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
