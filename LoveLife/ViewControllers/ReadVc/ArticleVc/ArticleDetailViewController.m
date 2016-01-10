//
//  ArticleDetailViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/30.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import "DBManager.h"

@interface ArticleDetailViewController ()

@end

@implementation ArticleDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    DBManager * manager = [DBManager defaultManager];
    if ([manager isHasDataIDFromTable:self.readModel.dataID]) {
//        UIButton * button = 
    }
}


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
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:ARTICALDETAILURL,self.readModel.dataID]]]];
    
//    适配屏幕
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
//    webView 与javasript的交互
    
    UIButton * collectionButton = [FactoryUI createButtonWithFrame:CGRectMake(SCREEN_WIDTH-50, 0, 50, 30) title:@"收藏" titleColor:[UIColor blackColor] imageName:nil backgroundImageName:nil target:self selector:@selector(collectionButtonClick:)];
    [collectionButton setTitle:@"已收藏" forState:UIControlStateSelected];
    [self.view addSubview:collectionButton];
    
    
}

-(void)collectionButtonClick:(UIButton *)button
{
    button.selected = YES;
    DBManager * manager = [DBManager defaultManager];
    
    
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请不要重复收藏" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    [manager insertDataModel:self.readModel];
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
    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.readModel.pic]]];
    [UMSocialSnsService presentSnsIconSheetView:self appKey:APPKEY shareText:[NSString stringWithFormat:ARTICALDETAILURL,self.readModel.dataID] shareImage:image shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline] delegate:self];
    
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
