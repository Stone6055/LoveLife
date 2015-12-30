//
//  ReadViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "ReadViewController.h"
#import "ArticleViewController.h"
#import "RecordViewController.h"



@interface ReadViewController ()<UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
    UISegmentedControl * _segmentControl;
}
@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingNav];
    [self createUI];
    
}
-(void)settingNav
{
    _segmentControl = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 100, 25)];
    [_segmentControl insertSegmentWithTitle:@"读美文" atIndex:0 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"看语录" atIndex:1 animated:YES];
    _segmentControl.tintColor = [UIColor whiteColor];
    [_segmentControl setSelectedSegmentIndex:0];
    
    [_segmentControl addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = _segmentControl;
}
-(void)changeAction:(UISegmentedControl *)segment
{
    
    _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*segment.selectedSegmentIndex, 0);
}

-(void)createUI
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, 0);
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    
    ArticleViewController * articleVc = [[ArticleViewController alloc]init];
    RecordViewController * recordVc = [[RecordViewController alloc]init];
    NSArray * vcArray = @[articleVc,recordVc];
    
    int i = 0;
    for (UIViewController * vc in vcArray) {
        vc.view.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HIGHT);
        [self addChildViewController:vc];
        [_scrollView addSubview:vc.view];
        i++;
    }
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _segmentControl.selectedSegmentIndex = scrollView.contentOffset.x/SCREEN_WIDTH;
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
