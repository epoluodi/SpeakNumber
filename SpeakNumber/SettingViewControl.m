//
//  SettingViewControl.m
//  SpeakNumber
//
//  Created by 程嘉雯 on 15/10/30.
//  Copyright © 2015年 com.epoluodi. All rights reserved.
//

#import "SettingViewControl.h"


@interface SettingViewControl ()

@end

@implementation SettingViewControl
@synthesize table;
@synthesize navtitle;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    app = [[UIApplication sharedApplication] delegate];

    navtitle.title = @"报数设置";
    rightbtn = [[UIBarButtonItem alloc] initWithTitle:@"预设管理" style:UIBarButtonItemStylePlain target:self action:@selector(rightclick)];
    navtitle.rightBarButtonItem = rightbtn;
    
    table.delegate= self;
    table.dataSource = self;
    table.backgroundColor = [UIColor clearColor];
    table.separatorColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    UIImageView *backview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    backview.frame = self.view.frame;
    [self.view insertSubview:backview atIndex:0];
    
    numberformat = [[NSNumberFormatter alloc] init];
    
    [numberformat setNumberStyle:NSNumberFormatterNoStyle];
    
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);


    
 
    
    dispatch_after(popTime, mainQ, ^{
        [UIView animateWithDuration:0.5 animations:^{
            
            [slider1 setValue:app.defaultsettingfoncig.speakInterval animated:YES];
            [slider2 setValue:app.defaultsettingfoncig.groups animated:YES];
            [slider3 setValue:app.defaultsettingfoncig.groupincount animated:YES];
            [slider4 setValue:app.defaultsettingfoncig.grouprest animated:YES];
            
            
        }];
        
        
    });
   
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
     nowsettingconfig = malloc(sizeof(settingConfig));
    nowsettingconfig->speakInterval = app.defaultsettingfoncig.speakInterval;
    nowsettingconfig->groups = app.defaultsettingfoncig.groups;
    nowsettingconfig->groupincount = app.defaultsettingfoncig.groupincount;
    nowsettingconfig->grouprest = app.defaultsettingfoncig.grouprest;
   

}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}
-(void)rightclick
{
    [self performSegueWithIdentifier:@"settingmanger" sender:self];
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        case 1:
        case 2:
        case 3:
            return 160;
     
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;

    
    switch (indexPath.row) {
        case 0:
            cell = [[UITableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            slider1 = [[ASValueTrackingSlider alloc] init];
            
            slider1.maximumValue=5;
            slider1.minimumValue=1;
            slider1.value=2;
            slider1.tag = 1;
            slider1.dataSource = self;
            slider1.frame = CGRectMake(60, 50, [PublicCommon GetALLScreen].size.width - 120, 50);
            slider1.popUpViewColor = [UIColor colorWithRed:0.102f green:0.694f blue:0.992f alpha:1.00f];
            [cell.contentView addSubview:slider1];
            txttitle1 = [[UILabel alloc] init];
            txttitle1.text=[NSString stringWithFormat:@"间隔: 2 秒"];
            txttitle1.textColor =[UIColor colorWithRed:0.102f green:0.694f blue:0.992f alpha:1.00f];
            txttitle1.frame = CGRectMake(20  , slider1.frame.origin.y + 30+10, [PublicCommon GetALLScreen].size.width -40, 50);
            txttitle1.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:txttitle1];
            
            
            
            break;
        case 1:
            cell = [[UITableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            slider2 = [[ASValueTrackingSlider alloc] init];
            slider2.popUpViewAnimatedColors = @[[UIColor blueColor]];
            slider2.maximumValue=10;
            slider2.minimumValue=1;
            slider2.value=4;
            slider2.tag = 2;
            slider2.dataSource = self;
            slider2.frame = CGRectMake(60, 50, [PublicCommon GetALLScreen].size.width - 120, 50);
            slider2.popUpViewColor = [UIColor colorWithRed:0.102f green:0.694f blue:0.992f alpha:1.00f];
            [cell.contentView addSubview:slider2];
            txttitle2 = [[UILabel alloc] init];
            txttitle2.text=[NSString stringWithFormat:@"组: 4 组"];
            txttitle2.textColor =[UIColor colorWithRed:0.102f green:0.694f blue:0.992f alpha:1.00f];
            txttitle2.frame = CGRectMake(20  , slider2.frame.origin.y + 30+10, [PublicCommon GetALLScreen].size.width -40, 50);
            txttitle2.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:txttitle2];
            break;
        case 2:
            cell = [[UITableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            slider3 = [[ASValueTrackingSlider alloc] init];
            slider3.maximumValue=40;
            slider3.minimumValue=1;
            slider3.value=6;
            slider3.tag = 3;
            slider3.dataSource = self;
            slider3.frame = CGRectMake(60, 50, [PublicCommon GetALLScreen].size.width - 120, 50);
            slider3.popUpViewColor = [UIColor colorWithRed:0.102f green:0.694f blue:0.992f alpha:1.00f];
            [cell.contentView addSubview:slider3];
            txttitle3 = [[UILabel alloc] init];
            txttitle3.text=[NSString stringWithFormat:@"每组数量：: 6 个"];
            txttitle3.textColor =[UIColor colorWithRed:0.102f green:0.694f blue:0.992f alpha:1.00f];
            txttitle3.frame = CGRectMake(20  , slider3.frame.origin.y + 30+10, [PublicCommon GetALLScreen].size.width -40, 50);
            txttitle3.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:txttitle3];
            break;
        case 3:
            cell = [[UITableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            slider4 = [[ASValueTrackingSlider alloc] init];
            slider4.maximumValue=120;
            slider4.minimumValue=10;
            slider4.value=30;
            slider4.tag = 4;
            slider4.dataSource = self;
            slider4.frame = CGRectMake(60, 50, [PublicCommon GetALLScreen].size.width - 120, 50);
            slider4.popUpViewColor = [UIColor colorWithRed:0.102f green:0.694f blue:0.992f alpha:1.00f];
            [cell.contentView addSubview:slider4];
            txttitle4 = [[UILabel alloc] init];
            txttitle4.text=[NSString stringWithFormat:@"休息时间: 30 秒"];
            txttitle4.textColor =[UIColor colorWithRed:0.102f green:0.694f blue:0.992f alpha:1.00f];
            txttitle4.frame = CGRectMake(20  , slider4.frame.origin.y + 30+10, [PublicCommon GetALLScreen].size.width -40, 50);
            txttitle4.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:txttitle4];
            break;
    }
  
    
    return cell;
}

-(NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value
{
  
    NSString *n = [numberformat stringFromNumber:[NSNumber numberWithFloat:value]];
    switch (slider.tag) {
        case 1:
            txttitle1.text=[NSString stringWithFormat:@"报数间隔: %@ 秒",n];
       
         
            nowsettingconfig->speakInterval = [n intValue];
        
            return [NSString stringWithFormat:@"%@ 秒",n];
            
            break;
            
        case 2:
            txttitle2.text=[NSString stringWithFormat:@"运动: %@ 组",n];
      
            
            nowsettingconfig->groups = [n intValue];
            return [NSString stringWithFormat:@"%@ 组",n];
            
            break;
        case 3:
            txttitle3.text=[NSString stringWithFormat:@"每组数量: %@ 个",n];
        
            
            nowsettingconfig->groupincount = [n intValue];
            return [NSString stringWithFormat:@"%@ 个",n];
            
            break;
        case 4:
            txttitle4.text=[NSString stringWithFormat:@"中间休息时间: %@ 秒",n];
          
            
            nowsettingconfig->grouprest = [n intValue];
            return [NSString stringWithFormat:@"%@ 秒",n];
            
            break;
    }
    return @"";

}


-(void)saveSetting
{
    DBmanger *db = [[DBmanger alloc] initDB];
    [db updateConfig:@"speakInterval" value:[NSString stringWithFormat:@"%d", nowsettingconfig->speakInterval]];
    [db updateConfig:@"groups" value:[NSString stringWithFormat:@"%d", nowsettingconfig->groups]];
    [db updateConfig:@"grouprest" value:[NSString stringWithFormat:@"%d", nowsettingconfig->grouprest]];
    [db updateConfig:@"groupincount" value:[NSString stringWithFormat:@"%d", nowsettingconfig->groupincount]];
 
}

-(void)viewWillDisappear:(BOOL)animated
{

    [self saveSetting];
    app.defaultsettingfoncig = *nowsettingconfig;

    
    free(nowsettingconfig);
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
