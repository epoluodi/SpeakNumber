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
    
    
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    navtitle.title = @"预置信息";
    rightbtn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(rightclick)];
    navtitle.rightBarButtonItem = rightbtn;
    db  = [[DBmanger alloc] initDB];
    
    
    // Do any additional setup after loading the view.
}

-(void)rightclick
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"预存管理" message:@"为当前设置信息输入一个名称" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textname = textField;
    }];
    
    UIAlertAction *actionsave  = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([db checkConfigData:textname.text])
        {
            //保存
            return ;
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc ] initWithTitle:@"预存管理" message:@"有重复名称，请重新设定" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
    }];
    
    UIAlertAction *actioncancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:actionsave];
    [alert addAction:actioncancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    return v;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}



-(void)saveconfig
{
    //报数间隔
    [db addData:@"speakInterval" value:[NSString stringWithFormat:@"%D",app.defaultsettingfoncig.speakInterval] group:textname.text];
    //几组
    [db addData:@"groups" value:[NSString stringWithFormat:@"%D",app.defaultsettingfoncig.groups] group:textname.text];
    //每组数量
    [db addData:@"groupincount" value:[NSString stringWithFormat:@"%D",app.defaultsettingfoncig.groupincount]  group:textname.text];
    //每组休息时间
    [db addData:@"grouprest" value:[NSString stringWithFormat:@"%D",app.defaultsettingfoncig.grouprest]  group:textname.text];
    //每组休息类型
    [db addData:@"resttype" value:[NSString stringWithFormat:@"%D",app.defaultsettingfoncig.resttype]  group:textname.text];
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
