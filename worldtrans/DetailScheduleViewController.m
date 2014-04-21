//
//  DetailScheduleViewController.m
//  worldtrans
//
//  Created by itdept on 14-4-19.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "DetailScheduleViewController.h"
#import "MZFormSheetController.h"
#import "SortByViewController.h"
#import "Cell_detail_schedule.h"

#import "RequestContract.h"
#import "AppConstants.h"
#import "SearchFormContract.h"
#import "DB_login.h"
#import "Web_base.h"
#import "NSArray.h"
#import "RespSchedule.h"
#import "MBProgressHUD.h"
@interface DetailScheduleViewController ()

@end

@implementation DetailScheduleViewController
@synthesize ilist_schedule;
@synthesize imd_searchDic;

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
    _fn_click_sortBy_btn.style=UIBarButtonSystemItemCamera;
    //searchBar的代理
    _is_seach_bar.delegate=self;
    [self fn_get_data:imd_searchDic];
    
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    if (ilist_schedule==nil || ilist_schedule==NULL) {
        return 0;
    }else{
        return [ilist_schedule count];
        [self.tableView reloadData];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_detail_schedule";
    Cell_detail_schedule *cell=[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"Cell_detail_schedule" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSMutableDictionary *ldict_dictionary=[[NSMutableDictionary alloc]init];
    ldict_dictionary=[ilist_schedule objectAtIndex:indexPath.row]
    ;
    cell.ilb_vessel_voyage.text=[ldict_dictionary valueForKey:@"vessel_voyage"];
    cell.ilb_wh_address.text=[ldict_dictionary valueForKey:@"carrier_name"];
    cell.ilb_cyCut.text=[NSString stringWithFormat:@"CY Cut:%@",[ldict_dictionary valueForKey:@"cy_cut"]];
    cell.ilb_cfsCut.text=[NSString stringWithFormat:@"CFS Cut:%@",[ldict_dictionary valueForKey:@"cfs_cut"]];
    cell.ilb_etd.text=[NSString stringWithFormat:@"ETD:%@",[ldict_dictionary valueForKey:@"etd"]];
    cell.ilb_eta.text=[NSString stringWithFormat:@"ETA:%@",[ldict_dictionary valueForKey:@"eta"]];
    cell.ilb_tt.text=[NSString stringWithFormat:@"T/T:%@",[ldict_dictionary valueForKey:@"port_tt"]];
    cell.ilb_load_port.text=[ldict_dictionary valueForKey:@"load_port"];
    cell.ilb_dish_port.text=[ldict_dictionary valueForKey:@"port_name"];
    // Configure the cell...
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (ilist_schedule==nil||ilist_schedule==NULL||ilist_schedule.count==0) {
        return 40;
    }else{
        return 165;
    }
}
#pragma mark popView
-(void)PopupView:(UIViewController*)VC Size:(CGSize) sheetSize{
    MZFormSheetController *formSheet=[[MZFormSheetController alloc]initWithViewController:VC];
    //弹出视图的大小
    formSheet.presentedFormSheetSize=sheetSize;
    formSheet.shadowRadius = 2.0;
    //阴影的不透明度
    formSheet.shadowOpacity = 0.3;
    //Yes是点击背景任何地方，弹出视图都消失,反之为No.默认为NO
    formSheet.shouldDismissOnBackgroundViewTap = NO;
    //中心垂直，默认为NO
    formSheet.shouldCenterVertically =YES;
    formSheet.movementWhenKeyboardAppears = MZFormSheetWhenKeyboardAppearsCenterVertically;
    [self mz_presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController){}];
    
}

- (IBAction)fn_click_sortBy_btn:(id)sender {
    SortByViewController *sortByVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SortByViewController"];
    [self PopupView:sortByVC Size:CGSizeMake(250, 300)];
}

#pragma mark UISearchBarDelegate
//点击搜索按钮的cancel，键盘收起
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    [_is_seach_bar resignFirstResponder];
}
//点击搜索的时候，触发的事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}
-(void)fn_get_data:(NSMutableDictionary*)as_search_dic{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    RequestContract *req_form=[[RequestContract alloc]init];
    DB_login *dbLogin=[[DB_login alloc]init];
    req_form.Auth=[dbLogin WayOfAuthorization];
    
     SearchFormContract *search=[[SearchFormContract alloc]init];
     search.os_column=@"load_port";
     search.os_value=[as_search_dic valueForKey:@"load_port"];
     
     SearchFormContract *search1=[[SearchFormContract alloc]init];
     search1.os_column=@"dish_port";
     search1.os_value=[as_search_dic valueForKey:@"dish_port"];
     
     SearchFormContract *search2=[[SearchFormContract alloc]init];
     search2.os_column=@"datetype";
     search2.os_value=[as_search_dic valueForKey:@"datetype"];
     
     SearchFormContract *search3=[[SearchFormContract alloc]init];
     search3.os_column=@"datefm";
     search3.os_value=[as_search_dic valueForKey:@"datefm"];
     
     SearchFormContract *search4=[[SearchFormContract alloc]init];
     search4.os_column=@"dateto";
     search4.os_value=[as_search_dic valueForKey:@"dateto"];    req_form.SearchForm=[NSSet setWithObjects:search,search1,search2,search3,search4, nil];
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
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

@end
