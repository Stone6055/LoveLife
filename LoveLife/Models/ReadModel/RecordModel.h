//
//  RecordModel.h
//  LoveLife
//
//  Created by qianfeng on 15/12/31.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordModel : NSObject
@property(nonatomic,copy) NSArray * image_urls;
@property(nonatomic,copy) NSString * dataID;
@property(nonatomic,copy) NSString * publisher_name;
@property(nonatomic,copy) NSString * text;
@property(nonatomic,copy) NSString * publisher_icon_url;
@property(nonatomic,copy) NSString * pub_time;

@end
