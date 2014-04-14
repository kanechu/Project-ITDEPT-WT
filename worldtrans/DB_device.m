//
//  DB_device.m
//  worldtrans
//
//  Created by itdept on 14-3-29.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import "DB_device.h"

@implementation DB_device
@synthesize idb;
- (BOOL)fn_save_data:(NSString*)device_id
{

    
    if ([[idb fn_get_db] open]) {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into device (device_id ) values ( \"%@\")", device_id];
        BOOL ib_updated =[[idb fn_get_db] executeUpdate:insertSQL];
        
        if (! ib_updated)
            return NO;
        [[idb fn_get_db] close];
    }
    
    return  YES;
    
}
-(NSMutableArray*)fn_get_all_msg{
    
    NSMutableArray *llist_results = [NSMutableArray array];
    if ([[idb fn_get_db] open]) {
        
        FMResultSet *lfmdb_result = [[idb fn_get_db] executeQuery:@"SELECT * FROM device"];
        while ([lfmdb_result next]) {
            [llist_results addObject:[lfmdb_result resultDictionary]];
        }
        [[idb fn_get_db] close];
    }
    
    return llist_results;
}

@end
