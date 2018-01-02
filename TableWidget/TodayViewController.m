//
//  TodayViewController.m
//  TableWidget
//
//  Created by 盼头 on 17/3/18.
//  Copyright © 2017 盼头. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "Course.h"

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //data.in is json file
    
    //获取当前周数
    _current_week=[self getweek4group];
    //获取课表数据
    _table_data=[self getdata4group];
    //获取当天课程
    NSMutableArray *t_course=[self today_course:[self weekFromDate:[NSDate date]] data:[self create_courselist:_table_data] week:_current_week];
    //当天节数
    _num=(int)[t_course count];
    [self show:t_course];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    //NSLog(@"fresh!"); //刷新内容的方法
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

-(void)show:(NSMutableArray*)today{
    [self set_UI:(Course *)[today objectAtIndex:0] withNum:1];
    [self set_UI:(Course *)[today objectAtIndex:1] withNum:2];
    _week.text=[NSString stringWithFormat:@"%d",_current_week];
}

-(void)set_UI:(Course *)c withNum:(int)i{
    ((UILabel*)[self valueForKey:[NSString stringWithFormat:@"c%d",i]]).text=c->name;
    ((UILabel*)[self valueForKey:[NSString stringWithFormat:@"c%dt",i]]).text=[NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"%d-",c->t_start],[NSString stringWithFormat:@"%d",c->t_end]];
    ((UILabel*)[self valueForKey:[NSString stringWithFormat:@"c%dp",i]]).text=c->position;
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        if(_num>2){
            self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 220);
            return;
        }
    }
    self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 110);
}

-(NSMutableArray *)today_course:(NSString *)today_w data:(NSMutableArray *)c_data week:(int)now_w{
    NSMutableArray *today_c=[NSMutableArray array];
    for (NSObject *c_i in c_data) {
        if([(Course*)c_i matchWeek:today_w week:now_w]){
            [today_c addObject:c_i];
        }
    }
    return today_c;
}

-(NSMutableArray *)create_courselist:(NSArray *)data{
    //生成所有课程类
    NSMutableArray *course_list=[NSMutableArray array];
    for (NSObject * course_i in data) {
        NSArray *arr=[(NSString *)course_i componentsSeparatedByString:@"|"];
        if ([arr count]>4) {
            Course *new_course1=[[Course alloc]init];
            Course *new_course2=[[Course alloc]init];
            [new_course1 setValue:[NSArray arrayWithObjects:[arr objectAtIndex:0],[arr objectAtIndex:1],[arr objectAtIndex:2],[arr objectAtIndex:3], nil]];
            [new_course2 setValue:[NSArray arrayWithObjects:[arr objectAtIndex:4],[arr objectAtIndex:5],[arr objectAtIndex:6],[arr objectAtIndex:7], nil]];
            [course_list addObject:new_course1];
            [course_list addObject:new_course2];
        }
        else{
            Course *new_course=[[Course alloc]init];
            [new_course setValue:arr];
            [course_list addObject:new_course];
        }
    }
    return course_list;
}

- (NSArray *)getdata4group{
    //获取课表数据
    NSURL *containerURL=[[NSFileManager defaultManager]containerURLForSecurityApplicationGroupIdentifier:@"group.com.table"];
    containerURL=[containerURL URLByAppendingPathComponent:@"Library/data.in"];
    NSArray *table_data=[NSArray arrayWithContentsOfURL:containerURL];
    return table_data;
}

- (int)getweek4group{
    //获取当前周
    NSURL *containerURL=[[NSFileManager defaultManager]containerURLForSecurityApplicationGroupIdentifier:@"group.com.table"];
    containerURL=[containerURL URLByAppendingPathComponent:@"Library/week.in"];
    NSString *str_week=[NSString stringWithContentsOfURL:containerURL encoding:NSUTF8StringEncoding error:nil]; //设定周
    
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"YYYY-MM-dd zzz"];
    containerURL=[[NSFileManager defaultManager]containerURLForSecurityApplicationGroupIdentifier:@"group.com.table"];
    containerURL=[containerURL URLByAppendingPathComponent:@"Library/time.in"];
    NSString *day=[NSString stringWithContentsOfURL:containerURL encoding:NSUTF8StringEncoding error:nil];
    NSDate *set_day=[dateformatter dateFromString:day];
    NSDate *now_day=[NSDate date];
    NSInteger interval=[[NSTimeZone systemTimeZone]secondsFromGMTForDate:now_day];
    set_day=[set_day dateByAddingTimeInterval:interval];
    now_day=[now_day dateByAddingTimeInterval:interval];
    double d_value=[now_day timeIntervalSince1970]-[set_day timeIntervalSince1970];
    return [str_week intValue]+(int)(d_value/60/60/24/7);
}

- (NSString*)weekFromDate:(NSDate*)inputDate {
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}

@end
