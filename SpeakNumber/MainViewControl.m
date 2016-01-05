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
@synthesize btnplay;
@synthesize btnpause;
@synthesize btnstop;
@synthesize switchbar;
- (void)viewDidLoad {
    [super viewDidLoad];
  
    db =[[DBmanger alloc] initDB];
    
    navtitle.title = @"报数";
 
    font = [UIFont fontWithName:@"Digital-7" size:48];
    rightbtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStylePlain target:self action:@selector(rightclick)];
    navtitle.rightBarButtonItem = rightbtn;
    rightbtn.tintColor =[UIColor whiteColor];
    leftbtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"people"] style:UIBarButtonItemStylePlain target:self action:@selector(leftclick)];
    leftbtn.tintColor =[UIColor whiteColor];
    navtitle.leftBarButtonItem = leftbtn;
    
    self.navigationController.navigationBar.translucent =YES;
    self.navigationController.navigationBar.barStyle =UIBarStyleBlackTranslucent;
//    rightbtn = [[UIBarButtonItem alloc] initWithTitle:@"记录" style:UIBarButtonItemStylePlain target:self action:@selector(rightclick)];
//    navtitle.rightBarButtonItem = rightbtn;
    // Do any additional setup after loading the view.
    
    
//    
    [btnplay setBackgroundImage:[UIImage imageNamed:@"start1"] forState:UIControlStateNormal];
        [btnplay setBackgroundImage:[UIImage imageNamed:@"start"] forState:UIControlStateHighlighted];
//    btnplay.layer.cornerRadius = btnplay.frame.size.width /2;
//    btnplay.layer.borderColor = [[UIColor colorWithRed:0.102f green:0.694f blue:0.992f alpha:1.00f] CGColor];
//    btnplay.layer.borderWidth=1;
//    
//    btnplay.layer.masksToBounds=YES;
    
    [btnpause setBackgroundImage:[UIImage imageNamed:@"pause1"] forState:UIControlStateNormal];
    [btnpause setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateHighlighted];
//    btnpause.layer.cornerRadius = btnpause.frame.size.width /2;
//    btnpause.layer.borderColor = [[UIColor colorWithRed:0.102f green:0.694f blue:0.992f alpha:1.00f] CGColor];
//    btnpause.layer.borderWidth=1;
//    
//    btnpause.layer.masksToBounds=YES;
    
//    
    [btnstop setBackgroundImage:[UIImage imageNamed:@"stop1"] forState:UIControlStateNormal];
       [btnstop setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateHighlighted];
//    btnstop.layer.cornerRadius = btnpause.frame.size.width /2;
//    btnstop.layer.borderColor = [[UIColor colorWithRed:0.102f green:0.694f blue:0.992f alpha:1.00f] CGColor];
//    btnstop.layer.borderWidth=1;
//    
//    btnstop.layer.masksToBounds=YES;
    
    
    UIImageView *backview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    
    backview.frame = self.view.frame;
//    [self.view insertSubview:backview atIndex:0];
    [self.view setBackgroundColor:[UIColor blackColor]];
   
    
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    

    isnormal = YES;
    [switchbar addTarget:self action:@selector(switchchange) forControlEvents:UIControlEventValueChanged];
//    switchbar.hidden=YES;
    [self updatenumberviewLayout];
    [self updateTableLayout];
    
//    [self initnumberview];
    [self initnumberviewEx];
    
    AudioSessionInitialize(NULL, NULL, interruptionListenner, (__bridge void*)self);
}

bool IsCalledStop;
void interruptionListenner(void* inClientData, UInt32 inInterruptionState)
{
    MainViewControl* mainself = (__bridge MainViewControl*)inClientData;

    if (mainself) {
  
        if (kAudioSessionBeginInterruption == inInterruptionState) {
            NSLog(@"Begin interruption");
            if ([mainself.self getIsPlay])
            {
                [mainself.self clickpause:nil];
                IsCalledStop=true;
            }
        }
        else
        {
            if (IsCalledStop)
            {
//                [mainself.self clickplay:nil];
                IsCalledStop=false;
            }
            NSLog(@"Begin end interruption");
           
            NSLog(@"End end interruption");
        }
        
    }
}

-(BOOL)getIsPlay
{
    return playsound.ISPlay;
}

