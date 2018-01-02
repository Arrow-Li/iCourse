//
//  ViewController.h
//  SchoolTable
//
//  Created by 盼头 on 17/3/18.
//  Copyright © 2017 盼头. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *stu_id;
@property (weak, nonatomic) IBOutlet UITextField *stu_passwd;
@property (weak, nonatomic) IBOutlet UIButton *get_btu;
@property (weak, nonatomic) IBOutlet UITextField *week;

@property NSFileHandle *file_data,*file_week;
@property NSString *doc_path,*week_path;

@end

