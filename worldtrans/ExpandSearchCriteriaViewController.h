//
//  ExpandSearchCriteriaViewController.h
//  worldtrans
//
//  Created by itdept on 14-5-9.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableView.h"
#import "Custom_SearchBtn.h"
@class DB_searchCriteria;
@interface ExpandSearchCriteriaViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,SKSTableViewDelegate>
//存储搜索标准数据的数据库
@property(nonatomic,strong) DB_searchCriteria *db;
//存储搜索标准数据
@property(nonatomic,strong)NSMutableArray *alist_searchCriteria;
//存储搜索标准的组名
@property(nonatomic,strong)NSMutableArray *alist_groupName;
//存储过滤后的搜索标准数据
@property(nonatomic,strong)NSMutableArray *alist_filtered_data;
//用来标记哪一个UITextfield；
@property(nonatomic)UITextField *checkText;

//计算分区的行数
@property (assign,nonatomic)NSInteger section1_rows;
@property (assign,nonatomic)NSInteger section2_rows;

//标识必填项的key
@property (strong,nonatomic)NSMutableArray *flag_mandatory_key;

//搜索的条件，放到一个字典中
@property (strong,nonatomic) NSMutableDictionary *imd_searchDic;
@property (strong,nonatomic) NSMutableDictionary *imd_searchDic1;
//dateType下拉列表数据
@property (strong,nonatomic) NSMutableArray *ia_listData;
@property (strong,nonatomic) UIPickerView *ipic_drop_view;
@property (strong,nonatomic) NSMutableArray *ilist_dateType;

//用来记录选择的datetype所在的行数
@property (assign,nonatomic)NSInteger select_row;
//用来记录选择的portname
@property (copy,nonatomic)NSMutableDictionary *idic_portname;
//用来记录选择的discharge portname
@property (copy,nonatomic)NSMutableDictionary *idic_dis_portname;
@property (strong,nonatomic)UIDatePicker *idp_picker;
//id_startdate用来记录日期拾取器获取的日期
@property (copy,nonatomic)NSDate *id_startdate;

@property (weak, nonatomic) IBOutlet Custom_SearchBtn *ibt_search_btn;

@property (weak, nonatomic) IBOutlet SKSTableView *skstableView;

- (IBAction)fn_click_portBtn:(id)sender;

- (IBAction)fn_click_subBtn:(id)sender;
- (IBAction)fn_click_addBtn:(id)sender;

- (IBAction)fn_click_searchBtn:(id)sender;
- (IBAction)fn_click_textfield:(id)sender;
- (IBAction)fn_click_day:(id)sender;
- (IBAction)fn_begin_click_day:(id)sender;
@end
