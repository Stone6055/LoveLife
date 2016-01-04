//
//  RecordViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/30.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordModel.h"
#import "RecordTableViewCell.h"

@interface RecordViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    int _page;
}
@property(nonatomic,strong) NSMutableArray * dataSource;

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
    [self refreshData];
}
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-30) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"RecordTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RECORDCELL"];
}
-(void)refreshData
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    [_tableView.header beginRefreshing];
    
}
-(void)loadNewData
{
    _page = 0;
    _dataSource = [NSMutableArray arrayWithCapacity:0];
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
    [manager GET:[NSString stringWithFormat:UTTERANCEURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray * array = responseObject[@"content"];
        for (NSDictionary * dic in array) {
            RecordModel * model = [[RecordModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataSource addObject:model];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource?self.dataSource.count:0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RECORDCELL"];
    RecordModel * model = self.dataSource[indexPath.row];
    [cell refreshUI:model];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400;
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
