//
//  DB_device.m
//  worldtrans
//
//  Created by itdept on 14-3-29.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import "DB_device.h"
#import "DatabaseQueue.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
@implementation DB_device
@synthesize queue;
- (id)init{
    self=[super init];
    if (self) {
        queue=[DatabaseQueue fn_sharedInstance];
    }
    return self;
}
- (BOOL)fn_save_data:(NSString*)device_id
{
    __block BOOL ib_updated=NO;
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            NSString *insertSQL = [NSString stringWithFormat:@"insert into device (device_id ) values ( \"%@\")", device_id];
            ib_updated =[db executeUpdate:insertSQL];
            [db close];
        }
    }];
    return ib_updated;
}
-(NSMutableArray*)fn_get_all_msg{
    
    __block NSMutableArray *llist_results = [NSMutableArray array];
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            FMResultSet *lfmdb_result = [db executeQuery:@"SELECT * FROM device"];
            while ([lfmdb_result next]) {
                [llist_results addObject:[lfmdb_result resultDictionary]];
            }
            [db close];
        }
    }];
    
    return llist_results;
}

@end