-(void)switchchange
{
    switch (switchbar.selectedSegmentIndex) {
        case 0:
            
            isnormal = YES;
            if (slider1)
            {
                [slider1 removeFromSuperview];
                slider1=nil;
                [txttitle1 removeFromSuperview];
                txttitle1=nil;
            }
            tableview.hidden=NO;
            break;
        case 1:
            isnormal = NO;
            tableview.hidden=YES;
            slider1 = [[ASValueTrackingSlider alloc] init];
            
            slider1.maximumValue=300;
            slider1.minimumValue=60;
            slider1.value=60;
            
            slider1.dataSource = self;
            slider1.frame = CGRectMake(50, switchbar.frame.origin.y + switchbar.frame.size.height+40, [PublicCommon GetALLScreen].size.width - 100, 50);
            slider1.popUpViewColor = [UIColor colorWithRed:0.102f green:0.694f blue:0.992f alpha:1.00f];
            [self.view addSubview:slider1];
            txttitle1 = [[UILabel alloc] init];
            txttitle1.text=[NSString stringWithFormat:@"计时训练时间: 60 秒"];
            txttitle1.textColor =[UIColor colorWithRed:0.102f green:0.694f blue:0.992f alpha:1.00f];
            txttitle1.frame = CGRectMake(20  , slider1.frame.origin.y + 30+10, [PublicCommon GetALLScreen].size.width -40, 50);
            txttitle1.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:txttitle1];
            
            
            break;
            
     
    }
}



