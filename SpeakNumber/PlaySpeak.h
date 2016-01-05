//
//  PlaySpeak.h
//  SpeakNumber
//
//  Created by 程嘉雯 on 15/11/18.
//  Copyright © 2015年 com.epoluodi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "setting.h"
#import <AudioToolbox/AudioToolbox.h>



@protocol sounddelegate

-(void)completesound:(int *)playid soundid:(int *)soundid;
-(void)CalledWithStopPlay;
@end

@interface PlaySpeak : NSObject<AVAudioPlayerDelegate>
{
    __block BOOL ISRUN;
    BOOL ISPause;
    NSLock *lock;
    NSCondition *condtion;
    dispatch_queue_t globalQ;
    dispatch_queue_t globalQ2;
    dispatch_queue_t mainQ;
    int *sleeptime;
    int *counts;
    int *groups;
    int *resttime;
    NSURL *audiourl;
    AVAudioPlayer *audioplayer;
    AVAudioPlayer *audioplayer2;
    SystemSoundID  soundFileObject;
    AVAudioSession *session;
    
}
@property (weak,nonatomic)NSObject<sounddelegate> *sounddelegate;
@property (assign)BOOL ISPlay;
@property (assign)BOOL isnormal;
static void completionCallback (SystemSoundID  mySSID, void* myself) ;
-(instancetype)init:(settingConfig *)settingconfig;
-(void)StopThread;
-(void)StartThread;
-(void)Pause;
-(void)Continue;
-(void)GetPlaysound:(NSString *)wavfile;
-(void)StartThreadForTime:(int)timer_counts;
@end
