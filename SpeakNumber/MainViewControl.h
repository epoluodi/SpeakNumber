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
#import "setting.h"
#import "PlaySpeak.h"
#import "LineProgressView.h"
#import "ASValueTrackingSlider.h"



@interface MainViewControl : UIViewController<UITableViewDataSource,UITableViewDelegate,sounddelegate,ASValueTrackingSliderDataSource>
{
    UIBarButtonItem *leftbtn;
    UIBarButtonItem *rightbtn;
    NSArray *configgroup;
    DBmanger *db;
    UIFont *font;
    CATextLayer *numberlayer;
    CATextLayer *countslayer;
    CATextLayer *groupslayer;
    
    settingConfig *config_now;
    __block UILabel *celllabel;
    PlaySpeak *playsound;
    
    CAShapeLayer *shapelayer;
    float runfloat,stepfloat,stepfloatrest;
    int _groups,_counts;
    __block BOOL rest;
    BOOL isnormal;
    LineProgressView *lineprogressview;
    ASValueTrackingSlider *slider1;
    UILabel *txttitle1;
}
@property (weak, nonatomic) IBOutlet UINavigationItem *navtitle;
@property (weak, nonatomic) IBOutlet UIView *numberview;

@property (weak, nonatomic) IBOutlet UIImageView *numberimg;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UIButton *btnstop;
@property (weak, nonatomic) IBOutlet UIButton *btnplay;
@property (weak, nonatomic) IBOutlet UIButton *btnpause;
@property (weak, nonatomic) IBOutlet UISegmentedControl *switchbar;



-(IBAction)clickplay:(id)sender;
-(IBAction)clickpause:(id)sender;
-(IBAction)clickstop:(id)sender;

@end
