//
//  Groupinfo.h
//  SpeakNumber
//
//  Created by Stereo on 16/1/5.
//  Copyright © 2016年 com.epoluodi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>



@interface Groupinfo : NSManagedObject


@property (nullable, nonatomic, retain) NSString *dt;
@property (nullable, nonatomic, retain) NSString *groupname;
@property (nullable, nonatomic, retain) NSNumber *groups;
@property (nullable, nonatomic, retain) NSNumber *counts;
// Insert code here to declare functionality of your managed object subclass

@end


