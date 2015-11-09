//
//  Config.h
//  SpeakNumber
//
//  Created by 程嘉雯 on 15/10/31.
//  Copyright © 2015年 com.epoluodi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Config : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
@property (nullable, nonatomic, retain) NSString *var;
@property (nullable, nonatomic, retain) NSString *value;
@property (nullable, nonatomic, retain) NSString *group;

@end

NS_ASSUME_NONNULL_END


