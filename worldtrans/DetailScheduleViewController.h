//
//  DetailScheduleViewController.h
//  worldtrans
//
//  Created by itdept on 14-4-19.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailScheduleViewController : UITableViewController<UISearchBarDelegate>{
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *fn_click_sortBy_btn;
- (IBAction)fn_click_sortBy_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *is_seach_bar;

@end
