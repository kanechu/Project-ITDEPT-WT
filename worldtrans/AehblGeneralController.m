//
//  AehblGeneralController.m
//  worldtrans
//
//  Created by itdept on 14-3-14.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import "AehblGeneralController.h"
#import "RespAehbl.h"
#import "Cell_exhbl_general_detail.h"
#import "Cell_exhbl_general_hdr.h"
#import "Res_color.h"
#import "Web_base.h"
#import "MapViewController.h"
#import "MBProgressHUD.h"
#import "Calculate_lineHeight.h"
#import "DB_login.h"
enum ROW_NUMOFSECTION {
    ROW_NUM1 = 8,
    RoW_NUM2 = 6
};
@interface AehblGeneralController ()

@property(nonatomic,strong)Calculate_lineHeight *calulate_obj;
@property (strong,nonatomic) NSMutableArray *ilist_aehbl;
@property (strong,nonatomic)DB_login *dbLogin;
@property (assign,nonatomic)NSInteger flag_isTimeout;
@end

@implementation AehblGeneralController
@synthesize is_search_column;
@synthesize is_search_value;
@synthesize calulate_obj;
@synthesize ilist_aehbl;
@synthesize dbLogin;

- (void)viewDidLoad
{
    [self fn_get_related_obj];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)fn_get_related_obj{
    self.dbLogin =[[DB_login alloc]init];
    calulate_obj=[[Calculate_lineHeight alloc]init];
    self.view.backgroundColor = [UIColor blackColor];
    CheckNetWork *check_obj=[[CheckNetWork alloc]init];
    if ([check_obj fn_isPopUp_alert]==NO) {
        [self fn_get_data:is_search_column :is_search_value];
    }
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([dbLogin isLoginSuccess] && ilist_aehbl!=nil && ilist_aehbl!=NULL) {
        return ROW_NUM1;
    }else if(ilist_aehbl!=nil && ilist_aehbl!=NULL){
        return RoW_NUM2;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ls_TableIdentifier = @"cell_aehbl_general_detail";
   
    Cell_exhbl_general_detail *cell = (Cell_exhbl_general_detail *)[self.tableView dequeueReusableCellWithIdentifier:ls_TableIdentifier];
    cell.accessoryType=UITableViewCellAccessoryNone;
    NSString *ls_os_value = @"";
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell_aehbl_general_detail" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.ilb_value.lineBreakMode=NSLineBreakByWordWrapping;
    cell.ilb_value.numberOfLines=0;
    NSMutableDictionary *ldict_dictionary = [ilist_aehbl objectAtIndex:0];    // Configure Cell
    
    if( [indexPath row] % 2)
        [cell setBackgroundColor:COLOR_DARK_JUNGLE_GREEN];
    else
        [cell setBackgroundColor:COLOR_EERIE_BLACK];
    
    if ( indexPath.row == 0)
    {
        cell.ilb_header.text = @" ETA";
        cell.ilb_value.text =[ldict_dictionary valueForKey:@"eta"];
    }
    if ( indexPath.row == 1)
    {
        cell.ilb_header.text = @"Load Port";
        cell.ilb_value.text = [ldict_dictionary valueForKey:@"load_port"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor=[UIColor clearColor];
    }
    if ( indexPath.row == 2)
    {
        cell.ilb_header.text = @"Destination";
        cell.ilb_value.text =[ldict_dictionary valueForKey:@"dest_name"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor=[UIColor clearColor];
    }
    if ( indexPath.row == 3)
    {
                                  
        cell.ilb_header.text = @"PKG/ACT_KGS/CHRG_KGS";
        cell.ilb_value.text = [NSString stringWithFormat:@"%@ / %@/ %@", [ldict_dictionary valueForKey:@"hbl_pkg"], [ldict_dictionary valueForKey:@"hbl_act_cbm"], [ldict_dictionary valueForKey:@"hbl_chrg_cbm"]];
    }
    
    if ( indexPath.row == 4)
    {
        cell.ilb_header.text = @"Flight#/ Flight Date";
        cell.ilb_value.text =[NSString stringWithFormat:@"%@/%@",[ldict_dictionary valueForKey:@"flight_no"],[ldict_dictionary valueForKey:@"prt_flight_date"]];
    }
    if ( indexPath.row == 5)
    {
        ls_os_value = [ldict_dictionary valueForKey:@"status_desc"];
        if ([ls_os_value length] > 0 ){
            ls_os_value = [ls_os_value stringByAppendingString:[NSString stringWithFormat:@" / %@ ",[ldict_dictionary valueForKey:@"act_status_date"]]];
        }
        cell.ilb_header.text = @"Latest Status";
        cell.ilb_value.text = ls_os_value;
        
    }
    if ([dbLogin isLoginSuccess]) {
        if (indexPath.row==6) {
            cell.ilb_header.text = @"Shipper ";
            cell.ilb_value.text =[ldict_dictionary valueForKey:@"shpr_name"];
        }
        if (indexPath.row==7) {
            cell.ilb_header.text = @"Consignee";
            cell.ilb_value.text =[ldict_dictionary valueForKey:@"cnee_name"];
        }
    }
    cell.ilb_value.lineBreakMode=NSLineBreakByCharWrapping;
    CGFloat height=[calulate_obj fn_heightWithString:cell.ilb_value.text font:cell.ilb_value.font constrainedToWidth:cell.ilb_value.frame.size.width];
    [cell.ilb_value setFrame:CGRectMake(cell.ilb_value.frame.origin.x, cell.ilb_value.frame.origin.y, cell.ilb_value.frame.size.width, height)];
    return cell;
}
#pragma mark UITableViewDelegate
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"cell_aehbl_general_hdr";
    Cell_exhbl_general_hdr *headerView = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (headerView == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    NSMutableDictionary *ldict_dictionary = [ilist_aehbl objectAtIndex:0];    // Configure Cell
    NSString *title=[NSString stringWithFormat:@"%@ / %@", [ldict_dictionary valueForKey:@"so_no"], [ldict_dictionary valueForKey:@"hbl_no"]];
    headerView.ilb_display_no.text =title;
    CGFloat height=[calulate_obj fn_heightWithString:title font:headerView.ilb_display_no.font constrainedToWidth:headerView.ilb_display_no.frame.size.width];
    if (height<21) {
        height=21;
    }
    [headerView.ilb_display_no setFrame:CGRectMake(headerView.ilb_display_no.frame.origin.x, headerView.ilb_display_no.frame.origin.y, headerView.ilb_display_no.frame.size.width, height)];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (ilist_aehbl==nil) {
        return 0;
    }else{
        static NSString *CellIdentifier = @"cell_aehbl_general_hdr";
        Cell_exhbl_general_hdr *headerView = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        NSMutableDictionary *ldict_dictionary = [ilist_aehbl objectAtIndex:0];     // Configure Cell
        
        headerView.ilb_display_no.text =[NSString stringWithFormat:@"%@ / %@", [ldict_dictionary valueForKey:@"so_no"], [ldict_dictionary valueForKey:@"hbl_no"]];
        CGFloat height=[calulate_obj fn_heightWithString:headerView.ilb_display_no.text font:headerView.ilb_display_no.font constrainedToWidth:headerView.ilb_display_no.frame.size.width];
        if (height<21) {
            height=21;
        }
        if(section == 1 )
            return 0.000001f;
        else return 81+height; // put 22 in case of plain one..
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *ls_TableIdentifier = @"cell_aehbl_general_detail";
    Cell_exhbl_general_detail *cell = (Cell_exhbl_general_detail *)[self.tableView dequeueReusableCellWithIdentifier:ls_TableIdentifier];
    NSMutableDictionary *ldict_dictionary = [ilist_aehbl objectAtIndex:0];
    NSString *ls_os_value;
    if ( indexPath.row == 5)
    {
        ls_os_value = [ldict_dictionary valueForKey:@"status_desc"];
        if ([ls_os_value length] > 0 ){
            ls_os_value = [ls_os_value stringByAppendingString:[NSString stringWithFormat:@" / %@, ",[ldict_dictionary valueForKey:@"act_status_date"]]];
        }
    }
    if ([dbLogin isLoginSuccess]) {
        if (indexPath.row==6) {
            ls_os_value =[ldict_dictionary valueForKey:@"shpr_name"];
        }
        if (indexPath.row==7) {
            ls_os_value =[ldict_dictionary valueForKey:@"cnee_name"];
        }
    }
   CGFloat height=[calulate_obj fn_heightWithString:ls_os_value font:cell.ilb_value.font constrainedToWidth:cell.ilb_value.frame.size.width];
    height=height+23+10;
    if (height<50) {
        height=50;
    }
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

   NSMutableDictionary * ldict_dictionary = [ilist_aehbl objectAtIndex:0];
    MapViewController *mapVC=nil;
    mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    if ([indexPath row]==1) {
        mapVC.adress_name=[ldict_dictionary valueForKey:@"load_port"];
    
    }else if ([indexPath row]==2){
        mapVC.adress_name=[ldict_dictionary valueForKey:@"dest_name"];
    }
    [self.navigationController pushViewController:mapVC animated:YES];
}
#pragma mark -NetWork Request
- (void) fn_get_data: (NSString*)as_search_column :(NSString*)as_search_value
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NSTimer scheduledTimerWithTimeInterval:60.0f target:self selector:@selector(fn_timeout_handle) userInfo:nil repeats:NO];
    RequestContract *req_form = [[RequestContract alloc] init];
    req_form.Auth =[dbLogin WayOfAuthorization];
    SearchFormContract *search = [[SearchFormContract alloc]init];
    search.os_column =as_search_column;
    search.os_value =as_search_value ;
    
    req_form.SearchForm = [NSSet setWithObjects:search, nil];
    
    Web_base *web_base = [[Web_base alloc] init];
    web_base.il_url =STR_AIR_URL;
    web_base.iresp_class =[RespAehbl class];
    web_base.ilist_resp_mapping =[NSArray arrayWithPropertiesOfObject:[RespAehbl class]];
    web_base.iobj_target = self;
    web_base.isel_action = @selector(fn_save_aehbl_list:);
    [web_base fn_get_data:req_form];
    
}

- (void) fn_save_aehbl_list: (NSMutableArray *) alist_result {
    if (_flag_isTimeout!=1) {
        ilist_aehbl = alist_result;
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _flag_isTimeout=2;
    }
}
-(void)fn_timeout_handle{
    if (_flag_isTimeout!=2) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"Network requests data timeout !" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:@"Cancel", nil];
        [alertView show];
        _flag_isTimeout=1;
    }
}
#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        CheckNetWork *check_obj=[[CheckNetWork alloc]init];
        if ([check_obj fn_isPopUp_alert]==NO) {
            [self fn_get_data:is_search_column :is_search_value];
        }
        _flag_isTimeout=0;
    }
}
@end
