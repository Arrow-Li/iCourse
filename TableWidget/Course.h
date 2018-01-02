//
//  Course.h
//  SchoolTable
//
//  Created by 盼头 on 17/3/20.
//  Copyright © 2017 盼头. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject{
    @public
    NSString *name,*t_name,*position,*week;
    int t_start,t_end,c_start,c_end;
}

-(void) setValue:(NSArray *)arr;
-(BOOL) matchWeek:(NSString *)w week:(int)nw;

@end
