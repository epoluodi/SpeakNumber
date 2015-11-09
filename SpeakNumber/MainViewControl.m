//
//  MainViewControl.m
//  SpeakNumber
//
//  Created by 程嘉雯 on 15/10/30.
//  Copyright © 2015年 com.epoluodi. All rights reserved.
//

#import "MainViewControl.h"

@interface MainViewControl ()

@end

@implementation MainViewControl
@synthesize navtitle;
@synthesize numberview;
- (void)viewDidLoad {
    [super viewDidLoad];
  
    navtitle.title = @"报数";
    
    leftbtn = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(leftclick)];
    navtitle.leftBarButtonItem = leftbtn;
    
    rightbtn = [[UIBarButtonItem alloc] initWithTitle:@"记录" style:UIBarButtonItemStylePlain target:self action:@selector(rightclick)];
    navtitle.rightBarButtonItem = rightbtn;
    // Do any additional setup after loading the view.
    
    [self initnumberview];
}

-(void)leftclick
{
    [self performSegueWithIdentifier:@"setting" sender:self];
}

-(void)rightclick
{
    [self performSegueWithIdentifier:@"list" sender:self];
}



-(void)initnumberview
{
    
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
