//
//  FoodDetailViewController.m
//  LoveLife
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 QF. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "FoodDetailModel.h"
#import "FoodDetailTableViewCell.h"

@interface FoodDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    int _page;
}
@property(nonatomic,strong) NSMutableArray * dataSource;


@end

@implementation FoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configTableView];
    [self configHeaderView];
    [self createData];
}
-(void)configTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
}
-(void)configHeaderView
{
    
    
}
-(void)createData
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_tableView.header beginRefreshing];
    
    [_tableView registerClass:[FoodDetailTableViewCell class] forCellReuseIdentifier:@"FOODDETAILID"];
    
}
-(void)loadNewData
{
    _page = 0;
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    [self loadData];
}
-(void)loadMoreData
{
    _page++;
    [self loadData];
    
}

-(void)loadData
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSDictionary * dic = @{@"dishes_id": self.dataId, @"methodName": @"DishesView"};
    [manager POST:FOODURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray * array = responseObject[@"data"][@"step"];
        for (NSDictionary * dic in array) {
            FoodDetailModel * model  = [[FoodDetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataSource addObject:model];
        }
        
        if (_page == 0) {
            [_tableView.header endRefreshing];
        }
        else
        {
            [_tableView.footer endRefreshing];
        }
        
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (_page == 0) {
            [_tableView.header endRefreshing];
        }
        else
        {
            [_tableView.footer endRefreshing];
        }
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoodDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FOODDETAILID"];
    
    FoodDetailModel * model = _dataSource[indexPath.row];
    [cell refreshUI:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HIGHT/3+50;
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
