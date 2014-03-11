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


@interface AlertController ()

@end

@implementation AlertController

@synthesize ilist_alert;

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor blackColor];
    [self fn_get_data];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    RespAlert *ldict_dictionary = [ilist_alert objectAtIndex:indexPath.row];
    //ls_status_desc =[ldict_dictionary valueForKey:@"status_desc"];
    //ls_act_status_date =[ldict_dictionary valueForKey:@"act_status_date"];
    //ls_ct_type =[ldict_dictionary valueForKey:@"ct_type"];
    
    
    cell.ilb_status_desc.text = ldict_dictionary.status_desc;
    cell.ilb_act_status_date.text = ldict_dictionary.act_status_date;
    
    
    
    
    return cell;
}

- (void) fn_get_data
{
    Web_get_alert *web_get_alert = [[Web_get_alert alloc] init];
    web_get_alert.iobj_target = self;
    web_get_alert.isel_action = @selector(fn_web_fill_data:);
    [web_get_alert fn_get_data:@"SA" withPwd:@"SA1"];
}

- (void) fn_web_fill_data: (NSMutableArray *) alist_alert {
    ilist_alert = alist_alert;
    DB_alert * ldb_alert = [[DB_alert alloc] init];
    [ldb_alert fn_save_data:ilist_alert];
    [self.tableView reloadData];
}
@end