-(NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value
{
     NSNumberFormatter *numberformat;
    numberformat = [[NSNumberFormatter alloc] init];
    
    [numberformat setNumberStyle:NSNumberFormatterNoStyle];
    
    NSString *n = [numberformat stringFromNumber:[NSNumber numberWithFloat:value]];
   
    txttitle1.text=[NSString stringWithFormat:@"计时训练时间: %@ 秒",n];
            
            return [NSString stringWithFormat:@"%@ 秒",n];
 
}


-(void)completesound:(int *)playid soundid:(int *)soundid
{
//    CABasicAnimation *pathAnimation;
//    CABasicAnimation *scaleAnimation;
//    CABasicAnimation *opacityAnimation;
//    CAAnimationGroup *animationgroup;
    CATransition *animationtran;
    dispatch_queue_t globalQ3;
    switch (*playid) {
        case 1:
//            [shapelayer removeAllAnimations];
//            scaleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//            scaleAnimation.fromValue = [NSNumber numberWithFloat:1];
//            scaleAnimation.toValue = [NSNumber numberWithFloat:0];
//            scaleAnimation.duration=1;
//            opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];         scaleAnimation.fromValue = [NSNumber numberWithFloat:1];
//            opacityAnimation.toValue = [NSNumber numberWithFloat:0];
//            opacityAnimation.duration = 1;
//            
//            animationgroup = [[CAAnimationGroup alloc] init];
//            animationgroup.animations = @[scaleAnimation,opacityAnimation];
//            animationgroup.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//            
//            animationgroup.duration=1;
//            animationgroup.removedOnCompletion = NO;
//            animationgroup.fillMode = kCAFillModeForwards;
//            [shapelayer addAnimation:animationgroup forKey:nil];
            [lineprogressview FormCompleted:80 toComplete:0 animated:YES];
            
            
          
            numberlayer.string = @"1";
            countslayer.string = [NSString stringWithFormat:@"%d 个",_counts];
            groupslayer.string = [NSString stringWithFormat:@"%D 组",_groups];
            
            
            
            
            break;
        case 2:
            shapelayer.strokeColor = [[UIColor clearColor] CGColor];
            animationtran = [CATransition animation];
            animationtran.type = kCATransitionFade;
            animationtran.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animationtran.duration = 0.4;
            [numberlayer addAnimation:animationtran forKey:nil];
            numberlayer.string=@"3";
            numberlayer.foregroundColor = [[UIColor whiteColor]CGColor];
            countslayer.foregroundColor = [[UIColor whiteColor]CGColor];
            groupslayer.foregroundColor= [[UIColor whiteColor]CGColor];
        
//            shapelayer.opacity=1;
//            [shapelayer removeAllAnimations];
            break;
        case 3:
            btnpause.enabled=YES;
            runfloat=0;
//            shapelayer.strokeEnd=0;
//            [shapelayer removeAllAnimations];
            animationtran = [CATransition animation];
            animationtran.type = kCATransitionFade;
            animationtran.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animationtran.duration = 0.4;
            [numberlayer addAnimation:animationtran forKey:nil];
            if (*soundid == 0){
                numberlayer.string=@"GO";
//                if (lineprogressview.nowcompleted == 80){
//                    lineprogressview.animationDuration=0.3;
//                    [lineprogressview FormCompleted:1 *80 toComplete:0 animated:YES];
//                }
            }
            
            else
                numberlayer.string=[NSString stringWithFormat:@"%d",*soundid];
            
            
            break;
     
        case 4://报数
            
//            scaleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//            scaleAnimation.fromValue = [NSNumber numberWithFloat:runfloat];
//            scaleAnimation.toValue = [NSNumber numberWithFloat:runfloat + stepfloat];
                  lineprogressview.animationDuration=0.4;
            [lineprogressview FormCompleted:runfloat *80 toComplete:(runfloat + stepfloat)*80 animated:YES];
            runfloat =runfloat + stepfloat;
//            shapelayer.strokeEnd =runfloat;
            
//            scaleAnimation.duration=0.75;
//            shapelayer.strokeColor= [[UIColor whiteColor] CGColor];
//            scaleAnimation.removedOnCompletion=NO;
//            animationgroup.fillMode = kCAFillModeForwards;
//            [shapelayer addAnimation:scaleAnimation forKey:nil];
            
            animationtran = [CATransition animation];
            animationtran.type = kCATransitionFade;
            animationtran.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animationtran.duration = 0.4;
            [numberlayer addAnimation:animationtran forKey:nil];
            numberlayer.string=[NSString stringWithFormat:@"%d",*soundid];
            
            _counts++;
            countslayer.string = [NSString stringWithFormat:@"%d 个",_counts];
            groupslayer.string = [NSString stringWithFormat:@"%D 组",_groups];
            
            [db updateGroupinfo:celllabel.text value1:@0
                         value2:@1];
            break;
        case 10:
            [db updateGroupinfo:celllabel.text value1:@1
                         value2:@0];
            [self clickstop:nil];
            break;
        case 11:
            runfloat=0;
           
            countslayer.string = @"0 个";
            groupslayer.string = @"0 组";
            numberlayer.string=@"3";
            numberlayer.foregroundColor = [[UIColor whiteColor]CGColor];
            countslayer.foregroundColor = [[UIColor whiteColor]CGColor];
            groupslayer.foregroundColor= [[UIColor whiteColor]CGColor];
            lineprogressview.animationDuration=0.4;
            [lineprogressview FormCompleted:80 toComplete:0 animated:YES];
            break;
        case 12:
            numberlayer.string = [NSString stringWithFormat:@"%d",*soundid];
            lineprogressview.animationDuration=0.7;
            [lineprogressview FormCompleted:runfloat *80 toComplete:(runfloat + (float)((float)1 / slider1.value))*80 animated:YES];
            runfloat =runfloat + (float)((float)1 / slider1.value);
            break;
        case 6://休息
            runfloat=0;
            _groups++;
            
            [db updateGroupinfo:celllabel.text value1:@1
                         value2:@0];
            
            
             [shapelayer removeAllAnimations];
            shapelayer.strokeEnd=0;
            btnpause.enabled=NO;
            
            globalQ3 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            
            dispatch_async(globalQ3, ^{
                int i = config_now->grouprest ;
              
                while (rest) {
                    
                    if ((i-3) == 0)
                        return ;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        numberlayer.string = [NSString stringWithFormat:@"%d",i];
                        lineprogressview.animationDuration=0.7;
                        [lineprogressview FormCompleted:runfloat *80 toComplete:(runfloat + stepfloatrest)*80 animated:YES];
//                       CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//                        scaleAnimation.fromValue = [NSNumber numberWithFloat:runfloat];
//                        scaleAnimation.toValue = [NSNumber numberWithFloat:runfloat + stepfloatrest];
                        runfloat =runfloat + stepfloatrest;
//                        shapelayer.strokeEnd =runfloat;
//                        shapelayer.strokeColor = [[UIColor greenColor]CGColor];
//                        scaleAnimation.duration=0.99;
//                      
//                        scaleAnimation.removedOnCompletion=NO;
//                        animationgroup.fillMode = kCAFillModeForwards;
//                        [shapelayer addAnimation:scaleAnimation forKey:nil];
                        
                        
                    });
                    
                    
                    i--;
                    sleep(1);
                }
            });
            
            
            break;
 

    }
}



-(void)clickpause:(id)sender
{
    
    [playsound Pause];
    btnplay.enabled=YES;
}

