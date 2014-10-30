//
//  Web_get_export_data.m
//  worldtrans
//
//  Created by itdept on 14-10-30.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "Web_get_export_data.h"
#import "Web_base.h"
#import "MBProgressHUD.h"
#import "DB_login.h"
//exhbl
#import "RespExhbl.h"

@implementation Web_get_export_data

-(id)init{
    self=[super init];
    if (self) {
        _hud_obj=[[MBProgressHUD alloc]init];
    }
    return self;
}

- (void) fn_get_data: (NSString*)as_search_no
{
    [MBProgressHUD showHUDAddedTo:_VC.view animated:YES];
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
    if (_callBack!=nil) {
        _callBack(alist_result);
    }
    [MBProgressHUD hideHUDForView:_VC.view animated:YES];
}


@end
