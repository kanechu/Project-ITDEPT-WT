//
//  SortByViewController.h
//  worldtrans
//
//  Created by itdept on 14-4-21.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortByViewController : UITableViewController
@property (strong,nonatomic)NSArray *imt_sort_list;
@property (strong,nonatomic)NSArray *imt_sort_key;

@property (strong,nonatomic) id iobj_target;
@property (nonatomic, assign) SEL isel_action;

@property (weak, nonatomic) IBOutlet UIButton *ibt_cancel_btn;

- (IBAction)fn_disappear_sortBy:(id)sender;
@end
