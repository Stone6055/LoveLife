//
//  HomeViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "HomeViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "CustomViewController.h"

#import "Carousel.h"
#import "Model.h"
#import "HomeCell.h"

#import "HomeDetailViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    Carousel * _cyclePlaying;
    UITableView * _tableView;
    int _page;
}
@property (nonatomic,strong) NSMutableArray * dataSource;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self settingNav];
    [self createTableHeaderView];
    [self createTableView];
    [self createRefresh];
    
}
-(void)createRefresh
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_tableView.header beginRefreshing];
}
-(void)loadNewData
{
    _page = 1;
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    [self getData];
    
}
-(void)loadMoreData
{
    _page++;
    [self getData];
    
}
-(void)getData
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:HOMEURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary * dic in responseObject[@"data"][@"topic"]) {
            Model * model = [[Model alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataSource addObject:model];
        }
        
        if (_page == 1) {
            [_tableView.header endRefreshing];
        }
        else
        {
            [_tableView.footer endRefreshing];
        }
        
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (_page == 1) {
            [_tableView.header endRefreshing];
        }
        else
        {
            [_tableView.footer endRefreshing];
        }
    }];
    
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.tableHeaderView = _cyclePlaying;
//    _tableView.separatorColor = [UIColor whiteColor];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    _tableView.tableFooterView = [[UIView alloc]init];
    
}
#pragma mark - lunbo
- (void)createTableHeaderView
{
    _cyclePlaying = [[Carousel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT/3)];
    _cyclePlaying.needPageControl = YES;
    _cyclePlaying.infiniteLoop = YES;
    _cyclePlaying.pageControlPositionType = PAGE_CONTROL_POSITION_TYPE_MIDDLE;
    _cyclePlaying.imageArray = @[@"shili0",@"shili10",@"shili2",@"shili8"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[HomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.dataSource) {
        Model * model = self.dataSource[indexPath.row];
        [cell refreshUI:model];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDetailViewController * vc = [[HomeDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    
    Model * model = self.dataSource[indexPath.row];
    vc.dataID = model.dataID;
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 设置导航
-(void)settingNav
{
    self.titleLabel.text = @"爱你";
    [self.leftButton setImage:[UIImage imageNamed:@"icon_function"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"2vm"] forState:UIControlStateNormal];
    
    [self setLeftButtonClick:@selector(leftButtonClick)];
    [self setRightButtonClick:@selector(rightButtonClick)];
}

-(void)leftButtonClick
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}
-(void)rightButtonClick
{
    CustomViewController * customVc = [[CustomViewController alloc]initWithIsQRCode:NO Block:^(NSString *result, BOOL isSuccess) {
        if (isSuccess) {
            NSLog(@"%@",result);
        }
    }];
    [self presentViewController:customVc animated:YES completion:nil];
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
