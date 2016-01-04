//
//  PlaySpeak.m
//  SpeakNumber
//
//  Created by 程嘉雯 on 15/11/18.
//  Copyright © 2015年 com.epoluodi. All rights reserved.
//

#import "PlaySpeak.h"

@implementation PlaySpeak
@synthesize ISPlay;
@synthesize sounddelegate;
@synthesize isnormal;
static NSCondition *condtionplay;
static int playid,soundid;

-(instancetype)init:(settingConfig*)settingconfig
{
    self = [super init];
    lock = [[NSLock alloc] init];
    condtion = [[NSCondition alloc] init];
    
    globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    globalQ2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    mainQ = dispatch_get_main_queue();
    ISRUN=false;
    sleeptime = &settingconfig->speakInterval;
    counts = &settingconfig->groupincount;
    groups = &settingconfig->groups;
    resttime = &settingconfig->grouprest;
    
    NSString* audiopath = [[NSBundle mainBundle] pathForResource:@"backaudio" ofType:@"m4a"];
    NSLog(@"%@",audiopath);
    audiourl = [[NSURL alloc] initFileURLWithPath:audiopath];

    ISPlay=NO;
    
    session = [AVAudioSession sharedInstance];
    
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    return self;
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (condtionplay){
        [condtionplay lock];
        [condtionplay signal];
        [condtionplay unlock];
    }
    player.delegate=nil;
    player=nil;
}
//-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
//{
//    [sounddelegate CalledWithStopPlay];
//    
//}



-(BOOL)playsound:(NSString *)wavfile
{
    BOOL r = NO;
    if (!ISRUN)
        return YES;
    if (ISPause)
    {
        NSLog(@"准备等待");
        [condtion lock];
        [condtion wait];
        [condtion unlock];
        r=YES;
    }
    
    
    NSString *Path=[[NSBundle mainBundle] pathForResource:wavfile ofType:@"wav"];
    NSURL *soundfileURL=[NSURL fileURLWithPath:Path];
    audioplayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:soundfileURL  error:nil];
    audioplayer2.delegate =self;
    [audioplayer2 prepareToPlay];
    audioplayer2.volume=1;
    [audioplayer2 play];
    return r;
}


-(void)StartThreadForTime:(int)timer_counts
{
    
    if (ISRUN)
        return;
    
    ISRUN = true;
    ISPlay =YES;
    
    dispatch_async(globalQ, ^{
        audioplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audiourl  error:nil];
        [audioplayer prepareToPlay];
        
        audioplayer.numberOfLoops=INT8_MAX;
        [audioplayer play];
        audioplayer.volume = 0.5;
        
        
        
  
        playid = 11;
        
        
        
        dispatch_async(mainQ, ^{
            [self.sounddelegate completesound:&playid soundid:0];
        });
        
        [self playsound321go];
        __block int i = 1;
       
        
        while (ISRUN) {
            if (i > timer_counts)
            {
                    [self playsoundfinish];
                    playid = 10;
                    dispatch_async(mainQ, ^{
                        [self.sounddelegate completesound:&playid soundid:&i];
                    });
                    return ;
                
            }
            playid = 12;
            
            [self playsound:@"ding"];
            
            dispatch_async(mainQ, ^{
                [self.sounddelegate completesound:&playid soundid:&i];
            });
            
            NSLog(@"进入1秒等待");
            
            i++;
            if (!ISRUN)
                return;
            sleep(1);
            if (ISPause)
            {
                NSLog(@"准备等待");
                [condtion lock];
                [condtion wait];
                [condtion unlock];
            }
        }
        
    });
    
}



-(void)StartThread
{

    if (ISRUN)
        return;
    
    ISRUN = true;
    ISPlay =YES;
    
    dispatch_async(globalQ, ^{
        audioplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audiourl  error:nil];
        [audioplayer prepareToPlay];
        
        audioplayer.numberOfLoops=INT8_MAX;
        [audioplayer play];
        audioplayer.volume = 0.5;
        

        
        [self playsoundhead];
        sleep(1);
        
        [self playsound321go];
        
         __block int i = 1;
        int g=1;
        
        while (ISRUN) {
            if (i > *counts)
            {
                if (g == *groups)
                {
//                    ISRUN=NO;
                    
                    [self playsoundfinish];
                    playid = 10;
                    dispatch_async(mainQ, ^{
                        [self.sounddelegate completesound:&playid soundid:&i];
                    });
                    return ;
                }
                playid = 6;
                
                [self playsound:@"rest"];
               
                dispatch_async(mainQ, ^{
                    [self.sounddelegate completesound:&playid soundid:&i];
                });
                
                sleep(*resttime -3);//最后3秒开始倒数
                
                [self playsound321go];
                //休息
                i=1;
                g++;
            }
            playid = 4;
         
            [self playsound:[NSString stringWithFormat:@"%d",i]];
       
            dispatch_async(mainQ, ^{
                [self.sounddelegate completesound:&playid soundid:&i];
            });
            
            NSLog(@"进入1秒等待");
        
            i++;
            if (!ISRUN)
                return;
            sleep(*sleeptime);
            if (ISPause)
            {
                NSLog(@"准备等待");
                [condtion lock];
                [condtion wait];
                [condtion unlock];
            }
        }
    
    });

}

