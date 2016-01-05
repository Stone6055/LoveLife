//
//  MusciDetailViewController.m
//  LoveLife
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 QF. All rights reserved.
//

#import "MusciDetailViewController.h"
#import "MBProgressHUD.h"
#import "MusicModel.h"
#import "MusicListTableViewCell.h"
#import "MusicPlayViewController.h"

@interface MusciDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    int _page;
}
@property(nonatomic,strong) NSMutableArray  * dataArray;
@property(nonatomic,strong) MBProgressHUD * hud;
@property(nonatomic,strong) NSMutableArray * urlArray;
@end

@implementation MusciDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _page = 0;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.urlArray = [NSMutableArray arrayWithCapacity:0];
    
    [self loadData];
    [self settingNav];
    [self createTableView];
    [self createRefresh];
    
}

-(void)createRefresh
{
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}
-(void)loadMoreData
{
    _page++;
    [self loadData];
}
-(void)loadData
{
    [self.hud show:YES];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    [manager GET:self.urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray * array = responseObject[@"data"];
        for (NSDictionary * dic in array) {
            
            [self.urlArray addObject:dic[@"url"]];
            
            MusicModel * model = [[MusicModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        
        [_tableView.footer endRefreshing];
        [self.hud hide:YES];
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_tableView.footer endRefreshing];
        [self.hud hide:YES];
    }];
    
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    self.hud.labelText = @"正在加载……";
    self.hud.labelFont = [UIFont systemFontOfSize:14];
    self.hud.labelColor = [UIColor whiteColor];
    self.hud.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    self.hud.activityIndicatorColor = [UIColor whiteColor];
    [self.view addSubview:self.hud];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MusicListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    MusicModel * model = self.dataArray[indexPath.row];
    [cell refreshUI:model];
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AAA"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AAA"];
//    }
//    cell.textLabel.text = @"AAAA";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicPlayViewController * vc = [[MusicPlayViewController alloc]init];
    MusicModel * model = self.dataArray[indexPath.row];
    vc.model = model;
    vc.currentIndex = (int)indexPath.row;
    vc.urlArray = self.urlArray;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)settingNav
{
    self.titleLabel.text = self.typeString;
    [self.leftButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self setLeftButtonClick:@selector(leftButtonClick)];
    
}
-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
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
