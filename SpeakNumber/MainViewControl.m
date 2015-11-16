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
@synthesize tableview;
@synthesize numberimg;
- (void)viewDidLoad {
    [super viewDidLoad];
  
    db =[[DBmanger alloc] initDB];
    configgroup = [db getConfigdataForALLGroup];
    navtitle.title = @"报数";
 
    font = [UIFont fontWithName:@"Cansiparane" size:44];
    leftbtn = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(leftclick)];
    navtitle.leftBarButtonItem = leftbtn;
    
    self.navigationController.navigationBar.translucent =YES;
    self.navigationController.navigationBar.barStyle =UIBarStyleBlackTranslucent;
//    rightbtn = [[UIBarButtonItem alloc] initWithTitle:@"记录" style:UIBarButtonItemStylePlain target:self action:@selector(rightclick)];
//    navtitle.rightBarButtonItem = rightbtn;
    // Do any additional setup after loading the view.
    
    UIImageView *backview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    backview.frame = self.view.frame;
    [self.view insertSubview:backview atIndex:0];
    
    numberlayer = [[CATextLayer  alloc] init];
    numberlayer.font = (CFTypeRef)CFBridgingRetain(font);
    numberlayer.fontSize = 124;
    numberlayer.string = @"1";

    numberlayer.foregroundColor = [[UIColor whiteColor] CGColor];
    numberlayer.alignmentMode = kCAAlignmentCenter;//字体的对齐方式
    numberlayer.frame = numberimg.frame;
    [numberimg.layer  insertSublayer:numberlayer atIndex:1];
    
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    

    config_now  = malloc(sizeof(settingConfig));
    
    
    [self updateTableLayout];
    
    [self initnumberview];
    
    [self displaytableinit];
}

-(void)viewDidDisappear:(BOOL)animated
{
    free(config_now);
}

-(void)displaytableinit
{
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
    dispatch_after(popTime, mainQ, ^(void){
        [tableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0 ] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        
    });
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [configgroup count];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *d = [configgroup objectAtIndex:indexPath.row];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text =[d objectForKey:@"group"];
    cell.textLabel.textColor=[[UIColor grayColor] colorWithAlphaComponent:0.7];

    return  cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    return v;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = (int)indexPath.row;
    [self setindexConfig:&index];
    
    
    
    
}



-(void)setindexConfig:(int *)index
{
    
    NSDictionary *d = [configgroup objectAtIndex:*index];
    NSString *str = [d objectForKey:@"group"];
    
    NSArray *arr = [db getDefaultConfigdata:str];
    
    for (Config *db_c in arr) {
//        if ([db_c.var isEqualToString:@"speakInterval"])
//            defaultsettingfoncig.speakInterval = [db_c.value integerValue];
//        if ([db_c.var isEqualToString:@"groups"])
//            defaultsettingfoncig.groups = [db_c.value integerValue];
//        if ([db_c.var isEqualToString:@"groupincount"])
//            defaultsettingfoncig.groupincount = [db_c.value integerValue];
//        if ([db_c.var isEqualToString:@"grouprest"])
//            defaultsettingfoncig.grouprest = [db_c.value integerValue];
//        if ([db_c.var isEqualToString:@"resttype"])
//            defaultsettingfoncig.resttype = [db_c.value integerValue];
    }
    
}

-(void)updateTableLayout
{
    NSLayoutConstraint *heightConstraint;
        heightConstraint = [tableview.constraints objectAtIndex:1];
    if (iPhone6plus)
    {

        heightConstraint.constant=200;

    }
    if (iPhone6)
        heightConstraint.constant=170;
    if (iPhone5)
        heightConstraint.constant=150;
    if (iPhone4)
        heightConstraint.constant=110;
    
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
