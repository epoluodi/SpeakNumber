//
//  SettingViewControl.h
//  SpeakNumber
//
//  Created by 程嘉雯 on 15/10/30.
//  Copyright © 2015年 com.epoluodi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Common/PublicCommon.h>
#import "ASValueTrackingSlider.h"
#import "setting.h"
#import "AppDelegate.h"
#import "DBmanger.h"

@interface SettingViewControl : UIViewController<UITableViewDataSource,UITableViewDelegate,ASValueTrackingSliderDataSource>
{

    UIBarButtonItem *rightbtn;
    ASValueTrackingSlider *slider1;
    UILabel *txttitle1;
    ASValueTrackingSlider *slider2;
    UILabel *txttitle2;
    ASValueTrackingSlider *slider3;
    UILabel *txttitle3;
    ASValueTrackingSlider *slider4;
    UILabel *txttitle4;
    NSNumberFormatter *numberformat;
    settingConfig *nowsettingconfig;
    
    AppDelegate *app;
}

@property (weak, nonatomic) IBOutlet UINavigationItem *navtitle;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end
