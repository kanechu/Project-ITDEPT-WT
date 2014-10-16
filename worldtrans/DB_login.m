//
//  DB_login.m
//  worldtrans
//
//  Created by itdept on 14-3-20.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import "DB_login.h"
#import "DatabaseQueue.h"
#import "NSDictionary.h"
#import "FMDatabaseAdditions.h"
#import "AppDelegate.h"
#import "DB_device.h"
#import "AppConstants.h"
@implementation DB_login

@synthesize queue;

-(id) init {
    self=[super init];
    if (self) {
        queue=[DatabaseQueue fn_sharedInstance];
    }
    return self;
}

- (BOOL) fn_save_data:(NSString*)user_ID password:(NSString*)user_pass logo:(NSString*)user_logo
{
    // get current date/time
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *ls_currentTime = [dateFormatter stringFromDate:today];
    __block BOOL ib_updated=NO;
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            NSString *insertSQL = [NSString stringWithFormat:@"insert into loginInfo (user_code,password,login_time,user_logo) values (\"%@\",\"%@\",\"%@\",\"%@\")", user_ID,user_pass,ls_currentTime,user_logo];
            ib_updated =[db executeUpdate:insertSQL];
            [db close];
        }
    }];
    return ib_updated;
}

-(BOOL)fn_delete_record{
    __block BOOL ib_deleted=NO;
    [queue inDataBase:^(FMDatabase* db){
        if ([db open]) {
            NSString *delete = [NSString stringWithFormat:@"delete from loginInfo"];
            ib_deleted =[db executeUpdate:delete];
            
            [db close];
        }
    }];
    return ib_deleted;
}
- (NSMutableArray *) fn_get_all_msg
{
    __block NSMutableArray *llist_results = [NSMutableArray array];
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            
            FMResultSet *lfmdb_result = [db executeQuery:@"SELECT * FROM loginInfo"];
            while ([lfmdb_result next]) {
                [llist_results addObject:[lfmdb_result resultDictionary]];
            }
            [db close];
        }
        
    }];
    return llist_results;
}
-(BOOL)isLoginSuccess{
    __block NSInteger li_count=0;
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            li_count = [db intForQuery:@"SELECT COUNT(*) FROM loginInfo"];
            [db close];
        }
    }];
    if (li_count==0) {
        return NO;
    }else{
        return YES;
    }
}
-(AuthContract*)WayOfAuthorization{
    AuthContract *auth=[[AuthContract alloc]init];
    NSString * ls_device_token = [(AppDelegate *)[[UIApplication sharedApplication] delegate] is_device_token];
     DB_device *device=[[DB_device alloc]init];
    if (ls_device_token==nil) {
        [device fn_save_data:@"dev-simulator"];
        ls_device_token=@"dev-simulator";
    }else{
         [device fn_save_data:ls_device_token];
    }
   
   
    if ([self isLoginSuccess]) {
        NSMutableArray *userInfo=[self fn_get_all_msg];
        auth.user_code =[[userInfo objectAtIndex:0] valueForKey:@"user_code"];
        auth.password = [[userInfo objectAtIndex:0] valueForKey:@"password"];;
    }else{
        auth.user_code =DEFAULT_USERCODE;
        auth.password =DEFAULT_PASS;
    }
    auth.system = DEFAULT_SYSTEM;
    auth.device_id = ls_device_token;

    return auth;
}
@end
