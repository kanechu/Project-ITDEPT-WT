//
//  SearchCriteriaViewController.h
//  worldtrans
//
//  Created by itdept on 14-5-5.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCriteriaViewController : UITableViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

//计算分区的行数
@property (assign,nonatomic)NSInteger section1_rows;
@property (assign,nonatomic)NSInteger section2_rows;
//统计每个分区的搜索标准
@property (strong,nonatomic)NSMutableArray *alist_searchCriteria_section1;
@property (strong,nonatomic)NSMutableArray *alist_searchCriteria_section2;
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

@property (weak, nonatomic) IBOutlet UIButton *ibt_search_btn;

- (IBAction)fn_click_portBtn:(id)sender;

- (IBAction)fn_click_subBtn:(id)sender;
- (IBAction)fn_click_addBtn:(id)sender;

- (IBAction)fn_click_searchBtn:(id)sender;
- (IBAction)fn_click_textfield:(id)sender;
- (IBAction)fn_click_day:(id)sender;
- (IBAction)fn_begin_click_day:(id)sender;

@end
