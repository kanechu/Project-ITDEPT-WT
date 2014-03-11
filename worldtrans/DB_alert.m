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
    if ([[idb fn_get_db] open]) {
        for (RespAlert *lmap_alert in alist_alert) {
            NSDictionary *dict = [NSDictionary dictionaryWithPropertiesOfObject:lmap_alert];
            BOOL ib_updated =[[idb fn_get_db] executeUpdate:@"insert into alert (ct_type, hbl_no, so_no, hbl_uid, status_desc, act_status_date, so_uid) values (:ct_type, :hbl_no, :so_no, :hbl_uid, :status_desc, :act_status_date, :so_uid)" withParameterDictionary:dict];
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
@end


