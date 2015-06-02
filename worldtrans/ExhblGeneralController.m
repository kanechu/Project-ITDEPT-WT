
//
//  ExhblGeneralController.m
//  worldtrans
//
//  Created by itdept on 2/24/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "ExhblGeneralController.h"
#import "RespExhbl.h"
#import "Cell_exhbl_general_detail.h"
#import "Cell_exhbl_general_hdr.h"
#import "Res_color.h"
#import "Web_base.h"
#import "MapViewController.h"
#import "MBProgressHUD.h"
#import "Calculate_lineHeight.h"
#import "DB_login.h"
enum ROW_NUMOFSECTION {
    ROW_NUM1 = 10,
    RoW_NUM2 = 6
};
@interface ExhblGeneralController ()

@property(nonatomic,strong)Calculate_lineHeight *calulate_obj;
@property (strong,nonatomic) NSMutableArray *ilist_exhbl;
@property (strong,nonatomic)DB_login *dbLogin;

@end

@implementation ExhblGeneralController

@synthesize is_search_column;
@synthesize is_search_value;

@synthesize ilist_exhbl;
@synthesize dbLogin;
@synthesize calulate_obj;

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
    CheckNetWork *check_obj=[[CheckNetWork alloc]init];
    if ([check_obj fn_isPopUp_alert]== NO) {
        [self fn_get_data:is_search_column :is_search_value];
    }
}
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([dbLogin isLoginSuccess] && [ilist_exhbl count]!=0) {
        return ROW_NUM1;
    }else if([ilist_exhbl count]!=0){
         return RoW_NUM2;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ls_TableIdentifier = @"cell_exhbl_general_detail";
    NSString *ls_os_value = @"", *ls_os_column = @"";
    
    Cell_exhbl_general_detail *cell = (Cell_exhbl_general_detail *)[self.tableView dequeueReusableCellWithIdentifier:ls_TableIdentifier];
    cell.accessoryType=UITableViewCellAccessoryNone;
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell_exhbl_general_detail" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSMutableDictionary *ldict_dictionary = [ilist_exhbl objectAtIndex:0];    // Configure Cell
    
    if( [indexPath row] % 2)
        [cell setBackgroundColor:COLOR_DARK_JUNGLE_GREEN];
    else
        [cell setBackgroundColor:COLOR_EERIE_BLACK];
    
    cell.ilb_value.lineBreakMode=NSLineBreakByWordWrapping;
    cell.ilb_value.numberOfLines=0;
    if ( indexPath.row == 0)
    {
        cell.ilb_header.text = @"ETD / ETA";
        if ([[ldict_dictionary valueForKey:@"etd"] length]==0 || [[ldict_dictionary valueForKey:@"eta"] length]==0) {
            cell.ilb_value.text = [NSString stringWithFormat:@"%@  %@", [ldict_dictionary valueForKey:@"etd"], [ldict_dictionary valueForKey:@"eta"]];
        }else{
            cell.ilb_value.text = [NSString stringWithFormat:@"%@ / %@", [ldict_dictionary valueForKey:@"etd"], [ldict_dictionary valueForKey:@"eta"]];
        }
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
        cell.ilb_value.text = [ldict_dictionary valueForKey:@"dest_name"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor=[UIColor clearColor];
    }
    if ( indexPath.row == 3)
    {
        NSString *ls_no_of_cntr_1 = [ldict_dictionary valueForKey:@"no_of_cntr_1"];
        NSInteger li_no_of_cntr_1 = [ls_no_of_cntr_1 integerValue];
        NSString *ls_no_of_cntr_2 = [ldict_dictionary valueForKey:@"no_of_cntr_2"];
        NSInteger li_no_of_cntr_2 = [ls_no_of_cntr_2 integerValue];
        NSString *ls_no_of_cntr_3 = [ldict_dictionary valueForKey:@"no_of_cntr_3"];
        NSInteger li_no_of_cntr_3 = [ls_no_of_cntr_3 integerValue];
        NSString *ls_no_of_cntr_4 = [ldict_dictionary valueForKey:@"no_of_cntr_4"];
        NSInteger li_no_of_cntr_4 = [ls_no_of_cntr_4 integerValue];
        NSInteger li_fcl_sum = li_no_of_cntr_1 + li_no_of_cntr_2 + li_no_of_cntr_3 + li_no_of_cntr_4;

        
        NSString *ls_ship_pkg = [ldict_dictionary valueForKey:@"ship_pkg"];
        NSString *ls_ship_kgs = [ldict_dictionary valueForKey:@"ship_kgs"];
        NSString *ls_ship_cbm = [ldict_dictionary valueForKey:@"ship_cbm"];
        if (!(li_fcl_sum == 0) ) {
            ls_os_column = @"FCL";
            if (!(li_no_of_cntr_1 == 0)) {
                ls_os_value = [ls_os_value stringByAppendingString:[NSString stringWithFormat:@"%@ x %@, ", ls_no_of_cntr_1, @"20'"]];
            }
            if (!(li_no_of_cntr_2 == 0)) {
                ls_os_value = [ls_os_value stringByAppendingString:[NSString stringWithFormat:@"%@ x %@, ", ls_no_of_cntr_2, @"40'"]];
            }
            if (!(li_no_of_cntr_3 == 0)) {
                ls_os_value = [ls_os_value stringByAppendingString:[NSString stringWithFormat:@"%@ x %@, ", ls_no_of_cntr_3, @"40'HQ"]];
            }
            if (!(li_no_of_cntr_4 == 0)) {
                ls_os_value = [ls_os_value stringByAppendingString:[NSString stringWithFormat:@"%@ x %@, ", ls_no_of_cntr_4, @"45'HQ"]];
            }
            ls_os_value = [ls_os_value substringToIndex:[ls_os_value length]-2];
        }
        else {
            ls_os_column = @"LCL PKG / KGS / CBM";
          
            ls_os_value = [NSString stringWithFormat:@"%@ / %@ / %@ ", ls_ship_pkg, ls_ship_kgs, ls_ship_cbm];
        }
        
        cell.ilb_header.text = ls_os_column;
        cell.ilb_value.text = ls_os_value;
    }
    if ( indexPath.row == 4)
    {
        cell.ilb_header.text = @"Vessel / Voyage";
        cell.ilb_value.text = [ldict_dictionary valueForKey:@"vsl_voy"];
    }
    if ( indexPath.row == 5)
    {
       
        ls_os_value = [ldict_dictionary valueForKey:@"status_desc"];
        if ([ls_os_value length] > 0 ){
            ls_os_value = [ls_os_value stringByAppendingString:[NSString stringWithFormat:@" / %@ ",[ldict_dictionary valueForKey:@"act_status_date"]]];
        }
        cell.ilb_header.text = @"Latest Status";
        cell.ilb_value.text =ls_os_value;

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
        if (indexPath.row==8) {
            cell.ilb_header.text=@"P/O #";
            cell.ilb_value.text=[ldict_dictionary valueForKey:@"po_no_list"];
        }
        if (indexPath.row==9) {
            cell.ilb_header.text=@"Container #";
            cell.ilb_value.text=[ldict_dictionary valueForKey:@"cntr_no_list"];
        }
    }
    cell.ilb_value.lineBreakMode=NSLineBreakByCharWrapping;
    CGFloat height=[calulate_obj fn_heightWithString:cell.ilb_value.text font:cell.ilb_value.font constrainedToWidth:cell.ilb_value.frame.size.width];
    [cell.ilb_value setFrame:CGRectMake(cell.ilb_value.frame.origin.x, cell.ilb_value.frame.origin.y, cell.ilb_value.frame.size.width, height)];

    return cell;
}
#pragma mark -UITableViewDelegate
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sepoction {
    static NSString *CellIdentifier = @"cell_exhbl_general_hdr";
    Cell_exhbl_general_hdr *headerView = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (headerView == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    
    NSMutableDictionary *ldict_dictionary = [ilist_exhbl objectAtIndex:0];    // Configure Cell
    
        headerView.ilb_display_no.text = [NSString stringWithFormat:@"%@ / %@", [ldict_dictionary valueForKey:@"so_no"], [ldict_dictionary valueForKey:@"hbl_no"]];
    CGFloat height=[calulate_obj fn_heightWithString:headerView.ilb_display_no.text font:headerView.ilb_display_no.font constrainedToWidth:headerView.ilb_display_no.frame.size.width];
    if (height<21) {
        height=21;
    }
    [headerView.ilb_display_no setFrame:CGRectMake(headerView.ilb_display_no.frame.origin.x, headerView.ilb_display_no.frame.origin.y, headerView.ilb_display_no.frame.size.width, height)];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (ilist_exhbl==nil) {
        return 0;
    }else{
        static NSString *CellIdentifier = @"cell_exhbl_general_hdr";
        Cell_exhbl_general_hdr *headerView = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        NSMutableDictionary * ldict_dictionary = [ilist_exhbl objectAtIndex:0];    // Configure Cell
        
        headerView.ilb_display_no.text = [NSString stringWithFormat:@"%@ / %@", [ldict_dictionary valueForKey:@"so_no"], [ldict_dictionary valueForKey:@"hbl_no"]];
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
    static NSString *ls_TableIdentifier = @"cell_exhbl_general_detail";
    Cell_exhbl_general_detail *cell = (Cell_exhbl_general_detail *)[self.tableView dequeueReusableCellWithIdentifier:ls_TableIdentifier];
     NSMutableDictionary *ldict_dictionary = [ilist_exhbl objectAtIndex:0];
    NSString *ls_os_value;
    if ( indexPath.row == 5)
    {
        ls_os_value = [ldict_dictionary valueForKey:@"status_desc"];
        if ([ls_os_value length] > 0 ){
            ls_os_value = [ls_os_value stringByAppendingString:[NSString stringWithFormat:@" / %@ ",[ldict_dictionary valueForKey:@"act_status_date"]]];
        }
    }
    if ([dbLogin isLoginSuccess]) {
        if (indexPath.row==6) {
            ls_os_value =[ldict_dictionary valueForKey:@"shpr_name"];
        }
        if (indexPath.row==7) {
            ls_os_value =[ldict_dictionary valueForKey:@"cnee_name"];
        }
        if (indexPath.row==8) {
            ls_os_value=[ldict_dictionary valueForKey:@"po_no_list"];
        }
        if (indexPath.row==9) {
            ls_os_value=[ldict_dictionary valueForKey:@"cntr_no_list"];
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
    NSMutableDictionary *ldict_dictionary = [ilist_exhbl objectAtIndex:0];
    MapViewController *mapVC=nil;
    mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    if ([indexPath row]==1) {
        mapVC.adress_name=[ldict_dictionary valueForKey:@"load_port"];
    }else if([indexPath row]==2){
        mapVC.adress_name=[ldict_dictionary valueForKey:@"dest_name"];
    }
    [self.navigationController pushViewController:mapVC animated:YES];
}

#pragma mark get data
- (void) fn_get_data: (NSString*)as_search_column :(NSString*)as_search_value
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    RequestContract *req_form = [[RequestContract alloc] init];

    req_form.Auth =[dbLogin WayOfAuthorization];
    SearchFormContract *search = [[SearchFormContract alloc]init];
    search.os_column = as_search_column;
    search.os_value = as_search_value;
    
    req_form.SearchForm = [NSSet setWithObjects:search, nil];
    search=nil;
    
    Web_base *web_base = [[Web_base alloc] init];
    web_base.il_url =STR_SEA_URL;
    web_base.iresp_class =[RespExhbl class];
    web_base.ilist_resp_mapping =[NSArray arrayWithPropertiesOfObject:[RespExhbl class]];
    web_base.iobj_target = self;
    web_base.isel_action = @selector(fn_save_exhbl_list:);
    web_base.callBack=^(BOOL isTimeOut){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isTimeOut) {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"Network requests data timeout !" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
            [alertView show];
        }
    };
    [web_base fn_get_data:req_form];
    req_form=nil;
    web_base=nil;
    
}
- (void) fn_save_exhbl_list: (NSMutableArray *) alist_result {
    ilist_exhbl = alist_result;
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex!=[alertView cancelButtonIndex]) {
        CheckNetWork *check_obj=[[CheckNetWork alloc]init];
        if ([check_obj fn_isPopUp_alert]==NO) {
            [self fn_get_data:is_search_column :is_search_value];
        }
        check_obj=nil;
    }
}
@end
