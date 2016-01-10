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
#import "MyCollectionViewController.h"
#import "LoginViewController.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
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
    
    self.logeArray = @[@"iconfont-iconfontaixinyizhan",@"iconfont-lajitong",@"iconfont-yejianmoshi",@"iconfont-zhengguiicon40",@"iconfont-guanyu"];
    self.titleArray = @[@"我的收藏",@"清理缓存",@"夜间模式",@"推送消息",@"关于"];
    _darkView = [[UIView alloc]initWithFrame:self.view.frame];
    
    [self settingNav];
    [self createUI];
}

-(void)settingNav
{
    self.titleLabel.text = @"我的";
    
    [self.rightButton setTitle:@"登陆" forState:UIControlStateNormal];
    
    [self setRightButtonClick:@selector(rightButtonClick)];
}

-(void)rightButtonClick
{
    LoginViewController * vc = [[LoginViewController alloc]init];
//    self.navigationItem
    [self.navigationController pushViewController:vc animated:YES];
    
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
        
        if (swit.on) {
            [self createLocalNotification];
        }
        else
        {
            [self cancleLocalNotification];
        }
        
        
    }
    
}
-(void)createLocalNotification
{
//    iOS8以后无法接受推送消息
    float systemVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (systemVersion >= 8.0) {
        UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        UIUserNotificationSettings * settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        
        [[UIApplication sharedApplication]registerUserNotificationSettings:settings];
        
    }
    
    
    
    UILocalNotification * localNotification = [[UILocalNotification alloc]init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:30];
    localNotification.repeatInterval = NSCalendarUnitDay;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = @"你好啊";
    localNotification.soundName = @"";
    
    localNotification.applicationIconBadgeNumber = 10;
    
    [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
    
}

-(void)cancleLocalNotification
{
//    取消全部推送
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    
    NSArray * array = [[UIApplication sharedApplication]scheduledLocalNotifications];
    for (UILocalNotification * noti in array) {
        if ([noti.alertBody isEqualToString:@"你好啊"]) {
            [[UIApplication sharedApplication]cancelLocalNotification:noti];
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            MyCollectionViewController * collectionVc = [[MyCollectionViewController alloc]init];
            [self.navigationController pushViewController:collectionVc animated:YES];
        }
            break;
        case 1:
        {
            [self folderSizeWithPath:[self getPath]];
        }
            break;
        case 4:
        {
            AboutMeViewController * vc = [[AboutMeViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
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

#pragma mark - 清理缓存


-(NSString *)getPath
{
//
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    return path;
}

-(CGFloat)folderSizeWithPath:(NSString *)path
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    CGFloat folderSize = 0.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray * fileArray = [fileManager subpathsAtPath:path];
        for (NSString * fileName in fileArray) {
            NSString * subFile = [path stringByAppendingPathComponent:fileName];
            long fileSize = [fileManager attributesOfItemAtPath:subFile error:nil].fileSize;
            folderSize += fileSize/1024.0/1024.0;
            return folderSize;
        }
        [self showTipView:folderSize];
        return 0;
    }
    else
    {
        return 0;
    }
}
-(void)showTipView:(CGFloat)folderSize
{
    if (folderSize > 0.01) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"缓存文件有%fM，是否要清除",folderSize] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    else{
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"缓存已清理" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self cleaderCacheFileWithPath:[self getPath]];
    }
}
-(void)cleaderCacheFileWithPath:(NSString *)path
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        NSArray * subFile = [fileManager subpathsAtPath:path];
        for (NSString * fileName in subFile)
        {
            //如有需要，可以过滤掉不想删除的文件
            if ([fileName hasSuffix:@".mp4"])
            {
                NSLog(@"不删除");
            }
            else
            {
                NSString * absolutePath = [path stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:absolutePath error:nil];
            }
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
