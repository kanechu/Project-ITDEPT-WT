//
//  CheckScheduleViewController.h
//  worldtrans
//
//  Created by itdept on 14-4-18.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
@interface CheckScheduleViewController : UITableViewController<kDropDownListViewDelegate>{
    //下拉列表数据
    NSArray *ia_listData;
    //下拉列表视图
    DropDownListView *iddl_drop_view;
}
//搜索的条件，放到一个字典中
@property (strong,nonatomic) NSMutableDictionary *imd_searchDic;
@property (strong,nonatomic) NSArray *ia_listData;
@property (strong,nonatomic) DropDownListView *iddl_drop_view;
@property (strong,nonatomic) NSMutableArray *ilist_schedule;
@property (copy,nonatomic)NSString *is_dataType;

- (IBAction)fn_click_searchBtn:(id)sender;
- (IBAction)fn_dropdown_btn:(id)sender;

- (IBAction)fn_click_subBtn:(id)sender;
- (IBAction)fn_click_addBtn:(id)sender;

@end
