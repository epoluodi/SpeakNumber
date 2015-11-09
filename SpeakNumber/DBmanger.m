//
//  DBmanger.m
//  DyingWish
//
//  Created by xiaoguang yang on 15-4-2.
//  Copyright (c) 2015年 Apollo. All rights reserved.
//

#import "DBmanger.h"



@implementation DBmanger




-(instancetype)initDB
{
  
    self = [super init];
    
    mangedcontext = [[NSManagedObjectContext alloc] init];
    mangedcontext.persistentStoreCoordinator = [self persistentstorecoordinator];
    
    return self;
}

-(NSPersistentStoreCoordinator*)persistentstorecoordinator
{
    NSString * modelpath = [[NSBundle mainBundle] pathForResource:@"settingdb" ofType:@"momd"];
    mangedobjectmodel = [[NSManagedObjectModel alloc]initWithContentsOfURL:[NSURL fileURLWithPath:modelpath]];
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mangedobjectmodel];
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]; 
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"Config.db"]];//要存得数据文件名
    NSError *error = nil;
    NSPersistentStore *store = [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) { // 直接抛异常
        [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
        return nil;
    }
    return persistentStoreCoordinator;
    
}

-(void)addData:(NSString *)var value:(NSString *)value group:(NSString *)group
{
    Config *config = [NSEntityDescription insertNewObjectForEntityForName:@"Config" inManagedObjectContext:mangedcontext];
    
    [config setValue:var forKey:@"var"];
    [config setValue:value forKey:@"value"];
    [config setValue:group forKey:@"group"];
    
    
    [mangedcontext save:nil];
}






-(NSArray *)getDefaultConfigdata{
    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"Config"];
    
    //排序
    //    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
    //    fetch.sortDescriptors=@[sort];
    //加入查询条件 age>20
    fetch.predicate=[NSPredicate predicateWithFormat:@"group=%@",@"默认"];
    
    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];

    return arr;
}

//
//-(int)finddata:(NSString *)stockcode{
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"Stock"];
//    
//    //排序
////    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
////    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
//        fetch.predicate=[NSPredicate predicateWithFormat:@"stockcode=%@",stockcode];
//  
////    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    int l = (int)arr.count;
//    NSLog(@"找到的数据： %d",l);
//    return l;
//}
//
//
//
//
//
//-(int)getDingDongs{
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"StockDD"];
//    
//    //排序
//    //    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
//    //    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
////    fetch.predicate=[NSPredicate predicateWithFormat:@"stockcode=%@",stockcode];
//    
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    int l = (int)arr.count;
//    NSLog(@"叮咚总数： %d",l);
//    return l;
//}
//
//

-(void)updateConfig:(NSString *)var value:(NSString *)value
{
    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"Config"];
    
    //排序
    //    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
    //    fetch.sortDescriptors=@[sort];
    //加入查询条件 age>20
        fetch.predicate=[NSPredicate predicateWithFormat:@"group=%@ and var = %@",@"默认",var];

    
    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
    
    Config *config = [arr objectAtIndex:0];
    config.value = value;
    [mangedcontext save:nil];
    return ;
}
//
//
//
//
//-(NSArray *)finddatadingdong:(NSString *)stockcodeEx
//{
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"StockDD"];
//    
//    //排序
//    //    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
//    //    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
//    fetch.predicate=[NSPredicate predicateWithFormat:@"stockcodeEx=%@",stockcodeEx];
//    
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//
//    return arr;
//}
//
//
//-(void)deletestock:(NSString *)stockcode
//{
//    
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"Stock"];
//    
//    //排序
//    //    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
//    //    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
//    fetch.predicate=[NSPredicate predicateWithFormat:@"stockcode=%@",stockcode];
//    
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    for (Stock *obj in arr)
//    {
//        [mangedcontext deleteObject:obj];
//    }
//    [mangedcontext save:nil];
//    return ;
//}
//
//
//
//-(void)deletestockDD:(NSString *)stockcodeEx
//{
//    
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"StockDD"];
//    
//    //排序
//    //    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
//    //    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
//    fetch.predicate=[NSPredicate predicateWithFormat:@"stockcodeEx=%@",stockcodeEx];
//    
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    for (Stock *obj in arr)
//    {
//        [mangedcontext deleteObject:obj];
//    }
//    [mangedcontext save:nil];
//    return ;
//}
//
//-(void)deletestockDD
//{
//    
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"StockDD"];
//    
//    //排序
//    //    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
//    //    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
////    fetch.predicate=[NSPredicate predicateWithFormat:@"stockcodeEx=%@",stockcodeEx];
//    
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    for (Stock *obj in arr)
//    {
//        [mangedcontext deleteObject:obj];
//    }
//    [mangedcontext save:nil];
//    return ;
//}
//
//
//-(void)deletestock
//{
//    
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"Stock"];
//    
//    //排序
//    //    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"stockcode" ascending:NO];
//    //    fetch.sortDescriptors=@[sort];
//    //加入查询条件 age>20
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"stockcodeEx=%@",stockcodeEx];
//    
//    //    fetch.predicate=[NSPredicate predicateWithFormat:@"name like %@",@"*cb1*"];
//    NSArray *arr=[mangedcontext executeFetchRequest:fetch error:nil];
//    for (Stock *obj in arr)
//    {
//        [mangedcontext deleteObject:obj];
//    }
//    [mangedcontext save:nil];
//    return ;
//}


@end