-(void)clickplay:(id)sender
{
    tableview.userInteractionEnabled=NO;
    
    if (playsound.ISPlay)
        [playsound Continue];
    else{
        rest = YES;
        _groups=1;
        _counts=0;
        stepfloatrest =((float)1) / (float)(config_now->grouprest-3);
        groupslayer.string = [NSString stringWithFormat:@"%D 组",_groups];
        stepfloat = ((float)1) / (float)config_now->groupincount;
        runfloat = 0;
        playsound.isnormal=isnormal;
        if (isnormal){
            [db CHeckGroupNameInInfotable:celllabel.text];
            [playsound StartThread];
        }
        
        else{
             [db CHeckGroupNameInInfotable:@"计时训练"];
            slider1.enabled=NO;
            [playsound StartThreadForTime:(int)slider1.value];
        }
        
    }
    btnplay.enabled=NO;
    switchbar.enabled=NO;
}

-(void)clickstop:(id)sender
{
    
    rest = NO;
    tableview.userInteractionEnabled=YES;
    runfloat = 0;
    btnplay.enabled=NO;
    shapelayer.strokeEnd=0;
    [shapelayer removeAllAnimations];
    [playsound StopThread];
    numberlayer.foregroundColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.45] CGColor];
    countslayer.foregroundColor=[[[UIColor whiteColor] colorWithAlphaComponent:0.45] CGColor];
    groupslayer.foregroundColor=[[[UIColor whiteColor] colorWithAlphaComponent:0.45] CGColor];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
   
            switchbar.enabled=YES;
            btnplay.enabled=YES;
            if (slider1)
                slider1.enabled=YES;
        });

    });
    
}


-(void)viewDidAppear:(BOOL)animated
{
    configgroup = [db getConfigdataForALLGroup];
    [tableview reloadData];
    if (config_now == NULL)
        config_now  = malloc(sizeof(settingConfig));
    
    

    
    [self displaytableinit];

    

}

//-(void)CalledWithStopPlay
//{
//    [self clickpause:nil];
//}
-(void)viewDidDisappear:(BOOL)animated
{
    free(config_now);
    config_now=NULL;
    [self clickstop:nil];
 

    playsound = nil;
}

-(void)dealloc
{
        AudioSessionInitialize(NULL, NULL, NULL,NULL);
}


-(void)displaytableinit
{
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
    dispatch_after(popTime, mainQ, ^(void){
        [tableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0 ] animated:YES scrollPosition:UITableViewScrollPositionTop];
        UITableViewCell*cell = [tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.textLabel.textColor =[UIColor yellowColor];
        celllabel = cell.textLabel;
        int _i=0;
        [self setindexConfig:&_i];
        tableview.userInteractionEnabled=YES;
   
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
//    cell.selectedBackgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    cell.selectedBackgroundView.layer.borderWidth =1;
    cell.selectedBackgroundView.layer.borderColor = [[UIColor colorWithRed:0.102f green:0.694f blue:0.992f alpha:1.00f] CGColor];

}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *d = [configgroup objectAtIndex:indexPath.row];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text =[d objectForKey:@"group"];
    cell.textLabel.textColor=[[UIColor grayColor] colorWithAlphaComponent:0.7];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return  cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    return v;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (celllabel){
        celllabel.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
        celllabel = nil;
    }
    int index = (int)indexPath.row;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor yellowColor];
    celllabel = cell.textLabel;
    [self AnimationCell: cell.selectedBackgroundView.layer];
    [self setindexConfig:&index];    
}


-(void)AnimationCell:(CALayer *)layer
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.75];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.duration = 0.3;
    [layer addAnimation:scaleAnimation forKey:nil];
    
 
    
    
    
}


-(void)setindexConfig:(int *)index
{
    
    NSDictionary *d = [configgroup objectAtIndex:*index];
    NSString *str = [d objectForKey:@"group"];
    
    NSArray *arr = [db getDefaultConfigdata:str];
    settingConfig sc;
    for (Config *db_c in arr) {
        if ([db_c.var isEqualToString:@"speakInterval"])
            sc.speakInterval = (int)[db_c.value integerValue];
        if ([db_c.var isEqualToString:@"groups"])
            sc.groups = (int)[db_c.value integerValue];
        if ([db_c.var isEqualToString:@"groupincount"])
            sc.groupincount = (int)[db_c.value integerValue];
        if ([db_c.var isEqualToString:@"grouprest"])
            sc.grouprest = (int)[db_c.value integerValue];
        if ([db_c.var isEqualToString:@"resttype"])
            sc.resttype = (int)[db_c.value integerValue];
    }
    memcpy(config_now, &sc, sizeof(settingConfig));
    playsound=nil;
    playsound = [[PlaySpeak alloc] init:&config_now->speakInterval];
    playsound.sounddelegate =self;
    btnplay.enabled=YES;
    btnpause.enabled=YES;
}


