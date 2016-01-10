//
//  ArticleDetailViewController.h
//  LoveLife
//
//  Created by qianfeng on 15/12/30.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "RootViewController.h"
#import "ReadModel.h"

@interface ArticleDetailViewController : RootViewController
//@property(nonatomic,copy) NSString * dataID;
@property(nonatomic,strong) ReadModel * readModel;
@end
