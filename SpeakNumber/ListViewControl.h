//
//  ListViewControl.h
//  SpeakNumber
//
//  Created by 程嘉雯 on 15/10/30.
//  Copyright © 2015年 com.epoluodi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBmanger.h"
#import "groupcell.h"
#import "FSLineChart.h"



@interface ListViewControl : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    FSLineChart *chart;
}

@property (weak, nonatomic) IBOutlet UINavigationItem *navtitle;

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIView *viewchart;

@end