-(void)updatenumberviewLayout
{
    NSLayoutConstraint *heightConstraint;
    heightConstraint = [numberview.constraints objectAtIndex:0];
    if (!iPhone6plus && !iPhone6 && !iPhone5)
    {
        
        heightConstraint.constant=125;

    }
   
    heightConstraint = [numberview.constraints objectAtIndex:1];
    if (!iPhone6plus && !iPhone6 && !iPhone5)
    {
//
        heightConstraint.constant=125;
        numberimg.frame = CGRectMake(0, 0, 125, 125);
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
    
    [self performSegueWithIdentifier:@"list" sender:self];
}

-(void)rightclick
{
    [self performSegueWithIdentifier:@"settingview" sender:self];
}



-(void)initnumberviewEx
{
    lineprogressview = [[LineProgressView alloc] init];
    if (!iPhone6plus && !iPhone6 && !iPhone5){
        lineprogressview.frame = CGRectMake(0, 0, 125, 125);
        lineprogressview.radius = 60;
        lineprogressview.innerRadius = 50;
    }
    else{
        lineprogressview.frame = CGRectMake(0, 0, numberview.frame.size.width, numberview.frame.size.height);
        lineprogressview.radius = 105;
        lineprogressview.innerRadius = 95;
    }
    
    
    lineprogressview.backgroundColor = [UIColor blackColor];
    
    lineprogressview.total = 80;
    lineprogressview.color = [[UIColor whiteColor] colorWithAlphaComponent:0.3f];

    lineprogressview.startAngle = -M_PI /2;
    lineprogressview.endAngle = M_PI * 3/2;
    lineprogressview.animationDuration = 0.99f;
    lineprogressview.layer.shouldRasterize = YES;
    [numberview addSubview:lineprogressview];
    


    
    numberlayer = [[CATextLayer  alloc] init];
    numberlayer.font = (CFTypeRef)CFBridgingRetain(font);
    
    
    
    
    
    numberlayer.foregroundColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.45] CGColor];
    numberlayer.string = @"1";
    
    
    numberlayer.alignmentMode = kCAAlignmentCenter;//字体的对齐方式
    
    NSLog(@"numberimg %@",NSStringFromCGRect(numberimg.frame));
    numberlayer.frame = CGRectMake(numberimg.frame.origin.x, numberimg.frame.origin.y+20, numberimg.frame.size.width, numberimg.frame.size.height-5);
    
    [lineprogressview.layer  insertSublayer:numberlayer atIndex:1];
    
    countslayer = [[CATextLayer  alloc] init];
    
    
    countslayer.string = @"0 个";
    countslayer.foregroundColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.45] CGColor];
    
    
    countslayer.alignmentMode = kCAAlignmentCenter;//字体的对齐方式
    countslayer.frame = CGRectMake(numberlayer.frame.origin.x, numberimg.frame.size.height /2 +10, numberlayer.frame.size.width, numberlayer.frame.size.height);
    [lineprogressview.layer  insertSublayer:countslayer atIndex:1];
    
    groupslayer = [[CATextLayer  alloc] init];
    
    
    groupslayer.string = @"0 组";
    groupslayer.foregroundColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.45] CGColor];
    
    if (!iPhone6plus && !iPhone6 && !iPhone5)
    {
        numberlayer.fontSize = 40;
        groupslayer.fontSize = 10;
        countslayer.fontSize = 12;
        groupslayer.frame = CGRectMake(numberlayer.frame.origin.x, numberimg.frame.size.height /2 + 30 , numberlayer.frame.size.width, numberlayer.frame.size.height);
    }
    else{
        numberlayer.fontSize = 100;
        groupslayer.fontSize = 22;
        countslayer.fontSize = 22;
        groupslayer.frame = CGRectMake(numberlayer.frame.origin.x, numberimg.frame.size.height /2 + 40 , numberlayer.frame.size.width, numberlayer.frame.size.height);
    }
    
    
    
    
    groupslayer.alignmentMode = kCAAlignmentCenter;//字体的对齐方式
    
    [lineprogressview.layer  insertSublayer:groupslayer atIndex:1];
    
    
    
    [lineprogressview setCompleted:1*lineprogressview.total animated:YES];
    
}




