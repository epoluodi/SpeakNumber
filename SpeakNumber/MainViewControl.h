//
//  MainViewControl.h
//  SpeakNumber
//
//  Created by 程嘉雯 on 15/10/30.
//  Copyright © 2015年 com.epoluodi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Common/PublicCommon.h>
#import "DBmanger.h"

@interface MainViewControl : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIBarButtonItem *leftbtn;
    UIBarButtonItem *rightbtn;
    NSArray *configgroup;
    DBmanger *db;
    UIFont *font;
    CATextLayer *numberlayer;
}
@property (weak, nonatomic) IBOutlet UINavigationItem *navtitle;
@property (weak, nonatomic) IBOutlet UIView *numberview;

@property (weak, nonatomic) IBOutlet UIImageView *numberimg;

@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end
