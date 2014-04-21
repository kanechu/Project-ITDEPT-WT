//
//  SortByViewController.h
//  worldtrans
//
//  Created by itdept on 14-4-21.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortByViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic)NSArray *imt_sort_list;
@property (weak, nonatomic) UITableView *it_sort_list;

- (IBAction)fn_disappear_sortBy:(id)sender;
@end
