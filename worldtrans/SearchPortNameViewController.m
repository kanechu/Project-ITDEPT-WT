//
//  SearchPortNameViewController.m
//  worldtrans
//
//  Created by itdept on 14-4-23.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "SearchPortNameViewController.h"
#import "Cell_portName_list.h"
#import "SearchFormContract.h"
#import "DB_login.h"
#import "DB_portName.h"
#import "Web_base.h"
#import "RespPortName.h"
#import "MZFormSheetController.h"
#import "MBProgressHUD.h"

@interface SearchPortNameViewController ()<UIAlertViewDelegate>

@end

@implementation SearchPortNameViewController
@synthesize ilist_portname;
@synthesize iobj_target;
@synthesize isel_action;
@synthesize is_placeholder;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置search bar的代理
    _is_search_portName.delegate=self;
    _is_search_portName.placeholder=is_placeholder;
    //设置Table的代理
    _it_table_portname.delegate=self;
    _it_table_portname.dataSource=self;
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark resquest portName Data
-(void)fn_get_data:(NSString*)as_search_portname{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    RequestContract *req_form=[[RequestContract alloc]init];
    DB_login *dbLogin=[[DB_login alloc]init];
    req_form.Auth=[dbLogin WayOfAuthorization];
    dbLogin=nil;
    SearchFormContract *search=[[SearchFormContract alloc]init];
    search.os_column=@"port_name";
    search.os_value=as_search_portname;
    
    SearchFormContract *search1=[[SearchFormContract alloc]init];
    search1.os_column=@"port_code";
    search1.os_value=@"";
    
    req_form.SearchForm=[NSSet setWithObjects:search,search1,nil];
    search=nil;
    search1=nil;
    Web_base *web_base=[[Web_base alloc]init];
    web_base.il_url =STR_PORTNAME_URL;
    web_base.iresp_class =[RespPortName class];
    
    web_base.ilist_resp_mapping =[NSArray arrayWithPropertiesOfObject:[RespPortName class]];
    web_base.iobj_target = self;
    web_base.isel_action = @selector(fn_save_portname_list:);
    web_base.callBack= ^(BOOL isTimeOut){
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
-(void)fn_save_portname_list:(NSMutableArray*)alist_result{
    ilist_portname=alist_result;
    DB_portName *db=[[DB_portName alloc]init];
    [db fn_save_data:alist_result];
    [_it_table_portname reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != [alertView cancelButtonIndex]) {
        CheckNetWork *check_obj=[[CheckNetWork alloc]init];
        if ([check_obj fn_isPopUp_alert]==NO) {        [self fn_get_data:_is_search_portName.text];
        }
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return ilist_portname.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_portName_list2";
    Cell_portName_list *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[Cell_portName_list alloc]init];
    }
    
    cell.ilb_portName.text=[[ilist_portname objectAtIndex:indexPath.row] valueForKey:@"display"];
    cell.ilb_desc.text=[[ilist_portname objectAtIndex:indexPath.row] valueForKey:@"desc"];
    
    
    // Configure the cell...
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *dic=[ilist_portname objectAtIndex:indexPath.row];
    SuppressPerformSelectorLeakWarning([iobj_target performSelector:isel_action withObject:dic];);
    
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController* formSheet){}];

}

#pragma mark UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self fn_get_data:_is_search_portName.text];
    [_is_search_portName resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
   
    [_is_search_portName resignFirstResponder];
     
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    DB_portName *db=[[DB_portName alloc]init];
    NSMutableArray *arr=[db fn_get_data:searchBar.text];
    ilist_portname=arr;
    [_it_table_portname reloadData];
    db=nil;
    
}

- (IBAction)fn_click_close:(id)sender {
    
     [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];   
}
@end
