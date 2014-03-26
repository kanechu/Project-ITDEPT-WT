//
//  AlertController.m
//  worldtrans
//
//  Created by itdept on 2/26/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "AlertController.h"
#import "Cell_alert_list.h"
#import "Res_color.h"
#import "DB_alert.h"
#import "NSString.h"
#import "ExhblHomeController.h"
#import "AehblHomeController.h"

@interface AlertController ()

@end

@implementation AlertController

@synthesize ilist_alert;

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor blackColor];
    [self fn_get_data];
   [NSTimer scheduledTimerWithTimeInterval: 11.0 target: self
                                                    selector: @selector(reloadData) userInfo: nil repeats: YES];
    
}
#pragma mark UITableViewDelegate
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
#pragma mark UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ls_TableIdentifier = @"cell_alert_list";
    Cell_alert_list *cell = (Cell_alert_list *)[self.tableView dequeueReusableCellWithIdentifier:ls_TableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"cell_alert_list" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
   
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
    if ([[NSString stringWithFormat:@"%@", [ldict_dictionary valueForKey:@"is_read"]] isEqualToString:@"0"]  ) {
        cell.ilb_warningBlue.image=[UIImage imageNamed:@"warning_blue"];
    }else{
        cell.ilb_warningBlue.image=nil;
    }
            
    return cell;
}
- (void)tableView: (UITableView *)tableView
didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    
    NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
    ldict_dictionary = [ilist_alert objectAtIndex:indexPath.row];
    // Configure Cell
    NSString *ls_unique_id = [ldict_dictionary valueForKey:@"unique_id"];
    NSString *ls_ct_type =[[ldict_dictionary valueForKey:@"ct_type"] lowercaseString];
    if ([ls_ct_type isEqualToString:@"exhbl"]) {
        [self performSegueWithIdentifier:@"segue_exhbl_home1" sender:self];
    }else if([ls_ct_type isEqualToString:@"aehbl"]){
        [self performSegueWithIdentifier:@"segue_aehbl_home1" sender:self];
    }
    DB_alert * ldb_alert = [[DB_alert alloc] init];
    [ldb_alert fn_update_isRead:ls_unique_id];
    
    ilist_alert=[ldb_alert fn_get_all_msg];
    [self.tableView reloadData];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        
        
        [ilist_alert removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    
        
        NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
        ldict_dictionary = [ilist_alert objectAtIndex:indexPath.row];
        // Configure Cell
        NSString *ls_unique_id = [ldict_dictionary valueForKey:@"unique_id"];
        DB_alert * ldb_alert = [[DB_alert alloc] init];
        [ldb_alert fn_delete:ls_unique_id];
      
         
       
    }
   
}

#pragma mark segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSString *ls_hbl_uid = @"";
    NSString *ls_so_uid = @"";
    NSString *ls_os_column = @"";
    NSString *ls_os_value = @"";
    NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
    NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
    
    ldict_dictionary = [ilist_alert objectAtIndex:selectedRowIndex.row];    // Configure Cell
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
    
    if ([[segue identifier] isEqualToString:@"segue_exhbl_home1"]) {
        ExhblHomeController *exhblHomeController = [segue destinationViewController];
        exhblHomeController.is_search_column = ls_os_column;
        exhblHomeController.is_search_value = ls_os_value;
    }else if ([[segue identifier] isEqualToString:@"segue_aehbl_home1"]){
        ExhblHomeController *exhblHomeController = [segue destinationViewController];
        exhblHomeController.is_search_column = ls_os_column;
        exhblHomeController.is_search_value = ls_os_value;
    }
}

- (void) fn_get_data
{
    DB_alert * ldb_alert = [[DB_alert alloc] init];
    ilist_alert = [ldb_alert fn_get_all_msg];
    NSLog(@"%d",[ilist_alert count]);
   
}
-(void)reloadData{
    
    DB_alert * ldb_alert = [[DB_alert alloc] init];
    if ([ldb_alert fn_get_unread_msg_count]>[ilist_alert count]) {
        ilist_alert=[ldb_alert fn_get_all_msg];
        [self.tableView reloadData];
    }
}
- (IBAction)deleteRow:(id)sender {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}
@end
