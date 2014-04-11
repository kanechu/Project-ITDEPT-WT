//
//  ExhblViewController.m
//  worldtrans
//
//  Created by itdept on 2/12/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "ExhblListController.h"
#import "RequestContract.h"
#import "AppConstants.h"
#import "SearchFormContract.h"
#import "RespExhbl.h"
#import "Cell_exhbl_list.h"
#import "Res_color.h"
#import "ExhblHomeController.h"
#import "ExhblGeneralController.h"
#import "MBProgressHUD.h"
#import "DB_login.h"
#import "Web_base.h"
#import "NSArray.h"
#import "NSString.h"
@interface ExhblListController ()

@end

@implementation ExhblListController
@synthesize ilist_exhbl;
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

    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = iSearchBar.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor]CGColor], (id)[[UIColor whiteColor]CGColor], nil];
    [iSearchBar.layer insertSublayer:gradient atIndex:0];
    self.view.backgroundColor = [UIColor blackColor];
    iSearchBar.delegate = (id)self;
    [self fn_get_data:is_search_no];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ilist_exhbl count];
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"cell_exhbl_header";
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ls_TableIdentifier = @"cell_exhbl_list";
    
    Cell_exhbl_list *cell = (Cell_exhbl_list *)[self.tableView dequeueReusableCellWithIdentifier:ls_TableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell_exhbl_list" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
    ldict_dictionary = [ilist_exhbl objectAtIndex:indexPath.row];    // Configure Cell
    
    if( [indexPath row] % 2)
        [cell setBackgroundColor:COLOR_DARK_JUNGLE_GREEN];
    else
        [cell setBackgroundColor:COLOR_EERIE_BLACK];
    
    
    cell.ilb_hbl_no.text = [NSString nullConvertEmpty:[ldict_dictionary valueForKey:@"hbl_no"]];

    cell.ilb_so_no.text = [NSString nullConvertEmpty:[ldict_dictionary valueForKey:@"so_no"]];
    cell.ilb_load_port.text = [NSString nullConvertEmpty:[ldict_dictionary valueForKey:@"load_port"]];
    cell.ilb_dest_port.text = [NSString nullConvertEmpty: [ldict_dictionary valueForKey:@"dest_name"]];
    cell.ilb_status_desc.text = [NSString nullConvertEmpty:[ldict_dictionary valueForKey:@"status_desc"]];
    NSString *str=nil;
    if ([[ldict_dictionary valueForKey:@"etd"] length]==0 || [[ldict_dictionary valueForKey:@"eta"] length]==0) {
        str=[NSString stringWithFormat:@"%@%@", [ldict_dictionary valueForKey:@"etd"], [ldict_dictionary valueForKey:@"eta"]];
    }else{
        str=[NSString stringWithFormat:@"%@/%@", [ldict_dictionary valueForKey:@"etd"], [ldict_dictionary valueForKey:@"eta"]];
    }
    cell.ilb_date.text =[NSString nullConvertEmpty:str];
    
    return cell;
}



- (void)tableView: (UITableView *)tableView
didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    NSString *ls_hbl_uid = @"";
    NSString *ls_so_uid = @"";
   // NSString *ls_os_column = @"";
    NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
    ldict_dictionary = [ilist_exhbl objectAtIndex:indexPath.row];    // Configure Cell
    ls_hbl_uid = [ldict_dictionary valueForKey:@"hbl_uid"];
    ls_so_uid = [ldict_dictionary valueForKey:@"so_uid"];
    
    [self performSegueWithIdentifier:@"segue_exhbl_home" sender:self];
}

- (void) fn_get_data: (NSString*)as_search_no
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    RequestContract *req_form = [[RequestContract alloc] init];
    
    DB_login *dbLogin=[[DB_login alloc]init];
    req_form.Auth =[dbLogin WayOfAuthorization];
    SearchFormContract *search = [[SearchFormContract alloc]init];
    search.os_column = @"search_no";
    search.os_value = as_search_no;
    
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
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self handleSearch:searchBar];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    //[self handleSearch:searchBar];
}

- (void)handleSearch:(UISearchBar *)searchBar {
    
    [self fn_get_data:searchBar.text];
    
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    NSLog(@"User canceled search");
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSString *ls_hbl_uid = @"";
    NSString *ls_so_uid = @"";
    NSString *ls_os_column = @"";
    NSString *ls_os_value = @"";
    NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
    NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
    
    ldict_dictionary = [ilist_exhbl objectAtIndex:selectedRowIndex.row];    // Configure Cell
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
    
    if ([[segue identifier] isEqualToString:@"segue_exhbl_home"]) {
        ExhblHomeController *exhblHomeController = [segue destinationViewController];
        exhblHomeController.is_search_column = ls_os_column;
        exhblHomeController.is_search_value = ls_os_value;
    }
}

@end
