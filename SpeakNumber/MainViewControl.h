//
//  MainViewControl.h
//  SpeakNumber
//
//  Created by 程嘉雯 on 15/10/30.
//  Copyright © 2015年 com.epoluodi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewControl : UIViewController
{
    UIBarButtonItem *leftbtn;
    UIBarButtonItem *rightbtn;
}
@property (weak, nonatomic) IBOutlet UINavigationItem *navtitle;
@property (weak, nonatomic) IBOutlet UIView *numberview;


@end
