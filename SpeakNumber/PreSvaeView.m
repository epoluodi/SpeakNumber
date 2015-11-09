//
//  PreSvaeView.m
//  SpeakNumber
//
//  Created by 程嘉雯 on 15/11/4.
//  Copyright © 2015年 com.epoluodi. All rights reserved.
//

#import "PreSvaeView.h"

@interface PreSvaeView ()

@end

@implementation PreSvaeView
@synthesize navtitle;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    navtitle.title = @"预置信息";
    rightbtn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(rightclick)];
    navtitle.rightBarButtonItem = rightbtn;
   
    
    // Do any additional setup after loading the view.
}

-(void)rightclick
{
    [self.navigationController popViewControllerAnimated:YES];
    
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
