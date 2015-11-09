//
//  AppDelegate.m
//  SpeakNumber
//
//  Created by 程嘉雯 on 15/10/30.
//  Copyright © 2015年 com.epoluodi. All rights reserved.
//

#import "AppDelegate.h"
#import "DBmanger.h"

@interface AppDelegate ()
{
    DBmanger *db;
}

@end

@implementation AppDelegate
@synthesize defaultsettingfoncig;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    db = [[DBmanger alloc] initDB];
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    int first = (int)[userinfo integerForKey:@"first"];
    if (first == 0)
    {
        //报数间隔
        [db addData:@"speakInterval" value:@"2" group:@"默认"];
        //几组
        [db addData:@"groups" value:@"4" group:@"默认"];
        //每组数量
        [db addData:@"groupincount" value:@"10" group:@"默认"];
        //每组休息时间
        [db addData:@"grouprest" value:@"30" group:@"默认"];
        //每组休息类型
        [db addData:@"resttype" value:@"1" group:@"默认"];
        [userinfo setInteger:1 forKey:@"first"];
    }

    
    [self initsetting];
    
    
    
    
    return YES;
}


-(void)initsetting
{
    NSArray *arr = [db getDefaultConfigdata];
    for (Config *db_c in arr) {
        if ([db_c.var isEqualToString:@"speakInterval"])
            defaultsettingfoncig.speakInterval = [db_c.value integerValue];
        if ([db_c.var isEqualToString:@"groups"])
            defaultsettingfoncig.groups = [db_c.value integerValue];
        if ([db_c.var isEqualToString:@"groupincount"])
            defaultsettingfoncig.groupincount = [db_c.value integerValue];
        if ([db_c.var isEqualToString:@"grouprest"])
            defaultsettingfoncig.grouprest = [db_c.value integerValue];
        if ([db_c.var isEqualToString:@"resttype"])
            defaultsettingfoncig.resttype = [db_c.value integerValue];
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    
//    UIApplication*   app = [UIApplication sharedApplication];
//    __block    UIBackgroundTaskIdentifier bgTask;
//    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (bgTask != UIBackgroundTaskInvalid)
//            {
//                bgTask = UIBackgroundTaskInvalid;
//            }
//        });
//    }];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (bgTask != UIBackgroundTaskInvalid)
//            {
//                bgTask = UIBackgroundTaskInvalid;
//            }
//        });
//    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
