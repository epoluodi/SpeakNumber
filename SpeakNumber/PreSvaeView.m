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
@synthesize tableview;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    navtitle.title = @"预置信息";
    rightbtn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(rightclick)];
    UIImageView *backview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    backview.frame = self.view.frame;
    [self.view insertSubview:backview atIndex:0];
    
    navtitle.rightBarButtonItem = rightbtn;
    db  = [[DBmanger alloc] initDB];
    
    configarr = [db getConfigdataForGroup];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor= [UIColor clearColor];
  
    
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
            
            [self saveconfig];
            
            UIAlertView *alert = [[UIAlertView alloc ] initWithTitle:@"预存管理" message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            configarr = [db getConfigdataForGroup];
            [tableview reloadData];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath      //当在Cell上滑动时会调用此函数
{

        return  UITableViewCellEditingStyleDelete;  //返回此值时,Cell会做出响应显示Delete按键,点击Delete后会调用下面的函数,别给传递UITableViewCellEditingStyleDelete参数
    
//    else
//        
//        return  UITableViewCellEditingStyleNone;   //返回此值时,Cell上不会出现Delete按键,即Cell不做任何响应
    
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *d =[configarr objectAtIndex:indexPath.row];
        
        [db delconfig:[d objectForKey:@"group"]];
        
        configarr = [db getConfigdataForGroup];
        // Delete the row from the data source.
        [tableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [configarr count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    return v;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    NSDictionary *d =[configarr objectAtIndex:indexPath.row];
    cell.textLabel.text  =[d objectForKey:@"group"];
    cell.textLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    NSArray *lists = [db getDefaultConfigdata:[d objectForKey:@"group"]];
    NSMutableString *detail = [[NSMutableString alloc] init];
    for (Config *db_c in lists) {
        if ([db_c.var isEqualToString:@"speakInterval"])
            [detail appendFormat:@"报数间隔：%@ ",db_c.value];
        if ([db_c.var isEqualToString:@"groups"])
            [detail appendFormat:@"运动：%@组 ",db_c.value];
        if ([db_c.var isEqualToString:@"groupincount"])
            [detail appendFormat:@"每组数量：%@个 ",db_c.value];
        if ([db_c.var isEqualToString:@"grouprest"])
            [detail appendFormat:@"中间休息时间：%@秒 ",db_c.value];

    }

    cell.detailTextLabel.text =detail;
        cell.detailTextLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    
    return cell;
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
    
    [textname resignFirstResponder];
    textname = nil;
    
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
