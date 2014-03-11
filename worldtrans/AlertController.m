//
//  AlertController.m
//  worldtrans
//
//  Created by itdept on 2/26/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "AlertController.h"
#import <RestKit/RestKit.h>
#import "AuthContract.h"
#import "RequestContract.h"
#import "SearchFormContract.h"
#import "RespAlert.h"
#import "Cell_alert_list.h"
#import "Res_color.h"
#import "Web_get_alert.h"
#import "DB_alert.h"
#import "NSString.h"


@interface AlertController ()

@end

@implementation AlertController

@synthesize ilist_alert;

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor blackColor];
    [self fn_get_data];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ilist_alert count];
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"cell_alert_list_hdr";
    Cell_alert_list *headerView = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (headerView == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1 )
        return 0.000001f;
    else return 44; // put 22 in case of plain one..
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 71;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   // NSString *ls_status_desc = @"",*ls_act_status_date = @"",*ls_ct_type = @"",*ls_ct_no = @"";
    
    static NSString *ls_TableIdentifier = @"cell_alert_list";
    Cell_alert_list *cell = (Cell_alert_list *)[self.tableView dequeueReusableCellWithIdentifier:ls_TableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"cell_alert_list" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
   // NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
  //  ldict_dictionary = [ilist_alert objectAtIndex:indexPath.row];    // Configure Cell
    //RespAlert *ldict_dictionary = [ilist_alert objectAtIndex:indexPath.row];
    NSDictionary *ldict_dictionary = [ilist_alert objectAtIndex:indexPath.row];
    
    NSString *ls_status_desc =[ldict_dictionary valueForKey:@"status_desc"];
    NSString *ls_act_status_date =[ldict_dictionary valueForKey:@"act_status_date"];
    NSString *ls_msg_recv_date =[ldict_dictionary valueForKey:@"msg_recv_date"];
    NSString *ls_ct_type =[ldict_dictionary valueForKey:@"ct_type"];
    NSString *ls_show_no = @"";
    if ([ls_ct_type containsString:@"so"])
        ls_show_no = [@"BOOKING#: " stringByAppendingString:[ldict_dictionary valueForKey:@"so_no"]];
    else
        ls_show_no = [@"HBL#: " stringByAppendingString:[ldict_dictionary valueForKey:@"hbl_no"]];
    cell.ilb_status_desc.text = ls_status_desc;
    cell.ilb_act_status_date.text = ls_act_status_date;
    cell.ilb_alert_date.text = ls_msg_recv_date;
    cell.ilb_ct_nos.text = ls_show_no;
    return cell;
}

- (void) fn_get_data
{
    DB_alert * ldb_alert = [[DB_alert alloc] init];
    ilist_alert = [ldb_alert fn_get_all_msg];
    [self.tableView reloadData];
}

@end
