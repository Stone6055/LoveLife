//
//  HomeDetailViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/30.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "WXApi.h"

@interface HomeDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    UIImageView * _headerImageView;
    
    UILabel * _headerTitleLabel;
}

@property(nonatomic,strong) NSMutableDictionary * dataDic;
@property(nonatomic,strong) NSMutableArray * dataArray;

@property(nonatomic,strong) NSDictionary * goodsDictionary;

@end

@implementation HomeDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    if ([WXApi isWXAppInstalled]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getOrderResult:) name:@"success" object:nil];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self settingNav];
    [self createUI];
    [self loadData];
    
    
}

-(void)loadData
{
    
    self.dataDic = [NSMutableDictionary dictionaryWithCapacity:0];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:HOMEDETAIL,self.dataID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataDic = responseObject[@"data"];
        self.dataArray = self.dataDic[@"product"];
        [self reloadHeaderView];
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
-(void)reloadHeaderView
{
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"pic"]] placeholderImage:[UIImage imageNamed:@""]];
    _tableView.tableHeaderView = _headerImageView;
}

#pragma mark - 创建UI
-(void)createUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _headerImageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT/3) imageName:nil];
    
    _headerTitleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, _headerImageView.frame.size.height - 40, SCREEN_WIDTH, 40) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:20]];
    [_headerImageView addSubview:_headerTitleLabel];
    _tableView.tableHeaderView = _headerImageView;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * sectionArray = self.dataArray[section][@"pic"];
    return sectionArray.count;
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"detailID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailID"];
        
        UIImageView * imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 200) imageName:nil];
        imageView.tag = 10;
        
        [cell.contentView addSubview:imageView];
    }
    
    UIImageView * imageView = (id)[cell.contentView viewWithTag:10];
    if (self.dataArray) {
        NSArray * sectionArray = self.dataArray[indexPath.section][@"pic"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:sectionArray[indexPath.row][@"pic"]] placeholderImage:[UIImage imageNamed:@""]   ];
    }
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * bgView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    UILabel * indexLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, 10, 40, 40) text:[NSString stringWithFormat:@"%ld",section + 1] textColor:RGB(255, 100, 187, 1) font:[UIFont systemFontOfSize:16]];
    
    indexLabel.layer.borderColor = RGB(255, 156, 187, 1).CGColor;
    indexLabel.layer.borderWidth = 2;
    indexLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:indexLabel];
    
    UILabel * titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(indexLabel.frame.size.width + indexLabel.frame.origin.x + 10, 10, 200, 40) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:18]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleLabel];
    
    titleLabel.text = self.dataArray[section][@"title"];
    [bgView addSubview:titleLabel];
    
    UIButton * priceButton = [FactoryUI createButtonWithFrame:CGRectMake(SCREEN_WIDTH-100, 10, 90, 40) title:nil titleColor:[UIColor darkGrayColor] imageName:nil backgroundImageName:nil target:self selector:@selector(priceButtonClick)];
    [bgView addSubview:priceButton];
    
//    self.goodsDictionary = self.dataArray[@"price"];
    
    
    [priceButton setTitle:[NSString stringWithFormat:@"￥%@",self.dataArray[section][@"price"]] forState:UIControlStateNormal];
    
    return bgView;
}
-(void)priceButtonClick
{
    
    
}

-(void)getOrderResult:(NSNotification *)not
{
    if ([not.object isEqualToString:@"success"]) {
        NSLog(@"成功");
    }
    else
    {
        NSLog(@"失败");
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

#pragma mark - 设置导航
-(void)settingNav
{
    self.titleLabel.text = @"详情";
    [self.leftButton setImage:[UIImage imageNamed:@"iconfont-shangyishou"] forState:UIControlStateNormal];
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
