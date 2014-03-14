//
//  DB_alert.m
//  worldtrans
//
//  Created by itdept on 3/6/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "DB_alert.h"
#import "DBManager.h"
#import "RespAlert.h"
#import "NSDictionary.h"
#import "FMDatabaseAdditions.h"


@implementation DB_alert

@synthesize idb;

-(id) init {
    idb = [DBManager getSharedInstance];
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
    
    
    if ([[idb fn_get_db] open]) {
        for (RespAlert *lmap_alert in alist_alert) {
            NSMutableDictionary *ldict_row = [[NSDictionary dictionaryWithPropertiesOfObject:lmap_alert] mutableCopy];
            [ldict_row setObject:ls_currentTime forKey:@"msg_recv_date"];
            
            BOOL ib_updated =[[idb fn_get_db] executeUpdate:@"insert into alert (ct_type, hbl_no, so_no, hbl_uid, status_desc, act_status_date, so_uid, msg_recv_date) values (:ct_type, :hbl_no, :so_no, :hbl_uid, :status_desc, :act_status_date, :so_uid, :msg_recv_date)" withParameterDictionary:ldict_row];
            if (! ib_updated)
                return NO;
        }        //[[idb fn_get_db] executeUpdate:insertSQL];
        [[idb fn_get_db] close];
        return  YES;
    }
    return NO;
}

- (NSInteger) fn_get_unread_msg_count
{
    if ([[idb fn_get_db] open]) {
        NSInteger li_count = [[idb fn_get_db] intForQuery:@"SELECT COUNT(0) FROM alert where is_read <> '1'"];
        [[idb fn_get_db] close];
        return  li_count;
    }
    return 0;
}



- (NSMutableArray *) fn_get_all_msg
{
    NSMutableArray *llist_results = [NSMutableArray array];
    if ([[idb fn_get_db] open]) {
        
        FMResultSet *lfmdb_result = [[idb fn_get_db] executeQuery:@"SELECT * FROM alert order by msg_recv_date desc"];
        while ([lfmdb_result next]) {
            [llist_results addObject:[lfmdb_result resultDictionary]];
        }    }
    [[idb fn_get_db] close];
    
    return llist_results;
}
@end

