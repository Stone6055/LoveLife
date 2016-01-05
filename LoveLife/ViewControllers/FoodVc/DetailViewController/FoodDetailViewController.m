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
    
    UIImageView * _headerImageView;
    UILabel * _headerLabel;
}
@property(nonatomic,strong) NSMutableArray * dataSource;
@property(nonatomic,copy) NSString * headerImage;
@property(nonatomic,copy) NSString * headerDishes_title;

@end

@implementation FoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configUI];
    
    [self createData];
}
-(void)configUI
{
    self.titleLabel.text = @"详情";
    [self.leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [self setLeftButtonClick:@selector(leftButtonClick)];
    [self configTableView];
    [self configHeaderView];
}

-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)configTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[FoodDetailTableViewCell class] forCellReuseIdentifier:@"FOODDETAILID"];
    
}
-(void)configHeaderView
{
    UIView * view = [FactoryUI createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT/4)];
    _headerImageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) imageName:nil];
    _headerLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, 180, SCREEN_WIDTH, 20) text:nil textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:17]];
    [_headerImageView addSubview:_headerLabel];
    [view addSubview:_headerImageView];
    _tableView.tableHeaderView = view;
    
}
-(void)createData
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [_tableView.header beginRefreshing];
}

-(void)loadData
{
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSDictionary * dic = @{@"dishes_id": self.dataId, @"methodName": @"DishesView"};
    [manager POST:FOODURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.headerImage = responseObject[@"data"][@"image"];
        self.headerDishes_title = responseObject[@"data"][@"dishes_title"];
        
        NSArray * array = responseObject[@"data"][@"step"];
        for (NSDictionary * dic in array) {
            FoodDetailModel * model = [[FoodDetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataSource addObject:model];
        }
        [self refreshHeaderData];
        [_tableView.header endRefreshing];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_tableView.header endRefreshing];
    }];
    
}
-(void)refreshHeaderData
{
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:self.headerImage] placeholderImage:nil];
    _headerLabel.text = self.headerDishes_title;
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
