//
//  AehblGeneralController.m
//  worldtrans
//
//  Created by itdept on 14-3-14.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import "AehblGeneralController.h"
#import <RestKit/RestKit.h>
#import "AuthContract.h"
#import "RequestContract.h"
#import "SearchFormContract.h"
#import "RespExhbl.h"
#import "Cell_exhbl_general_detail.h"
#import "Cell_exhbl_general_hdr.h"
#import "Res_color.h"
@interface AehblGeneralController ()

@end

@implementation AehblGeneralController
@synthesize is_search_column;
@synthesize is_search_value;

@synthesize ilist_aehbl;

- (void)viewDidLoad
{
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
    return 5;
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
    if(section == 1 )
        return 0.000001f;
    else return 102; // put 22 in case of plain one..
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 56;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ls_TableIdentifier = @"cell_aehbl_general_detail";
    NSString *ls_os_value = @"", *ls_os_column = @"";
    
    Cell_exhbl_general_detail *cell = (Cell_exhbl_general_detail *)[self.tableView dequeueReusableCellWithIdentifier:ls_TableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell_aehbl_general_detail" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
    ldict_dictionary = [ilist_aehbl objectAtIndex:0];    // Configure Cell
    
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
        cell.ilb_header.text = @"Load Port / Destination";
        cell.ilb_value.text = [NSString stringWithFormat:@"%@ / %@", [ldict_dictionary valueForKey:@"load_port"], [ldict_dictionary valueForKey:@"dest_name"]];
    }
    if ( indexPath.row == 2)
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
    if ( indexPath.row == 3)
    {
        cell.ilb_header.text = @"Vessel / Voyage";
        cell.ilb_value.text = [ldict_dictionary valueForKey:@"vsl_voy"];
    }
    if ( indexPath.row == 4)
    {
        ls_os_value = [ldict_dictionary valueForKey:@"status_desc"];
        if ([ls_os_value length] > 0 ){
            ls_os_value = [ls_os_value stringByAppendingString:[NSString stringWithFormat:@" / %@, ",[ldict_dictionary valueForKey:@"act_status_date"]]];
        }
        cell.ilb_header.text = @"Latest Status";
        cell.ilb_value.text = ls_os_value;
        
    }
    
    
    
    return cell;
}


- (void) fn_get_data: (NSString*)as_search_column :(NSString*)as_search_value
{
    RequestContract *req_form = [[RequestContract alloc] init];
    
    req_form.Auth = [[AuthContract alloc] init];
    
    req_form.Auth.user_code = @"SA";
    req_form.Auth.password = @"SA1";
    req_form.Auth.system = @"ITNEW";
    
    SearchFormContract *search = [[SearchFormContract alloc]init];
    search.os_column = as_search_column;
    search.os_value = as_search_value;
    
    req_form.SearchForm = [NSSet setWithObjects:search, nil];
    
    
    RKObjectMapping *searchMapping = [RKObjectMapping requestMapping];
    [searchMapping addAttributeMappingsFromArray:@[@"os_column",@"os_value"]];
    
    
    RKObjectMapping *authMapping = [RKObjectMapping requestMapping];
    [authMapping addAttributeMappingsFromDictionary:@{ @"user_code": @"user_code",
                                                       @"password": @"password",
                                                       @"system": @"system" }];
    
    RKObjectMapping *reqMapping = [RKObjectMapping requestMapping];
    
    RKRelationshipMapping *searchRelationship = [RKRelationshipMapping
                                                 relationshipMappingFromKeyPath:@"SearchForm"
                                                 toKeyPath:@"SearchForm"
                                                 withMapping:searchMapping];
    
    
    RKRelationshipMapping *authRelationship = [RKRelationshipMapping
                                               relationshipMappingFromKeyPath:@"Auth"
                                               toKeyPath:@"Auth"
                                               withMapping:authMapping];
    
    [reqMapping addPropertyMapping:authRelationship];
    [reqMapping addPropertyMapping:searchRelationship];
    
    NSString* path = @"itleo.web/api/cargotracking/aehbl";
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:reqMapping
                                                                                   objectClass:[RequestContract class]
                                                                                   rootKeyPath:nil method:RKRequestMethodPOST];
    
    RKObjectMapping* respExhblMapping = [RKObjectMapping mappingForClass:[RespExhbl class]];
    [respExhblMapping addAttributeMappingsFromArray:@[ @"ct_type", @"so_uid", @"hbl_uid", @"so_no", @"hbl_no", @"cbl_no"
                                                       , @"shpr_name", @"cnee_name", @"agent_name", @"load_port", @"dest_name", @"dish_port", @"vsl_voy", @"etd", @"eta", @"eta_dest"
                                                       , @"prt_onboard_date", @"ship_pkg", @"ship_kgs", @"ship_cbm", @"ship_unit", @"prt_tran_inter_port", @"feeder_vsl_voy", @"feeder_etd", @"no_of_cntr_1"
                                                       , @"no_of_cntr_2", @"no_of_cntr_3", @"no_of_cntr_4", @"place_of_receipt", @"delivery_name", @"status_desc", @"act_status_date"]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:respExhblMapping
                                                                                            method:RKRequestMethodPOST
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://demo.itdept.com.hk"]];
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:responseDescriptor];
    manager.requestSerializationMIMEType = RKMIMETypeJSON;
    [manager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];
    
    [manager postObject:req_form path:path parameters:nil
                success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
                    // RKLogInfo(@"Load collection of Articles: %@", result.array);
                    ilist_aehbl = [NSMutableArray arrayWithArray:result.array];
                    [self.tableView reloadData];
                    
                } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                    RKLogError(@"Operation failed with error: %@", error);
                }];
    
}
@end
