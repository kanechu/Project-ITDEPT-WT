//
//  DetailScheduleViewController.h
//  worldtrans
//
//  Created by itdept on 14-4-19.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailScheduleViewController : UITableViewController<UISearchBarDelegate>

@property (strong,nonatomic) NSMutableArray *ilist_schedule;
@property (strong,nonatomic) NSMutableDictionary *imd_searchDic;
@property (strong,nonatomic) NSMutableDictionary *imd_searchDic1;
@property (weak, nonatomic) IBOutlet UISearchBar *is_seach_bar;
@property (weak, nonatomic) IBOutlet UIButton *ibtn_sortBy_btn;

- (IBAction)fn_click_sortBy_btn:(id)sender;


@end
