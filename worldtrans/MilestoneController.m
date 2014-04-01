//
//  MilestoneController.m
//  worldtrans
//
//  Created by itdept on 2/25/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "MilestoneController.h"
#import "AppConstants.h"
#import "RequestContract.h"
#import "SearchFormContract.h"
#import "RespMilestone.h"
#import "Cell_milestone.h"
#import "Res_color.h"
#import "Web_base.h"
#import "DB_login.h"
#import "NSArray.h"
@interface MilestoneController ()

@end

@implementation MilestoneController

@synthesize is_docu_type;
@synthesize is_docu_uid;
@synthesize ilist_milestone;
@synthesize ii_last_status_row;
@synthesize ii_max_row;


- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor blackColor];
    [self fn_get_data:is_docu_type :is_docu_uid];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ilist_milestone count];
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"cell_milestone_hdr";
    Cell_milestone *headerView = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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
    return 55;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    NSString *ls_status_desc = @"",*ls_act_status_date = @"";
    bool lb_done = NO;
    
    static NSString *ls_TableIdentifier = @"cell_milestone_detail";
    Cell_milestone *cell = (Cell_milestone *)[self.tableView dequeueReusableCellWithIdentifier:ls_TableIdentifier];
    
    cell.selectionStyle=UITableViewCellSeparatorStyleNone;
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell_exhbl_general_detail" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
    ldict_dictionary = [ilist_milestone objectAtIndex:indexPath.row];    // Configure Cell
    
    ls_status_desc =[ldict_dictionary valueForKey:@"status_desc"];
    ls_act_status_date =[ldict_dictionary valueForKey:@"act_status_date"];
    cell.ilb_status_desc.text = ls_status_desc;
    cell.ilb_row_num.text = [@(indexPath.row) stringValue];
    if (indexPath.row < self.ii_last_status_row) {
        lb_done = YES;
    }
    
    // letter value
    if (lb_done) {
        // pic setting
        if (indexPath.row == 0 ) {
            [cell.ipic_row_status setImage:[UIImage imageNamed:@"readed_start"]];
        } else if (indexPath.row == self.ii_max_row-1 ) {
            [cell.ipic_row_status setImage:[UIImage imageNamed:@"readed_end"]];
        } else {
            [cell.ipic_row_status setImage:[UIImage imageNamed:@"readed"]];
        }
        cell.ilb_status_remark.text = [NSString stringWithFormat:@"%@ %@ %@", @"(Done)", ls_act_status_date
                                       , [ldict_dictionary valueForKey:@"remark"]];
        
    } else {
        // pic setting
        if (indexPath.row == 0 ) {
            [cell.ipic_row_status setImage:[UIImage imageNamed:@"unread_start"]];
        } else if (indexPath.row == self.ii_max_row-1 ) {
            [cell.ipic_row_status setImage:[UIImage imageNamed:@"unread_end"]];
        }
        else {
            [cell.ipic_row_status setImage:[UIImage imageNamed:@"unread"]];
        }
        [cell.ilb_status_desc setTextColor:[UIColor grayColor]];
        [cell.ilb_status_remark setTextColor:[UIColor grayColor]];
    }
    
    
    
    return cell;
}


- (void)fn_get_milestone_info {
    int nextTag = 1;
    self.ii_max_row = [ilist_milestone count];
    for (NSMutableDictionary *lmap_data in ilist_milestone) {
        if ([[lmap_data valueForKey:@"act_status_date"] length] > 0) {
            self.ii_last_status_row = nextTag;
        }
        nextTag++;
    }
}


- (void) fn_get_data: (NSString*)as_docu_type :(NSString*)as_docu_uid
{
    RequestContract *req_form = [[RequestContract alloc] init];
    DB_login *dbLogin=[[DB_login alloc]init];
    req_form.Auth =[dbLogin WayOfAuthorization];
    
    SearchFormContract *search1 = [[SearchFormContract alloc]init];
    search1.os_column = @"docu_type";
    search1.os_value = as_docu_type;
    
    
    SearchFormContract *search2 = [[SearchFormContract alloc]init];
    search2.os_column = @"docu_uid";
    search2.os_value = as_docu_uid;
    
    req_form.SearchForm = [NSSet setWithObjects:search1,search2, nil];
    
    Web_base *web_base = [[Web_base alloc] init];
    web_base.il_url =STR_MILESTONE_URL;
    web_base.iresp_class =[RespMilestone class];
    
    web_base.ilist_resp_mapping =[NSArray arrayWithPropertiesOfObject:[RespMilestone class]];
    web_base.iobj_target = self;
    web_base.isel_action = @selector(fn_save_milestone_list:);
    [web_base fn_get_data:req_form];
    
   
}
-(void)fn_save_milestone_list:(NSMutableArray*)alist_result{
    ilist_milestone = alist_result;
    [self fn_get_milestone_info];
    [self.tableView reloadData];
   
}


@end
