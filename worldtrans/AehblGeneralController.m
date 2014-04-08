//
//  AehblGeneralController.m
//  worldtrans
//
//  Created by itdept on 14-3-14.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import "AehblGeneralController.h"
#import "AppConstants.h"
#import "RequestContract.h"
#import "SearchFormContract.h"
#import "RespAehbl.h"
#import "Cell_exhbl_general_detail.h"
#import "Cell_exhbl_general_hdr.h"
#import "Res_color.h"
#import "Web_base.h"
#import "NSArray.h"
#import "MapViewController.h"

enum ROW_NUMOFSECTION {
    ROW_NUM1 = 8,
    RoW_NUM2 = 6
};
@interface AehblGeneralController ()

@end

@implementation AehblGeneralController
@synthesize is_search_column;
@synthesize is_search_value;

@synthesize ilist_aehbl;
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
    if ([dbLogin isLoginSuccess] && ilist_aehbl!=nil) {
        return ROW_NUM1;
    }else if(ilist_aehbl!=nil){
        return RoW_NUM2;
    }else{
        return 0;
    }
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"cell_aehbl_general_hdr";
    Cell_exhbl_general_hdr *headerView = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (headerView == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    
    NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
    ldict_dictionary = [ilist_aehbl objectAtIndex:0];    // Configure Cell
    
    
    headerView.ilb_display_no.text = [NSString stringWithFormat:@"%@ / %@", [ldict_dictionary valueForKey:@"so_no"], [ldict_dictionary valueForKey:@"hbl_no"]];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (ilist_aehbl==nil) {
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
    
    static NSString *ls_TableIdentifier = @"cell_aehbl_general_detail";
   
    Cell_exhbl_general_detail *cell = (Cell_exhbl_general_detail *)[self.tableView dequeueReusableCellWithIdentifier:ls_TableIdentifier];
    NSString *ls_os_value = @"";
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell_aehbl_general_detail" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.ilb_value.lineBreakMode=NSLineBreakByWordWrapping;
    cell.ilb_value.numberOfLines=0;
    NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
    ldict_dictionary = [ilist_aehbl objectAtIndex:0];    // Configure Cell
    
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
    }
    if ( indexPath.row == 2)
    {
        cell.ilb_header.text = @"Destination";
        cell.ilb_value.text =[ldict_dictionary valueForKey:@"dest_name"];
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
    ldict_dictionary = [ilist_aehbl objectAtIndex:0];
    MapViewController *mapVC=nil;
    mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    if ([indexPath row]==1) {
        mapVC.adress_name=[ldict_dictionary valueForKey:@"load_port"];
        [self.navigationController pushViewController:mapVC animated:YES];
    }else if ([indexPath row]==2){
        mapVC.adress_name=[ldict_dictionary valueForKey:@"dest_name"];
        [self.navigationController pushViewController:mapVC animated:YES];
    }
}

- (void) fn_get_data: (NSString*)as_search_column :(NSString*)as_search_value
{
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
    ilist_aehbl = alist_result;
    [self.tableView reloadData];
    
}
@end
