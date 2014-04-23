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
@property (strong,nonatomic) NSArray *ilist_dateType;
//用来记录选择的dateType
@property (copy,nonatomic)NSString *is_dataType;
//用来记录选择的datetype所在的行数
@property (assign,nonatomic)NSInteger select_row;
//用来记录选择的portname
@property (copy,nonatomic)NSMutableDictionary *idic_portname;
//用来记录选择的discharge portname
@property (copy,nonatomic)NSMutableDictionary *idic_dis_portname;
@property (strong,nonatomic)UIDatePicker *idp_picker;
//is_startdate用来记录日期拾取器获取的日期
@property (copy,nonatomic)NSString *is_startdate;

@property (weak, nonatomic) IBOutlet UIButton *ibt_search_btn;

- (IBAction)fn_click_searchBtn:(id)sender;
- (IBAction)fn_dropdown_btn:(id)sender;

- (IBAction)fn_click_subBtn:(id)sender;
- (IBAction)fn_click_addBtn:(id)sender;

- (IBAction)fn_click_btn:(id)sender;


@end
