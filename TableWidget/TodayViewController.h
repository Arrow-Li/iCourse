//
//  TodayViewController.h
//  TableWidget
//
//  Created by 盼头 on 17/3/18.
//  Copyright © 2017 盼头. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *test_line1;

@property int current_week,num;
@property NSArray *table_data;
@property (weak, nonatomic) IBOutlet UILabel *c1;
@property (weak, nonatomic) IBOutlet UILabel *c2;
@property (weak, nonatomic) IBOutlet UILabel *c1t;
@property (weak, nonatomic) IBOutlet UILabel *c2t;
@property (weak, nonatomic) IBOutlet UILabel *c1p;
@property (weak, nonatomic) IBOutlet UILabel *c2p;
@property (weak, nonatomic) IBOutlet UILabel *week;

@end
