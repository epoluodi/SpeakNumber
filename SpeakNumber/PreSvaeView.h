//
//  PreSvaeView.h
//  SpeakNumber
//
//  Created by 程嘉雯 on 15/11/4.
//  Copyright © 2015年 com.epoluodi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreSvaeView : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIBarButtonItem *rightbtn;
}
@property (weak, nonatomic) IBOutlet UINavigationItem *navtitle;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
