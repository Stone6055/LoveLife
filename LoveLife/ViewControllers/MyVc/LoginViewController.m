//
//  LoginViewController.m
//  LoveLife
//
//  Created by qianfeng on 16/1/6.
//  Copyright (c) 2016年 QF. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    
}

-(void)createUI
{
    NSArray * array = @[@"sina",@"qq",@"weixin.jpg"];
    for (int i = 0; i < array.count; i++) {
        UIButton * button = [FactoryUI createButtonWithFrame:CGRectMake(i*SCREEN_WIDTH/3,200, 50, 50) title:nil titleColor:nil imageName:array[i] backgroundImageName:nil target:self selector:@selector(logoButtonClick:)];
        button.tag = 20 + i;
        [self.view addSubview:button];
    }
    
}

-(void)logoButtonClick:(UIButton *)button
{
    switch (button.tag - 20) {
        case 0:
        {
            UMSocialSnsPlatform * platform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
            platform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                    
//                    NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                    
//                    [self saveData:]
                    
                    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                    [user setObject:snsAccount.userName forKey:@"userName"];
                    
                    [user setObject:snsAccount.userName forKey:@"iconURL"];
                    
                    [user setObject:snsAccount.userName forKey:@"uid"];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                    [user synchronize];
                }});

        }
            break;
        case 1:
        {
            UMSocialSnsPlatform * platform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
            platform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                    
                    //                    NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                    
                    //                    [self saveData:]
                    
                    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                    [user setObject:snsAccount.userName forKey:@"userName"];
                    
                    [user setObject:snsAccount.userName forKey:@"iconURL"];
                    
                    [user setObject:snsAccount.userName forKey:@"uid"];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                    [user synchronize];
                }});

        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
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
