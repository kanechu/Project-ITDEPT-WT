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

- (IBAction)fn_disappear_sortBy:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ibt_cancel_btn;

@end
