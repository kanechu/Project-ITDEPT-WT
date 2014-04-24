//
//  SearchPortNameViewController.h
//  worldtrans
//
//  Created by itdept on 14-4-23.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchPortNameViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSMutableArray *ilist_portname;
@property (strong,nonatomic) id iobj_target;
@property (nonatomic, assign) SEL isel_action;
@property (nonatomic,copy)NSString *is_placeholder;


@property (weak, nonatomic) IBOutlet UISearchBar *is_search_portName;
@property (weak, nonatomic) IBOutlet UITableView *it_table_portname;


- (IBAction)fn_click_close:(id)sender;

@end
