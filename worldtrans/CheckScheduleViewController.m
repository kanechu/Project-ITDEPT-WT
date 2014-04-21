//
//  CheckScheduleViewController.m
//  worldtrans
//
//  Created by itdept on 14-4-18.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "CheckScheduleViewController.h"
#import "RequestContract.h"
#import "AppConstants.h"
#import "SearchFormContract.h"
#import "DB_login.h"
#import "Web_base.h"
#import "NSArray.h"
#import "RespSchedule.h"
#import "Cell_schedule_section1.h"
#import "Cell_schedule_section2_row1.h"
#import "Cell_schedule_section2_row3.h"
#import "DetailScheduleViewController.h"

#define NUMOFSECTION 2

@interface CheckScheduleViewController ()

@end
enum NUMOFROW {
    ROW1 = 2,
    ROW2 = 3
};
@implementation CheckScheduleViewController
@synthesize ia_listData;
@synthesize iddl_drop_view;
@synthesize ilist_schedule;
@synthesize is_dataType;
@synthesize imd_searchDic;

static NSInteger day=0;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //date type
    ia_listData=@[@"ETD  | value:ETD",@"ETA | ETA",@"CY Closing | CY",@"CFS Closing | CFS"];
    imd_searchDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    _ibt_search_btn.layer.cornerRadius=3;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark dropDownlist
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    iddl_drop_view = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    
    iddl_drop_view.delegate = self;
    
    [iddl_drop_view showInView:self.view animated:YES];
    //Set DropDown backGroundColor
    [iddl_drop_view SetBackGroundDropDwon_R:0.0 G:108.0 B:194.0 alpha:0.90];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    is_dataType=[ia_listData objectAtIndex:anIndex];
    [self.tableView reloadData];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    if ([touch.view isKindOfClass:[UIView class]]) {
        [iddl_drop_view fadeOut];
    }
}
- (IBAction)fn_dropdown_btn:(id)sender {
    [iddl_drop_view fadeOut];
    [self showPopUpWithTitle:@"DateType" withOption:ia_listData xy:CGPointMake(65, 150) size:CGSizeMake(225, 220) isMultiple:NO];
}

- (IBAction)fn_click_subBtn:(id)sender {
    day--;
    if (day<0) {
        day=0;
    }
    [self.tableView reloadData];
}

- (IBAction)fn_click_addBtn:(id)sender {
    day++;
    if (day>31) {
        day=31;
    }
    [self.tableView reloadData];
}

#pragma mark resquestData
-(void)fn_get_data:(NSMutableDictionary*)as_search_dic{
    RequestContract *req_form=[[RequestContract alloc]init];
    DB_login *dbLogin=[[DB_login alloc]init];
    req_form.Auth=[dbLogin WayOfAuthorization];
   
    SearchFormContract *search=[[SearchFormContract alloc]init];
    search.os_column=@"load_port";
    search.os_value=@"HKHKG";
    
    SearchFormContract *search1=[[SearchFormContract alloc]init];
    search1.os_column=@"dish_port";
    search1.os_value=@"LAX";
    
    SearchFormContract *search2=[[SearchFormContract alloc]init];
    search2.os_column=@"datetype";
    search2.os_value=@"etd";
    
    SearchFormContract *search3=[[SearchFormContract alloc]init];
    search3.os_column=@"datefm";
    search3.os_value=@"2013-01-01";
    
    SearchFormContract *search4=[[SearchFormContract alloc]init];
    search4.os_column=@"dateto";
    search4.os_value=@"2015-03-01";
    req_form.SearchForm=[NSSet setWithObjects:search,search1,search2,search3,search4, nil];
    Web_base *web_base=[[Web_base alloc]init];
    web_base.il_url =STR_SCHEDULE_URL;
    web_base.iresp_class =[RespSchedule class];
    
    web_base.ilist_resp_mapping =[NSArray arrayWithPropertiesOfObject:[RespSchedule     class]];
    web_base.iobj_target = self;
    web_base.isel_action = @selector(fn_save_schedule_list:);
    [web_base fn_get_data:req_form];
    
    
}
-(void)fn_save_schedule_list:(NSMutableArray*)alist_result{
    ilist_schedule=alist_result;
   
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 30;
    }
    if (section==1) {
        return 20;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"Location";
    }
    if (section==1) {
        return @"Date";
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return NUMOFSECTION;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return ROW1;
    }
    if (section==1) {
        return ROW2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"Cell_schedule_section1";
        Cell_schedule_section1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"Cell_schedule_section1" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        if (indexPath.row==0) {
            cell.ilb_port.text=@"Loading Port";
            [imd_searchDic setObject:cell.ilb_show_portName.text forKey:@"load_port"];
        }
        if (indexPath.row==1) {
            [cell.ibt_navigate_btn setImage:[UIImage imageNamed:@"navigate_down"] forState:UIControlStateNormal];
             cell.ilb_port.text=@"Discharge Port";
            [imd_searchDic setObject:cell.ilb_show_portName.text forKey:@"dish_port"];
        }
        
        return cell;
    }
    
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            static NSString *CellIdentifier = @"Cell_schedule_section2_row1";
            Cell_schedule_section2_row1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
            if (cell==nil) {
                NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"Cell_schedule_section2_row1" owner:self options:nil];
                cell=[nib objectAtIndex:0];
            }
            cell.itf_show_dateType.layer.cornerRadius=10;
            cell.itf_show_dateType.text=is_dataType;
            [imd_searchDic setObject:cell.itf_show_dateType.text forKey:@"datetype"];
            return cell;
        }
        if (indexPath.row==1) {
            static NSString *CellIdentifier = @"Cell_schedule_section1";
            Cell_schedule_section1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
            if (cell==nil) {
                NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"Cell_schedule_section1" owner:self options:nil];
                cell=[nib objectAtIndex:0];
            }
            [cell.ibt_navigate_btn setBackgroundImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
            [cell.ibt_navigate_btn setImage:nil forState:UIControlStateNormal];
            cell.ilb_port.text=@"Start Date";
            [imd_searchDic setObject:cell.ilb_show_portName.text forKey:@"datefm"];
            return cell;
        }
        if (indexPath.row==2) {
            static NSString *CellIdentifier = @"Cell_schedule_section2_row3";
            Cell_schedule_section2_row3 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
            if (cell==nil) {
                NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"Cell_schedule_section2_row3" owner:self options:nil];
                cell=[nib objectAtIndex:0];
            }
            [imd_searchDic setObject:cell.ict_show_days.text forKey:@"dateto"];
            cell.ict_show_days.text=[[NSString alloc]initWithFormat:@"%d",day ];
            return cell;
        }
    }
    
    // Configure the cell...
    return nil;
}
#pragma mark segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailScheduleViewController *VC=[segue destinationViewController];
    VC.imd_searchDic=self.imd_searchDic;
}

#pragma mark 点击search按钮后，开始按条件获取数据
- (IBAction)fn_click_searchBtn:(id)sender {
    [imd_searchDic setObject:@"LAX" forKey:@"dish_port"];
    [imd_searchDic setObject:@"HKHKG" forKey:@"load_port"];
    [imd_searchDic setObject:@"etd" forKey:@"datetype"];
    [imd_searchDic setObject:@"2013-01-01" forKey:@"datefm"];
    [imd_searchDic setObject:@"2015-03-01" forKey:@"dateto"];
    [self fn_get_data:imd_searchDic];
   
}



@end
