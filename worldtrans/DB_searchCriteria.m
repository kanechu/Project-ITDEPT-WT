//
//  DB_searchCriteria.m
//  worldtrans
//
//  Created by itdept on 14-5-5.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "DB_searchCriteria.h"
#import "DatabaseQueue.h"
#import "RespSearchCriteria.h"
#import "NSDictionary.h"
#import "FMDatabaseAdditions.h"
@implementation DB_searchCriteria
@synthesize queue;
-(id)init{
    self=[super init];
    if (self) {
        queue=[DatabaseQueue fn_sharedInstance];
    }
    return self;
}

-(BOOL)fn_save_data:(NSMutableArray*)alist_searchCriteria{
    // get current date/time
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *ls_currentTime = [dateFormatter stringFromDate:today];
    __block BOOL ib_updated=NO;
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            for (RespSearchCriteria *lmap_searchCriteria in alist_searchCriteria) {
                NSMutableDictionary *ldict_row = [[NSDictionary dictionaryWithPropertiesOfObject:lmap_searchCriteria] mutableCopy];
                [ldict_row setObject:ls_currentTime forKey:@"save_time"];
                ib_updated =[db executeUpdate:@"delete from searchCriteria where srch_type=:srch_type and seq = :seq and col_code = :col_code and col_label = :col_label and col_type =:col_type and col_option=:col_option and col_def=:col_def and group_name=:group_name and is_mandatory=:is_mandatory and icon_name=:icon_name and save_time=:save_time " withParameterDictionary:ldict_row];
                
                ib_updated =[db executeUpdate:@"insert into searchCriteria (srch_type,seq, col_code, col_label, col_type, col_option, col_def, group_name, is_mandatory,icon_name, save_time) values (:srch_type,:seq, :col_code, :col_label, :col_type, :col_option, :col_def, :group_name, :is_mandatory,:icon_name, :save_time)" withParameterDictionary:ldict_row];
                
            }
            [db close];
        }
    }];
    return ib_updated;
}
-(NSMutableArray*)fn_get_all_data{
    __block NSMutableArray *llist_results = [NSMutableArray array];
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            FMResultSet *lfmdb_result = [db executeQuery:@"SELECT * FROM searchCriteria"];
            while ([lfmdb_result next]) {
                [llist_results addObject:[lfmdb_result resultDictionary]];
            }
            [db close];
        }
    }];
    return llist_results;
}
-(BOOL)fn_delete_all_data{
    __block BOOL ib_deleted=NO;
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            ib_deleted=[db executeUpdate:@"delete from searchCriteria"];
            [db close];
        }
    }];
    return ib_deleted;
}

-(NSMutableArray*)fn_get_groupNameAndNum{
    
    __block  NSMutableArray *arr=[NSMutableArray array];
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            // FMResultSet *lfmdb_result= [[idb fn_get_db] executeQuery:@"SELECT group_name,COUNT(group_name) FROM searchCriteria group by group_name"];
            FMResultSet *lfmdb_result= [db executeQuery:@"select * from (SELECT group_name,COUNT(group_name) FROM searchCriteria group by group_name) order by group_name desc"];
            while ([lfmdb_result next]) {
                [arr addObject:[lfmdb_result resultDictionary]];
            }
            [db close];
        }
    }];
    return arr;
}
@end
