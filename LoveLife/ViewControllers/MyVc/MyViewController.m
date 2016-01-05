//
//  MyViewController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "MyViewController.h"
#import "AppDelegate.h"
#import "AboutMeViewController.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    UIImageView * _headerImageView;
    UIView * _darkView;
}
@property(nonatomic,strong) NSArray * logeArray;
@property(nonatomic,strong) NSArray * titleArray;


@end

@implementation MyViewController

static float ImageOriginHeight = 200;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.logeArray = @[@"iconfont-guanyu",@"iconfont-iconfontaixinyizhan",@"iconfont-lajitong",@"iconfont-yejianmoshi",@"iconfont-zhengguiicon40"];
    self.titleArray = @[@"我的收藏",@"清理缓存",@"推送消息",@"夜间模式",@"关于"];
    _darkView = [[UIView alloc]initWithFrame:self.view.frame];
    
    [self settingNav];
    [self createUI];
}

-(void)settingNav
{
    self.titleLabel.text = @"我的";
    
}

-(void)createUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]init];
    
    _headerImageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, -ImageOriginHeight, SCREEN_WIDTH, ImageOriginHeight) imageName:@"welcome1"];
    [_tableView addSubview:_headerImageView];
    
    _tableView.contentInset = UIEdgeInsetsMake(ImageOriginHeight, 0, 0, 0);
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 4) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 2||indexPath.row == 3) {
            UISwitch * swit = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 5, 50, 30)];
            swit.onTintColor = [UIColor greenColor];
            swit.tag = indexPath.row;
            [swit addTarget:self action:@selector(changeOption:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:swit];
        }
        
        
    }
    
    cell.imageView.image = [UIImage imageNamed:self.logeArray[indexPath.row]];
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    return cell;
}
-(void)changeOption:(UISwitch *)swit
{
    if (swit.tag == 2) {
        if (swit.on) {
            UIApplication * app = [UIApplication sharedApplication];
            AppDelegate * delegate = app.delegate;
            _darkView.backgroundColor = [UIColor blackColor];
            _darkView.alpha = 0.2;
            _darkView.userInteractionEnabled = NO;
            [delegate.window addSubview:_darkView];
        }else
        {
            [_darkView removeFromSuperview];
        }
    }
    else
    {
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        AboutMeViewController * vc = [[AboutMeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _tableView) {
        //获取scrollview的偏移量
        CGFloat yOffSet = scrollView.contentOffset.y;
        CGFloat xOffSet = (yOffSet+ImageOriginHeight)/2;
        
        if (yOffSet<-ImageOriginHeight) {
            CGRect rect = _headerImageView.frame;
            rect.origin.y = yOffSet;
            rect.size.height = -yOffSet;
            rect.origin.x = xOffSet;
            rect.size.width = SCREEN_WIDTH + fabs(xOffSet)*2;
            _headerImageView.frame = rect;
            
        }
        
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
