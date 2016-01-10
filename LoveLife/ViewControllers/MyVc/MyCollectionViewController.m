//
//  MyCollectionViewController.m
//  LoveLife
//
//  Created by qianfeng on 16/1/6.
//  Copyright (c) 2016年 QF. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "DBManager.h"
#import "ReadModel.h"
#import "ArticleCell.h"
#import "ArticleDetailViewController.h"

@interface MyCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}
@property(nonatomic,strong) NSMutableArray * dataArray;
@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self settingNav];
    [self createTableView];
    [self loadData];
    
}
-(void)loadData
{
    DBManager * manager = [DBManager defaultManager];
    NSArray * array = [manager getData];
    self.dataArray = [NSMutableArray arrayWithArray:array];
    [_tableView reloadData];
    
}

-(void)settingNav
{
    self.titleLabel.text = @"详情";
    [self.leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self setLeftButtonClick:@selector(leftButtonClick)];
    
}

-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ArticleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (self.dataArray) {
        ReadModel * model = self.dataArray[indexPath.row];
        [cell refreshUI:model];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleDetailViewController * vc = [[ArticleDetailViewController alloc]init];
    ReadModel * model = self.dataArray[indexPath.row];
    vc.readModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DBManager * manager = [DBManager defaultManager];
        ReadModel * model = self.dataArray[indexPath.row];
        [manager deleteNameFromTable:model.dataID];
        
        [self.dataArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
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