-(void)initnumberview
{
    
    numberlayer = [[CATextLayer  alloc] init];
    numberlayer.font = (CFTypeRef)CFBridgingRetain(font);


    
    
    
    numberlayer.foregroundColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.45] CGColor];
    numberlayer.string = @"1";
    
  
    numberlayer.alignmentMode = kCAAlignmentCenter;//字体的对齐方式
    
    NSLog(@"numberimg %@",NSStringFromCGRect(numberimg.frame));
    numberlayer.frame = CGRectMake(numberimg.frame.origin.x, numberimg.frame.origin.y+5, numberimg.frame.size.width, numberimg.frame.size.height-5);
    
    [numberimg.layer  insertSublayer:numberlayer atIndex:1];
    
    countslayer = [[CATextLayer  alloc] init];
 
    
    countslayer.string = @"0 个";
    countslayer.foregroundColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.45] CGColor];
    
  
    countslayer.alignmentMode = kCAAlignmentCenter;//字体的对齐方式
    countslayer.frame = CGRectMake(numberlayer.frame.origin.x, numberimg.frame.size.height /2 +10, numberlayer.frame.size.width, numberlayer.frame.size.height);
    [numberimg.layer  insertSublayer:countslayer atIndex:1];
    
    groupslayer = [[CATextLayer  alloc] init];

    
    groupslayer.string = @"0 组";
    groupslayer.foregroundColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.45] CGColor];
    
    if (!iPhone6plus && !iPhone6 && !iPhone5)
    {
        numberlayer.fontSize = 60;
        groupslayer.fontSize = 12;
        countslayer.fontSize = 12;
        groupslayer.frame = CGRectMake(numberlayer.frame.origin.x, numberimg.frame.size.height /2 + 30 , numberlayer.frame.size.width, numberlayer.frame.size.height);
    }
    else{
        numberlayer.fontSize = 120;
        groupslayer.fontSize = 24;
        countslayer.fontSize = 24;
        groupslayer.frame = CGRectMake(numberlayer.frame.origin.x, numberimg.frame.size.height /2 + 40 , numberlayer.frame.size.width, numberlayer.frame.size.height);
    }
    
    
    
    
    groupslayer.alignmentMode = kCAAlignmentCenter;//字体的对齐方式
    
    [numberimg.layer  insertSublayer:groupslayer atIndex:1];
    
    
    numberimg.layer.borderWidth=1;
    numberimg.layer.borderColor=[[UIColor colorWithRed:0.102f green:0.694f blue:0.992f alpha:1.00f] CGColor];
    numberimg.image=nil;
    numberimg.layer.cornerRadius = numberimg.frame.size.width /2;
    numberimg.layer.masksToBounds = YES;
    
    shapelayer = [CAShapeLayer layer];

    shapelayer.path = [self drawPathWithArcCenter];
    shapelayer.fillColor = [UIColor clearColor].CGColor;

    shapelayer.strokeColor =[[UIColor yellowColor] CGColor];

    shapelayer.lineWidth = 3;
    shapelayer.lineCap = kCALineCapRound;
    shapelayer.strokeEnd=1;
    
    [numberimg.layer addSublayer:shapelayer];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1;
    pathAnimation.fromValue = @0;
    pathAnimation.toValue = @1;
    pathAnimation.removedOnCompletion = YES;
    
    [shapelayer addAnimation:pathAnimation forKey:nil];
    
    
}





- (CGPathRef)drawPathWithArcCenter {
    
    CGFloat position_y = (numberimg.frame.size.height)/2;
    CGFloat position_x = (numberimg.frame.size.width)/2; // Assuming that width == height
    //    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(position_x, position_y)
    //                                          radius:position_y
    //                                      startAngle:(-M_PI/2)
    //                                        endAngle:(3*M_PI/2)
    //                                       clockwise:YES].CGPath;
    
    UIBezierPath * apath = [UIBezierPath bezierPath];
    
    [apath addArcWithCenter:CGPointMake(position_x,position_y) radius:(numberimg.frame.size.width)/2 -2  startAngle:-M_PI/2 endAngle:3*M_PI/2 clockwise:YES];
    return [apath CGPath];
    
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
