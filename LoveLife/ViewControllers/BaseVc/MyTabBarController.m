//
//  MyTabBarController.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "MyTabBarController.h"
#import "FoodViewController.h"
#import "HomeViewController.h"
#import "MusicViewController.h"
#import "MyViewController.h"
#import "ReadViewController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createViewControllers];
    
    [self createTabBarItem];
    
}
-(void)createViewControllers
{
    HomeViewController * homeVc = [[HomeViewController alloc]init];
    UINavigationController * homeNav = [[UINavigationController alloc]initWithRootViewController:homeVc];
    
    FoodViewController * foodVc = [[FoodViewController alloc]init];
    UINavigationController * foodNav = [[UINavigationController alloc]initWithRootViewController:foodVc];
    
    MusicViewController * musicVc = [[MusicViewController alloc]init];
    UINavigationController * musicNav = [[UINavigationController alloc]initWithRootViewController:musicVc];
    
    MyViewController * myVc = [[MyViewController alloc]init];
    UINavigationController * myNav = [[UINavigationController alloc]initWithRootViewController:myVc];
    
    ReadViewController * readVc = [[ReadViewController alloc]init];
    UINavigationController * readNav = [[UINavigationController alloc]initWithRootViewController:readVc];
    
    self.viewControllers = @[homeNav,readNav,myNav,foodNav,musicNav];
    
}
-(void)createTabBarItem
{
    NSArray * unselectedImageArray = @[@"ic_tab_home_normal@2x",@"ic_tab_profile_normal_female@2x",@"ic_tab_select_normal@2x",@"iconfont-iconfontmeishi",@"iconfont-yule"];
    NSArray * selectedImageArray = @[@"ic_tab_category_selected@2x",@"ic_tab_home_selected@2x",@"ic_tab_profile_selected_female@2x",@"ic_tab_select_selected@2x",@"iconfont-iconfontmeishi-2"];
    NSArray * titleArray = @[@"首页",@"阅读",@"美食",@"音乐",@"我的"];
    
    for (int i = 0; i < self.tabBar.items.count; i++) {
        UIImage * unselectedImage = [UIImage imageNamed:unselectedImageArray[i]];
        unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage * selectedImage = [UIImage imageNamed:selectedImageArray[i]];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem * item = self.tabBar.items[i];
        item = [item initWithTitle:titleArray[i] image:unselectedImage selectedImage:selectedImage];
        
    }
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
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
