//
//  MusicPlayViewController.h
//  LoveLife
//
//  Created by qianfeng on 16/1/5.
//  Copyright (c) 2016年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

@interface MusicPlayViewController : UIViewController
@property(nonatomic,strong) MusicModel * model;
@property(nonatomic,strong) NSArray * urlArray;
@property(nonatomic,assign) int currentIndex;
@end
