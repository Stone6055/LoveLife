//
//  MusicPlayViewController.m
//  LoveLife
//
//  Created by qianfeng on 16/1/5.
//  Copyright (c) 2016年 QF. All rights reserved.
//

#import "MusicPlayViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MusicPlayViewController ()<AVAudioPlayerDelegate>
{
    UISlider * _slider;
    
    AVAudioPlayer * _player;
    
    
}
@property(nonatomic,strong) NSTimer * timer;
@end

@implementation MusicPlayViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"9d0e342016849ce3e35ea6062f3ecb1a.jpeg"]];
    
    [self createUI];
    
    //1.创建队列组
    dispatch_group_t group = dispatch_group_create();
    //2.创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //3.多次使用队列组的方法执行任务, 只有异步方法
    dispatch_group_async(group, queue, ^{
        [self createAVAudioPlayer];
    });
    
    
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(sliderValueChange) userInfo:nil repeats:YES];
    
    AVAudioSession * session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    [session setActive:YES error:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(isHasDevice:) name:AVAudioSessionRouteChangeNotification object:nil];
    
}

-(void)isHasDevice:(NSNotification *)notification
{
    NSDictionary *dic=notification.userInfo;
    int changeReason= [dic[AVAudioSessionRouteChangeReasonKey] intValue];
    if (changeReason==AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        AVAudioSessionRouteDescription *routeDescription=dic[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription= [routeDescription.outputs firstObject];
        //原设备为耳机则暂停
        if ([portDescription.portType isEqualToString:@"Headphones"]) {
            if ([_player isPlaying])
            {
                [_player pause];
                self.timer.fireDate=[NSDate distantFuture];
            }
        }
    }
}

-(void)createAVAudioPlayer
{
//    播放本地
    
//    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:@""] error:nil];
    
    _player = [[AVAudioPlayer alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlArray[_currentIndex]]] error:nil];
    _player.delegate = self;
    _player.volume = 0.5;
    _player.currentTime = 0;
    _player.numberOfLoops = -1;
//    _player.isPlaying
//    _player.duration
    [_player prepareToPlay];
}

-(void)createUI
{
    UIButton * backButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 20, 50, 30) title:@"返回" titleColor:[UIColor blackColor] imageName:nil backgroundImageName:nil target:self selector:@selector(backButtonClick)];
    [self.view addSubview:backButton];
    
    UILabel * titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 30, 200, 30) text:self.model.title textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:17]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UIImageView * imageView = [FactoryUI createImageViewWithFrame:CGRectMake(30, 70, SCREEN_WIDTH-60, SCREEN_HIGHT/2) imageName:nil];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.coverURL] placeholderImage:[UIImage imageNamed:@""]];
    [self.view addSubview:imageView];
    
    UILabel * authorLabel = [FactoryUI createLabelWithFrame:CGRectMake(SCREEN_WIDTH-70, 200, 100, 50) text:nil textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
    [self.view addSubview:authorLabel];
    
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(10, imageView.frame.origin.y+imageView.frame.size.height+80, SCREEN_WIDTH-20, 20)];
    _slider.value = 0.0;
    [_slider addTarget:self action:@selector(changeOption:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    
    NSArray * buttonImageArray = @[@"iconfont-bofangqishangyiqu",@"iconfont-musicbofang",@"iconfont-bofangqixiayiqu"];
    for (int i = 0; i < buttonImageArray.count; i++) {
        UIButton * button = [FactoryUI createButtonWithFrame:CGRectMake(100+i*60, _slider.frame.size.height + _slider.frame.origin.y+30, 60, 30) title:nil titleColor:nil imageName:buttonImageArray[i] backgroundImageName:nil target:self selector:@selector(playButtonClick:)];
        button.tag = 10+i;
        [self.view addSubview:button];
    }
}

-(void)playButtonClick:(UIButton *)button
{
    switch (button.tag - 10) {
        case 0:
        {
            [_player stop];
            if (_currentIndex == 0) {
                _currentIndex = (int)self.urlArray.count - 1;
            }
            _currentIndex--;
            [self createAVAudioPlayer];
            [_player play];
        }
            break;
        case 1:
        {
            if (_player.isPlaying) {
                [button setImage:[UIImage imageNamed:@"iconfont-musicbofang"] forState:UIControlStateNormal];
                [_player pause];
                [self.timer setFireDate:[NSDate distantFuture]];
            }
            else
            {
                [button setImage:[UIImage imageNamed:@"iconfont-zanting"] forState:UIControlStateNormal];
                [_player pause];
                [self.timer setFireDate:[NSDate distantPast]];
//                [self.timer invalidate];销毁定时器，以后就无法恢复了
            }
        }
            break;
        case 2:
        {
            [_player stop];
            if (_currentIndex == self.urlArray.count-1) {
                _currentIndex = 0;
            }
            _currentIndex++;
            [self createAVAudioPlayer];
            [_player play];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)sliderValueChange
{
    _slider.value = _player.currentTime/_player.duration;
}


-(void)changeOption:(UISlider *)slider
{
    _player.currentTime = _player.duration * slider.value;
    
}

-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) {
//        正常播放完毕
        
    }
    else
    {
//        播放结束，但解码有问题
        
        
    }
}

//被中断时
-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    [_player pause];
}

//中断结束
-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
    [_player play];
}
-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
//    解码错误时调用
    
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
