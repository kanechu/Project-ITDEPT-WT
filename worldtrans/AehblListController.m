//
//  AehblListController.m
//  worldtrans
//
//  Created by itdept on 14-3-13.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import "AehblListController.h"
#import "AehblHomeController.h"

#import "MBProgressHUD.h"
#import "RespAehbl.h"
#import "Cell_aehbl_list.h"
#import "Res_color.h"
#import "DB_login.h"
#import "Web_base.h"
#import "NSString.h"
@interface AehblListController ()

@property(strong,nonatomic)NSMutableArray *ilist_aehbl;

@end
@implementation AehblListController
@synthesize ilist_aehbl;
@synthesize iSearchBar;
@synthesize is_search_no;
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
    UITabBarItem *tbi = (UITabBarItem*)[[[self.tabBarController tabBar] items] objectAtIndex:0];
    
    [tbi setBadgeValue:@"1"];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame=iSearchBar.bounds;
    
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor]CGColor], (id)[[UIColor whiteColor]CGColor], nil];
    [iSearchBar.layer insertSublayer:gradient atIndex:0];
    self.view.backgroundColor = [UIColor blackColor];
    iSearchBar.delegate = (id)self;
    [self fn_setExtraCellLineHidden];
    CheckNetWork *check_obj=[[CheckNetWork alloc]init];
    if ([check_obj fn_isPopUp_alert]==NO) {
         [self fn_get_data:is_search_no];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ilist_aehbl count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ls_TableIdentifier = @"cell_aehbl_list";
    
    Cell_aehbl_list *cell = (Cell_aehbl_list *)[self.tableView dequeueReusableCellWithIdentifier:ls_TableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell_aehbl_list" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    RespAehbl *lespAehbl = [ilist_aehbl objectAtIndex:indexPath.row];    // Configure Cell
    
    NSMutableDictionary *ldict_dictionary = [ilist_aehbl objectAtIndex:indexPath.row];    // Configure Cell
    
    if( [indexPath row] % 2)
        [cell setBackgroundColor:COLOR_DARK_JUNGLE_GREEN];
    else
        [cell setBackgroundColor:COLOR_EERIE_BLACK];
    
    cell.ilb_hbl_no.text =[NSString nullConvertEmpty:lespAehbl.hbl_no];
    cell.ilb_so_no.text =[NSString nullConvertEmpty:lespAehbl.so_no];
    
    cell.ilb_load_port.text =[NSString nullConvertEmpty:[ldict_dictionary valueForKey:@"load_port"]];
    cell.ilb_dest_port.text=[NSString nullConvertEmpty:[ldict_dictionary valueForKey:@"dest_name"]];
    NSString *str=nil;
    if ([lespAehbl.flight_no length]==0||[lespAehbl.prt_flight_date length]==0) {
         str=[NSString stringWithFormat:@"%@%@", lespAehbl.flight_no,lespAehbl.prt_flight_date];
    }else{
        str=[NSString stringWithFormat:@"%@/%@", lespAehbl.flight_no,lespAehbl.prt_flight_date];
    }
   
    cell.ilb_flight_noAnddate.text=[NSString nullConvertEmpty:str];
    
    cell.ilb_status_latest.text=[NSString nullConvertEmpty:[ldict_dictionary valueForKey:@"status_desc"]];
    
    return cell;
}

#pragma mark -UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"cell_aehbl_header";
    UITableViewCell *headerView = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (headerView == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1 )
        return 0.000001f;
    else return 80; // put 22 in case of plain one..
}

- (void)tableView: (UITableView *)tableView
didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"segue_aehbl_home" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSString *ls_hbl_uid = @"";
    NSString *ls_so_uid = @"";
    NSString *ls_os_column = @"";
    NSString *ls_os_value = @"";
    NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
    
    NSMutableDictionary * ldict_dictionary = [ilist_aehbl objectAtIndex:selectedRowIndex.row];    // Configure Cell
    ls_hbl_uid = [ldict_dictionary valueForKey:@"hbl_uid"];
    ls_so_uid = [ldict_dictionary valueForKey:@"so_uid"];
    
    if ([ls_hbl_uid length] > 0) {
        ls_os_column = @"hbl_uid";
        ls_os_value = ls_hbl_uid;
    }
    else {
        
        ls_os_column = @"so_uid";
        ls_os_value = ls_so_uid;
    }
    
    if ([[segue identifier] isEqualToString:@"segue_aehbl_home"]) {
        AehblHomeController *aehblHomeController = [segue destinationViewController];
        aehblHomeController.is_search_column = ls_os_column;
        aehblHomeController.is_search_value = ls_os_value;
    }
}
-(void)fn_setExtraCellLineHidden{
    UIView *view=[[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor=[UIColor clearColor];
    [self.tableView setTableFooterView:view];
}
#pragma mark -NetWork Request
- (void) fn_get_data: (NSString*)as_search_no
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    RequestContract *req_form = [[RequestContract alloc] init];
    DB_login *dbLogin=[[DB_login alloc]init];
    req_form.Auth =[dbLogin WayOfAuthorization];
    dbLogin=nil;
    
    SearchFormContract *search = [[SearchFormContract alloc]init];
    search.os_column = @"search_no";
    search.os_value = as_search_no;
    
    req_form.SearchForm = [NSSet setWithObjects:search, nil];
    search=nil;
    
    Web_base *web_base = [[Web_base alloc] init];
    web_base.il_url =STR_AIR_URL;
    web_base.iresp_class =[RespAehbl class];
    web_base.ilist_resp_mapping =[NSArray arrayWithPropertiesOfObject:[RespAehbl class]];
    web_base.iobj_target = self;
    web_base.isel_action = @selector(fn_save_aehbl_list:);
    web_base.callBack = ^(BOOL isTimeOut){
        ilist_aehbl=nil;
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isTimeOut) {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"Network requests data timeout !" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
            [alertView show];
        }else{
            [self fn_show_tipView:@"Error occurs!"];
        }
    };
    [web_base fn_get_data:req_form];
    req_form=nil;
    web_base=nil;
}

- (void) fn_save_aehbl_list: (NSMutableArray *) alist_result {
    ilist_aehbl = alist_result;
    if ([alist_result count]==0) {
        [self fn_show_tipView:@"No Air Export Data"];
    }
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)fn_show_tipView:(NSString*)_str_msg{
    TipView *tip_view=[[TipView alloc]initWithFrame:self.view.frame];
    tip_view.str_msg=_str_msg;
    [self.tableView setTableFooterView:tip_view];
    [self.tableView setScrollEnabled:NO];
}
#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex!=[alertView cancelButtonIndex]) {
        CheckNetWork *check_obj=[[CheckNetWork alloc]init];
        if ([check_obj fn_isPopUp_alert]==NO) {
            if ([iSearchBar.text length]==0) {
                [self fn_get_data:is_search_no];
                
            }else{
                [self fn_get_data:iSearchBar.text];
            }
        }
        check_obj=nil;
    }
}

#pragma mark -UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self handleSearch:searchBar];
}

- (void)handleSearch:(UISearchBar *)searchBar {
    CheckNetWork *check_obj=[[CheckNetWork alloc]init];
    if ([check_obj fn_isPopUp_alert]==NO) {
        [self fn_get_data:searchBar.text];
    }
    
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    NSLog(@"User canceled search");
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
}

@end
