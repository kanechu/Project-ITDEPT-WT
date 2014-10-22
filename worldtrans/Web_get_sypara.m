//
//  Web_get_sypara.m
//  worldtrans
//
//  Created by itdept on 14-10-22.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "Web_get_sypara.h"
#import "Resp_Sypara.h"
#import "Web_base.h"
#import "DB_sypara.h"
@implementation Web_get_sypara

-(void)fn_get_sypara_data:(NSString*)user_code pass:(NSString*)password{
    
    RequestContract *req_form = [[RequestContract alloc] init];
    AuthContract *auth=[[AuthContract alloc]init];
    auth.user_code=user_code;
    auth.password=password;
    auth.system = DEFAULT_SYSTEM;
    req_form.Auth =auth;
    Web_base *web_base=[[Web_base alloc]init];
    web_base.il_url=STR_SYPARA_URL;
    web_base.iresp_class=[Resp_Sypara class];
    web_base.ilist_resp_mapping =[NSArray arrayWithPropertiesOfObject:[Resp_Sypara class]];
    web_base.iobj_target=self;
    web_base.isel_action=@selector(fn_save_sypara:);
    [web_base fn_get_data:req_form];
}
-(void)fn_save_sypara:(NSMutableArray*)alist_result{
    if ([alist_result count]!=0) {
        DB_sypara *db_sypara=[[DB_sypara alloc]init];
        [db_sypara fn_save_sypara_data:alist_result];
    }
}

@end
