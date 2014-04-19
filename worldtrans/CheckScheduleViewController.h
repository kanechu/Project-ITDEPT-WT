//
//  CheckScheduleViewController.h
//  worldtrans
//
//  Created by itdept on 14-4-18.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckScheduleViewController : UITableViewController
@property(strong,nonatomic) NSMutableArray *ilist_schedule;
- (IBAction)fn_click_searchBtn:(id)sender;

@end