-(void)playsoundhead
{
    BOOL r;
    playid =1;
    dispatch_async(mainQ, ^{   [self.sounddelegate completesound:&playid soundid:&soundid];});
    condtionplay = [[NSCondition alloc] init];
    [condtionplay lock];
    r =[self playsound:@"meizu"];
    if (!ISRUN){
        [condtionplay unlock];
        condtionplay = nil;
        return;
    }
    if (!r)
        [condtionplay wait];
    r=[self playsound:[NSString stringWithFormat:@"%d",*counts]];
    if (!ISRUN){
        [condtionplay unlock];
        condtionplay = nil;
        return;
    }
    if (!r)
        [condtionplay wait];
    r =[self playsound:@"ci"];
    if (!ISRUN){
        [condtionplay unlock];
        condtionplay = nil;
        return;
    }
    if (!r)
        [condtionplay wait];
    [condtionplay unlock];
    playid =2;
    dispatch_async(mainQ, ^{   [self.sounddelegate completesound:&playid soundid:&soundid];});
 
    condtionplay = nil;
}


-(void)playsound321go
{
    BOOL r;
    playid=3;
    condtionplay = [[NSCondition alloc] init];
    [condtionplay lock];

    r =[self playsound:@"3"];
    if (!ISRUN){
        [condtionplay unlock];
        condtionplay = nil;
        return;
    }
    soundid=3;
    dispatch_async(mainQ, ^{
        [self.sounddelegate completesound:&playid soundid:&soundid];});
    if (!r)
        [condtionplay wait];
    [NSThread sleepForTimeInterval:1];

    r=[self playsound:@"2"];
    if (!ISRUN){
        [condtionplay unlock];
        condtionplay = nil;
        return;
    }
    soundid=2;
    dispatch_async(mainQ, ^{
        [self.sounddelegate completesound:&playid soundid:&soundid];});
    if (!r)
        [condtionplay wait];
    [NSThread sleepForTimeInterval:1];
    
    r=[self playsound:@"1"];
    if (!ISRUN){
        [condtionplay unlock];
        condtionplay = nil;
        return;
    }
    soundid=1;
    dispatch_async(mainQ, ^{
        [self.sounddelegate completesound:&playid soundid:&soundid];});
    if (!r)
        [condtionplay wait];
    

    [NSThread sleepForTimeInterval:1];
    
    
    r=[self playsound:@"go"];
    if (!ISRUN){
        [condtionplay unlock];
        condtionplay = nil;
        return;
    }
    soundid=0;
    dispatch_async(mainQ, ^{
        [self.sounddelegate completesound:&playid soundid:&soundid];});
    if (!r)
        [condtionplay wait];
    
    
    [condtionplay unlock];
    condtionplay = nil;
}
-(void)playsoundrest
{
    playid=9;
    condtionplay = [[NSCondition alloc] init];
    [condtionplay lock];
    [self playsound:@"rest"];
    if (!ISRUN){
        [condtionplay unlock];
        condtionplay = nil;
        return;
    }
    [condtionplay wait];
    [condtionplay unlock];
    condtionplay = nil;
}
-(void)playsoundfinish
{

    condtionplay = [[NSCondition alloc] init];
    [condtionplay lock];
    [self playsound:@"finish"];
    if (!ISRUN){
        [condtionplay unlock];
        condtionplay = nil;
        return;
    }
    [condtionplay wait];
    [condtionplay unlock];
    condtionplay = nil;
}


-(void)Continue
{
    
    [condtion lock];
    [condtion signal];
    [condtion unlock];
    ISPause = NO;
    NSLog(@"继续");
    ISPlay=YES;
    [audioplayer play];
    [audioplayer2 play];
}
-(void)StopThread
{
    [audioplayer stop];
    [audioplayer2 stop];
    ISRUN=false;
    ISPause=NO;
    ISPlay=NO;
    if (condtion){
        [condtion lock];
        [condtion signal];
        [condtion unlock];
    }
    if (condtionplay){
        [condtionplay lock];
        [condtionplay signal];
        [condtionplay unlock];
    }
    audioplayer=nil;
    audioplayer2=nil;
   [session setActive:NO error:nil];
    
}

-(void)Pause
{
    if (!ISRUN)
        return;
    ISPause = YES;
    NSLog(@"暂停");
    [audioplayer pause];
    [audioplayer2 pause];

    
}

//建立声音对象
-(void) GetPlaysound:(NSString *)wavfile {

    if (!ISRUN)
        return;
    if (ISPause)
    {
        NSLog(@"准备等待");
        [condtion lock];
        [condtion wait];
        [condtion unlock];
    }
    
    
    NSString *Path=[[NSBundle mainBundle] pathForResource:wavfile ofType:@"wav"];
    NSURL *soundfileURL=[NSURL fileURLWithPath:Path];
    
    //建立音效对象
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundfileURL, &soundFileObject);
    
   
   
        // Add sound completion callback
        AudioServicesAddSystemSoundCompletion (soundFileObject, NULL, NULL,completionCallback,(__bridge void*) self);
    audioplayer.volume =0.15;
    AudioServicesPlaySystemSound(soundFileObject);
}


static void completionCallback(SystemSoundID  mySSID, void* myself)
{
    NSLog(@"soundid %d",mySSID);
    AudioServicesDisposeSystemSoundID(mySSID);
    if (condtionplay){
        [condtionplay lock];
        [condtionplay signal];
        [condtionplay unlock];
    }
    
    

    
}
@end
