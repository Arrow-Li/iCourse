//
//  ViewController.m
//  SchoolTable
//
//  Created by 盼头 on 17/3/18.
//  Copyright © 2017 盼头. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _stu_id.text=@"";
    _stu_passwd.text=@"";
    _week.text=@"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getdata:(UIButton *)sender {
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.table"];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/data.in"];
    //NSLog(@"%@", containerURL);
    if ([_stu_id.text isEqual:@""]||[_stu_passwd.text isEqual:@""]) {
        //NSLog(@"empty input!");
        return;
    }
    [_file_data truncateFileAtOffset:0];
    NSString *url=@"http://www.arrowli.cn:8000/get?name=";
    url=[url stringByAppendingString:_stu_id.text];
    url=[url stringByAppendingString:@"&passwd="];
    url=[url stringByAppendingString:_stu_passwd.text];
    //NSLog(url);
    NSURL *u=[[NSURL alloc]initWithString:url];
    NSData *data=[NSData dataWithContentsOfURL:u];
    _stu_id.text=@"";
    _stu_passwd.text=@"";
    NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    [arr writeToURL:containerURL atomically:YES];
}

- (IBAction)getweek:(UIButton *)sender {
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.table"];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/week.in"];
    if ([_week.text isEqual:@""]) {
        return;
    }
    [_week.text writeToURL:containerURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
    containerURL=[[NSFileManager defaultManager]containerURLForSecurityApplicationGroupIdentifier:@"group.com.table"];
    
    NSDate *time=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"YYYY-MM-dd zzz"];
    NSString *str_time=[dateformatter stringFromDate:time];
    containerURL=[containerURL URLByAppendingPathComponent:@"Library/time.in"];
    [str_time writeToURL:containerURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
    //打印当前周
    //printf("%d",now_week);
}

@end
