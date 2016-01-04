//
//  FoodViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "FoodViewController.h"
#import "NBWaterFlowLayout.h"
#import "FoodCell.h"
#import "FoodTitleCell.h"
#import "FoodModel.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "FoodDetailViewController.h"

@interface FoodViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateWaterFlowLayout>
{
    UICollectionView * _collectionView;
    
    NSString * _categoryID;
    
    NSString * _titleString;
    
    UIView * _lineView;
    
    int _page;
}
@property (nonatomic,strong)NSMutableArray * dataSource;
@property (nonatomic,strong)NSMutableArray * buttonArray;

@end

@implementation FoodViewController

-(void)viewWillAppear:(BOOL)animated
{
    for (UIButton * button in self.buttonArray) {
        if (button == [self.buttonArray firstObject]) {
            button.selected = YES;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self settingNav];
    [self createHeaderView];
    [self createCollectionView];
    [self createRefresh];
}

-(void)createRefresh
{
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _collectionView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_collectionView.header beginRefreshing];
    
}
-(void)loadNewData
{
    _page = 0;
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
    NSDictionary * dic = @{@"methodName": @"HomeSerial", @"page": [NSString stringWithFormat:@"%d",_page], @"serial_id": _categoryID, @"size": @"20"};
    [manager POST:FOODURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"code"]intValue] == 0) {
            for (NSDictionary * dic in responseObject[@"data"][@"data"]) {
                FoodModel * model = [[FoodModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataSource addObject:model];
            }
        }
        if (_page == 0) {
            [_collectionView.header endRefreshing];
        }else
        {
            [_collectionView.footer endRefreshing];
        }
        [_collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (_page == 0) {
            [_collectionView.header endRefreshing];
        }else
        {
            [_collectionView.footer endRefreshing];
        }
    }];
    
}

-(void)createCollectionView
{
    NBWaterFlowLayout * flowLayOut = [[NBWaterFlowLayout alloc]init];
    flowLayOut.itemSize = CGSizeMake((SCREEN_WIDTH-20)/2, 150);
    
    flowLayOut.numberOfColumns = 2;
    
    flowLayOut.delegate = self;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HIGHT-45) collectionViewLayout:flowLayOut];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[FoodCell class] forCellWithReuseIdentifier:@"FOOD"];
    [_collectionView registerClass:[FoodTitleCell class] forCellWithReuseIdentifier:@"FOODTITLE"];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource ? self.dataSource.count + 1 : 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        FoodTitleCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FOODTITLE" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
        cell.titleLabel.text = _titleString;
        return cell;
    }
    else
    {
        FoodCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FOOD" forIndexPath:indexPath];
        [cell.playButton addTarget:self action:@selector(playButton:) forControlEvents:UIControlEventTouchUpInside];
        if (self.dataSource) {
            FoodModel * model = self.dataSource[indexPath.row-1];
            [cell refreshUI:model];
        }
        
        return cell;
    }
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView waterFlowLayout:(NBWaterFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 30;
    }
    else
    {
        return 160;
    }
}

-(void)playButton:(UIButton *)button
{
    
    
}

-(void)play:(FoodModel *)model
{
    MPMoviePlayerViewController * playerVc = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:model.video]];
    [playerVc.moviePlayer prepareToPlay];
    [playerVc.moviePlayer play];
    [self presentViewController:playerVc animated:YES completion:nil];
//    AVPlayerViewController * playerVc = [[AVPlayerViewController alloc]init];
//    AVPlayer * avPlayer = [AVPlayer playerWithURL:[NSURL URLWithString:model.video]];
//    playerVc.player = avPlayer;
//    [self presentViewController:playerVc animated:YES completion:nil];
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FoodDetailViewController * detailVc = [[FoodDetailViewController alloc]init];
    FoodModel * model = self.dataSource[indexPath.row];
    detailVc.dataId = model.dishes_id;
    [self.navigationController pushViewController:detailVc animated:YES];
    
}



-(void)initData
{
    _categoryID = @"1";
    _titleString = @"家常菜";
    self.buttonArray = [NSMutableArray arrayWithCapacity:0];
    
}

-(void)settingNav
{
    self.titleLabel.text = @"美食";
    
    
}
#pragma mark - 头部分类按钮
-(void)createHeaderView
{
    NSArray * titleArray = @[@"家常菜",@"小炒",@"凉皮",@"烘培"];
    UIView * bgView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    bgView.backgroundColor = RGB(231, 215, 150, 1);
    [self.view addSubview:bgView];
    
    for (int i = 0; i < titleArray.count; i++) {
        UIButton * headerButton = [FactoryUI createButtonWithFrame:CGRectMake(i*SCREEN_WIDTH/4, 0, SCREEN_WIDTH/4, 40) title:titleArray[i] titleColor:[UIColor darkGrayColor] imageName:nil backgroundImageName:nil target:self selector:@selector(headerBttonClick:)];
        [headerButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        headerButton.titleLabel.font = [UIFont systemFontOfSize:15];
        headerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        headerButton.tag = 10 + i;
        [bgView addSubview:headerButton];
        
        [self.buttonArray addObject:headerButton];
        
    }
    
    _lineView = [FactoryUI createViewWithFrame:CGRectMake(0, 38, SCREEN_WIDTH/4, 2)];
    _lineView.backgroundColor = [UIColor redColor];
    [bgView addSubview:_lineView];
    
}

-(void)headerBttonClick:(UIButton *)button
{
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.frame = CGRectMake((button.tag - 10)*SCREEN_WIDTH/4, 38, SCREEN_WIDTH/4, 2);
    }];
    
    for (UIButton * button in self.buttonArray) {
        if (button.selected == YES) {
            button.selected = NO;
        }
    }
    button.selected = YES;
    
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
