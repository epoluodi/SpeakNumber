//
//  setting.h
//  SpeakNumber
//
//  Created by 程嘉雯 on 15/10/31.
//  Copyright © 2015年 com.epoluodi. All rights reserved.
//

//[db addData:@"speakInterval" value:@"2" group:@"默认"];
////几组
//[db addData:@"groups" value:@"4" group:@"默认"];
////每组数量
//[db addData:@"groupincount" value:@"10" group:@"默认"];
////每组休息时间
//[db addData:@"grouprest" value:@"30" group:@"默认"];
////每组休息类型
//[db addData:@"resttype" value:@"1" group:@"默认"];

struct settingstruct{
    int speakInterval;
    int groups;
    int groupincount;
    int grouprest;
    int resttype;

};

enum resttype:int{
    unchange,ncrease,
};

typedef struct settingstruct settingConfig;
typedef enum resttype  restenum;