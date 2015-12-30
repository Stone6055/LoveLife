//
//  AppDelegate.m
//  LoveLife
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarController.h"
#import "GuidePage.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"

#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"

@interface AppDelegate ()
@property (nonatomic,strong) GuidePage * goInPageView;
@property (nonatomic,strong) MyTabBarController * myTabBar;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _myTabBar = [[MyTabBarController alloc]init];
    LeftViewController * leftVc = [[LeftViewController alloc]init];
    
    MMDrawerController * drawerVc = [[MMDrawerController alloc]initWithCenterViewController:self.myTabBar leftDrawerViewController:leftVc];
    drawerVc.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    drawerVc.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    drawerVc.maximumLeftDrawerWidth = SCREEN_WIDTH - 100;
    
    self.window.rootViewController = drawerVc;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self createGuidePage];
    [self addUMShare];
    return YES;
}
-(void)addUMShare
{
    [UMSocialData setAppKey:APPKEY];
    [UMSocialQQHandler setQQWithAppId:@"1104908293" appKey:@"MnGtpPN5AiB6MNvj" url:nil];
    
    [UMSocialWechatHandler setWXAppId:@"wx12b249bcbf753e87" appSecret:@"0a9cd00c48ee47a9b23119086bcd3b30" url:nil];
    
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    
    
//    隐藏未安装的客户端
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
}

-(void)createGuidePage
{
    if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"isRuned"]boolValue]) {
        NSArray * imageArray = @[@"LaunchImage",@"welcome1",@"welcome2"];
        
        self.goInPageView = [[GuidePage alloc]initWithFrame:self.window.bounds imageArray:imageArray];
        [self.myTabBar.view addSubview:self.goInPageView];
        
        [self.goInPageView.goInButton addTarget:self action:@selector(goInButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        [[NSUserDefaults standardUserDefaults]setObject:@YES forKey:@"isRuned"];
    }
    
}
-(void)goInButtonClick
{
    [self.goInPageView removeFromSuperview];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
