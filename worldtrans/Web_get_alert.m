//
//  Web_get_alert.m
//  worldtrans
//
//  Created by itdept on 2/27/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "Web_get_alert.h"
#import "RespAlert.h"
#import "Web_base.h"
#import "DB_login.h"
#import "AppDelegate.h"
@implementation Web_get_alert

@synthesize ilist_alert;
@synthesize isel_action;
@synthesize iobj_target;

- (void) fn_get_data
{
    NSString *ls_device_token = [(AppDelegate *)[[UIApplication sharedApplication] delegate] is_device_token];

    DB_login *dbLogin = [[DB_login alloc] init];
    
    RequestContract *req_form = [[RequestContract alloc] init];
    
    req_form.Auth =[dbLogin WayOfAuthorization];
    dbLogin=nil;
    
    SearchFormContract *search1 = [[SearchFormContract alloc]init];
    search1.os_column = @"device_id";
    search1.os_value = ls_device_token;
    
    SearchFormContract *search2 = [[SearchFormContract alloc]init];
    search2.os_column = @"request_sart_date";
    search2.os_value = @"2014-02-01";
    
    req_form.SearchForm = [NSSet setWithObjects:search1,search2, nil];
    search1=nil;
    search2=nil;
    
    Web_base *web_base = [[Web_base alloc] init];
    web_base.il_url =STR_ALERT_URL;
    web_base.iresp_class =[RespAlert class];
    
    web_base.ilist_resp_mapping =[NSArray arrayWithPropertiesOfObject:[RespAlert class]];
    web_base.iobj_target = self;
    web_base.isel_action = @selector(fn_save_alert_list:);
    [web_base fn_get_data:req_form];
    
    req_form=nil;
    web_base=nil;
    
}
- (void) fn_save_alert_list: (NSMutableArray *) alist_result {
    ilist_alert = alist_result;
    SuppressPerformSelectorLeakWarning([iobj_target performSelector:isel_action withObject:ilist_alert];);
    
}
@end
