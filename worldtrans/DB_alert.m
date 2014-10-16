//
//  DB_alert.m
//  worldtrans
//
//  Created by itdept on 3/6/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "DB_alert.h"
#import "DatabaseQueue.h"
#import "RespAlert.h"
#import "NSDictionary.h"
#import "FMDatabaseAdditions.h"
#import "AppConstants.h"
#import "DB_login.h"
@interface DB_alert()

@property (strong, nonatomic) NSString *user_code;

@end

@implementation DB_alert
@synthesize queue;
-(id) init {
    self=[super init];
    if (self) {
        queue = [DatabaseQueue fn_sharedInstance];
        DB_login *dbLogin = [[DB_login alloc] init];
        AuthContract *Auth =[dbLogin WayOfAuthorization];
        _user_code=Auth.user_code;
        if (_user_code==nil) {
            _user_code=DEFAULT_USERCODE;
        }
    }
    return self;
}

- (BOOL) fn_save_data:(NSMutableArray*) alist_alert
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
            for (RespAlert *lmap_alert in alist_alert) {
                NSMutableDictionary *ldict_row = [[NSDictionary dictionaryWithPropertiesOfObject:lmap_alert] mutableCopy];
                [ldict_row setObject:ls_currentTime forKey:@"msg_recv_date"];
                [ldict_row setObject:_user_code forKey:@"user_code"];
                ib_updated=[db executeUpdate:@"delete from alert where user_code = :user_code and ct_type = :ct_type and hbl_no = :hbl_no and so_no = :so_no and hbl_uid =:hbl_uid and so_uid = :so_uid" withParameterDictionary:ldict_row];
                
                ib_updated =[db executeUpdate:@"insert into alert (user_code,ct_type, hbl_no, so_no, hbl_uid, status_desc, act_status_date, so_uid, msg_recv_date) values (:user_code,:ct_type, :hbl_no, :so_no, :hbl_uid, :status_desc, :act_status_date, :so_uid, :msg_recv_date)" withParameterDictionary:ldict_row];
                
            }
            [db close];
        }
    }];
    return ib_updated;
}

- (NSInteger) fn_get_unread_msg_count
{
    __block NSInteger li_count=0;
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            li_count = [db intForQuery:@"SELECT COUNT(0) FROM alert where user_code=? and is_read <> '1'",_user_code];
            [db close];
        }
    }];
    return li_count;
}
- (BOOL)fn_update_isRead:(NSString*)as_indexRow{
    __block BOOL ib_updated=NO;
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            ib_updated =[db executeUpdate:@"update alert set is_read='1' where unique_id=? and user_code=?",as_indexRow,_user_code];
            
            [db close];
        }
    }];
    return ib_updated;
}
- (BOOL)fn_delete:(NSString*)as_indexRow{
    __block BOOL ib_deleted=NO;
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            ib_deleted =[db executeUpdate:@"delete from alert where unique_id=? and user_code=?",as_indexRow,_user_code];
            
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
            FMResultSet *lfmdb_result = [db executeQuery:@"SELECT * FROM alert where user_code=? order by msg_recv_date desc ",_user_code];
            while ([lfmdb_result next]) {
                [llist_results addObject:[lfmdb_result resultDictionary]];
            }
            [db close];
        }
    }];
    return llist_results;
}
-(NSString*)getToday_Date{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *ls_currentTime = [dateFormatter stringFromDate:today];
    return ls_currentTime;
}
- (NSMutableArray *) fn_get_today_msg{
    __block NSMutableArray *llist_results = [NSMutableArray array];
    NSString *ls_today=[self getToday_Date];
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            FMResultSet *lfmdb_result = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM alert where user_code=\"%@\" and msg_recv_date>\"%@\" order by msg_recv_date desc",_user_code,ls_today]];
            while ([lfmdb_result next]) {
                [llist_results addObject:[lfmdb_result resultDictionary]];
            }
            [db close];
        }
    }];
    return llist_results;
}

- (NSMutableArray *) fn_get_previous_msg{
    __block NSMutableArray *llist_results = [NSMutableArray array];
    NSString *ls_today=[self getToday_Date];
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            
            FMResultSet *lfmdb_result = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM alert where user_code=\"%@\" and  msg_recv_date<\"%@\" order by msg_recv_date desc",_user_code,ls_today]];
            while ([lfmdb_result next]) {
                [llist_results addObject:[lfmdb_result resultDictionary]];
            }
            [db close];
        }
    }];
    
    return llist_results;
}
- (BOOL)fn_delete_all_alert{
    __block BOOL ib_deleted=NO;
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            ib_deleted=[db executeUpdate:@"delete from alert where user_code=?",_user_code];
            [db close];
        }
    }];
    return ib_deleted;
}
@end


