//
//  ListViewControl.m
//  SpeakNumber
//
//  Created by 程嘉雯 on 15/10/30.
//  Copyright © 2015年 com.epoluodi. All rights reserved.
//

#import "ListViewControl.h"

@interface ListViewControl ()
{
    DBmanger *db;
    NSArray *grouplist,*allgrouplist;
}
@end

@implementation ListViewControl
@synthesize navtitle,table;
@synthesize viewchart;
- (void)viewDidLoad {
    [super viewDidLoad];
    navtitle.title= @"训练信息";
    
    db =[[DBmanger alloc] initDB];
    grouplist = [db getGroupinfoToday];

    table.delegate= self;
    table.dataSource = self;
    table.backgroundColor = [UIColor clearColor];
    table.separatorColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    
    
    UIImageView *backview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    backview.frame = self.view.frame;
    [self.view insertSubview:backview atIndex:0];
    
    UINib *nib= [UINib nibWithNibName:@"groupcell" bundle:nil];
    [table registerNib:nib forCellReuseIdentifier:@"groupcell"];
    
    
    // Do any additional setup after loading the view.
}

-(void)initchart
{
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect rect = CGRectMake(0, 0, table.frame.size.width, 50);
    UIView *v = [[UIView alloc] init];
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"今日训练";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor=[UIColor whiteColor];
    v.frame=rect;
    lab.frame=rect;
    [v addSubview:lab];
    
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    UIView *v =[[UIView alloc] init];
    v.frame=cell.frame;
    v.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.2];
    cell.selectedBackgroundView=v;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [grouplist count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    groupcell *cell = [table dequeueReusableCellWithIdentifier:@"groupcell"];
    
    Groupinfo *gi = (Groupinfo*)[grouplist objectAtIndex:indexPath.row];
    
    cell.groupname.text =gi.groupname;
    cell.groups.text= [NSString stringWithFormat:@"%@ 组",gi.groups];
    cell.counts.text =[NSString stringWithFormat:@"%@ 个",gi.counts];

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Groupinfo *gi = (Groupinfo*)[grouplist objectAtIndex:indexPath.row];
    allgrouplist = [db getGroupinfo:gi.groupname];
    chart=  [[FSLineChart alloc] initWithFrame:CGRectMake(25, 10, viewchart.frame.size.width-50, viewchart.frame.size.height-30)];
   
  
    chart.backgroundColor = [UIColor clearColor];
    chart.gridStep = 1;
    chart.color = [UIColor colorWithRed:1.0f green:0.58f blue:0.21f alpha:1.0f];
  

    chart.labelForValue = ^(CGFloat value) {
        return @"一直坚持的趋势";
    };
    [chart setChartData:[self jscount]];

    [viewchart addSubview:chart];
}


-(NSArray *)jscount
{
    NSMutableArray *marry = [[NSMutableArray alloc] init];
    for (int i=0; i<[allgrouplist count]; i++) {
        [marry addObject:((Groupinfo *)allgrouplist[i]).counts];
        
    }
    
    return marry ;
    
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
