//
//  DBmanger.h
//  DyingWish
//
//  Created by xiaoguang yang on 15-4-2.
//  Copyright (c) 2015年 Apollo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Config.h"
#import "Groupinfo.h"



@interface DBmanger : NSObject
{
    NSManagedObjectContext *mangedcontext;
    NSManagedObjectModel *mangedobjectmodel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    
}




-(instancetype)initDB;
-(void)addData:(NSString *)var value:(NSString *)value group:(NSString *)group;
-(NSArray *)getDefaultConfigdata;
-(NSArray *)getDefaultConfigdata:(NSString *)group;
-(void)updateConfig:(NSString *)var value:(NSString *)value;
-(BOOL)checkConfigData:(NSString *)groupname;
-(NSArray *)getConfigdataForGroup;
-(void)delconfig:(NSString *)group;
-(NSArray *)getConfigdataForALLGroup;

-(void)CHeckGroupNameInInfotable:(NSString *)group;
-(void)updateGroupinfo:(NSString *)group value1:(NSNumber *)value1 value2:(NSNumber *)value2;

-(NSArray *)getGroupinfo:(NSString *)group;
-(NSArray *)getGroupinfoToday;
@end
