//
//  Course.m
//  SchoolTable
//
//  Created by 盼头 on 17/3/20.
//  Copyright © 2017 盼头. All rights reserved.
//

#import "Course.h"

@implementation Course

-(void)setValue:(NSArray *)arr{
    //导入课程信息
    name=[arr objectAtIndex:0];
    NSString *temp_str=[arr objectAtIndex:1];
    t_name=[arr objectAtIndex:2];
    position=[arr objectAtIndex:3];
    week=[temp_str substringToIndex:2];
    temp_str=[temp_str substringFromIndex:2];
    NSUInteger pos=[temp_str rangeOfString:@"节"].location;
    NSString *str_times=[[temp_str substringToIndex:pos] substringFromIndex:1];
    NSString *str_weeks=[temp_str substringFromIndex:pos+3];
    str_weeks=[str_weeks substringToIndex:[str_weeks rangeOfString:@"周"].location];
    NSArray *temp_arr=[str_times componentsSeparatedByString:@","];
    t_start=[[temp_arr objectAtIndex:0] intValue];
    t_end=[[temp_arr objectAtIndex:1] intValue];
    temp_arr=[str_weeks componentsSeparatedByString:@"-"];
    c_start=[[temp_arr objectAtIndex:0] intValue];
    c_end=[[temp_arr objectAtIndex:1] intValue];
}

-(BOOL) matchWeek:(NSString *)w week:(int)nw{
    if([w isEqualToString:week]){
        if(nw>=c_start&&nw<=c_end){
            return YES;
        }
        else{
            return NO;
        }
    }
    else{
        return NO;
    }
}

@end
