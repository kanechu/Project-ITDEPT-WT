
//
//  ExhblGeneralController.m
//  worldtrans
//
//  Created by itdept on 2/24/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "ExhblGeneralController.h"
#import "RequestContract.h"
#import "SearchFormContract.h"
#import "RespExhbl.h"
#import "Cell_exhbl_general_detail.h"
#import "Cell_exhbl_general_hdr.h"
#import "Res_color.h"
#import "AppConstants.h"
#import "Web_base.h"
#import "NSArray.h"
#import "MapViewController.h"
enum ROW_NUMOFSECTION {
    ROW_NUM1 = 8,
    RoW_NUM2 = 6
};
@interface ExhblGeneralController ()

@end

@implementation ExhblGeneralController

@synthesize is_search_column;
@synthesize is_search_value;

@synthesize ilist_exhbl;
@synthesize dbLogin;
-(void)createDBLoginObj{
    self.dbLogin =[[DB_login alloc]init];
}
- (void)viewDidLoad
{
    [self createDBLoginObj];
    self.view.backgroundColor = [UIColor blackColor];
    [self fn_get_data:is_search_column :is_search_value];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([dbLogin isLoginSuccess] && ilist_exhbl!=nil ) {
        return ROW_NUM1;
    }else if(ilist_exhbl!=nil){
         return RoW_NUM2;
    }else{
        return 0;
    }
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"cell_exhbl_general_hdr";
    Cell_exhbl_general_hdr *headerView = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (headerView == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    
    NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
    ldict_dictionary = [ilist_exhbl objectAtIndex:0];    // Configure Cell
    
    
        headerView.ilb_display_no.text = [NSString stringWithFormat:@"%@ / %@", [ldict_dictionary valueForKey:@"so_no"], [ldict_dictionary valueForKey:@"hbl_no"]];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (ilist_exhbl==nil) {
        return 0;
    }else{
        if(section == 1 )
            return 0.000001f;
        else return 102; // put 22 in case of plain one..
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{    
    return 56;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ls_TableIdentifier = @"cell_exhbl_general_detail";
    NSString *ls_os_value = @"", *ls_os_column = @"";
    
    Cell_exhbl_general_detail *cell = (Cell_exhbl_general_detail *)[self.tableView dequeueReusableCellWithIdentifier:ls_TableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell_exhbl_general_detail" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
    ldict_dictionary = [ilist_exhbl objectAtIndex:0];    // Configure Cell
    
    if( [indexPath row] % 2)
        [cell setBackgroundColor:COLOR_DARK_JUNGLE_GREEN];
    else
        [cell setBackgroundColor:COLOR_EERIE_BLACK];
    
    if ( indexPath.row == 0)
    {
        cell.ilb_header.text = @"ETD / ETA";
        cell.ilb_value.text = [NSString stringWithFormat:@"%@ / %@", [ldict_dictionary valueForKey:@"etd"], [ldict_dictionary valueForKey:@"eta"]];
    }
    if ( indexPath.row == 1)
    {
        cell.ilb_header.text = @"Load Port";
        cell.ilb_value.text = [ldict_dictionary valueForKey:@"load_port"];
    }
    if ( indexPath.row == 2)
    {
        cell.ilb_header.text = @"Destination";
        cell.ilb_value.text = [ldict_dictionary valueForKey:@"dest_name"];
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
            ls_os_value = [ls_os_value stringByAppendingString:[NSString stringWithFormat:@" / %@, ",[ldict_dictionary valueForKey:@"act_status_date"]]];
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

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
    ldict_dictionary = [ilist_exhbl objectAtIndex:0];
    MapViewController *mapVC=nil;
     mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    if ([indexPath row]==1) {
        mapVC.adress_name=[ldict_dictionary valueForKey:@"load_port"];
        [self.navigationController pushViewController:mapVC animated:YES];
    }else if([indexPath row]==2){
        mapVC.adress_name=[ldict_dictionary valueForKey:@"dest_name"];
        [self.navigationController pushViewController:mapVC animated:YES];
    }
}

#pragma mark get data
- (void) fn_get_data: (NSString*)as_search_column :(NSString*)as_search_value
{
    RequestContract *req_form = [[RequestContract alloc] init];

    req_form.Auth =[dbLogin WayOfAuthorization];
    SearchFormContract *search = [[SearchFormContract alloc]init];
    search.os_column = as_search_column;
    search.os_value = as_search_value;
    
    req_form.SearchForm = [NSSet setWithObjects:search, nil];
    
    Web_base *web_base = [[Web_base alloc] init];
    web_base.il_url =STR_SEA_URL;
    web_base.iresp_class =[RespExhbl class];
    web_base.ilist_resp_mapping =[NSArray arrayWithPropertiesOfObject:[RespExhbl class]];
    web_base.iobj_target = self;
    web_base.isel_action = @selector(fn_save_exhbl_list:);
    [web_base fn_get_data:req_form];
    
}
- (void) fn_save_exhbl_list: (NSMutableArray *) alist_result {
    ilist_exhbl = alist_result;
    [self.tableView reloadData];
    
}


@end
