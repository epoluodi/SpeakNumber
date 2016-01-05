//
//  groupcell.m
//  SpeakNumber
//
//  Created by Stereo on 16/1/5.
//  Copyright © 2016年 com.epoluodi. All rights reserved.
//

#import "groupcell.h"

@implementation groupcell
@synthesize groupname,groups,counts;

- (void)awakeFromNib {
    // Initialization code
    groupname.textColor=[UIColor whiteColor];
    groups.textColor= [UIColor greenColor];
    counts.textColor = [UIColor yellowColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
