//
//  DB_icon.m
//  worldtrans
//
//  Created by itdept on 14-5-22.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "DB_icon.h"
#import "DatabaseQueue.h"
#import "RespIcon.h"
#import "NSDictionary.h"
#import "FMDatabaseAdditions.h"
@implementation DB_icon
@synthesize queue;
-(id)init{
    self=[super init];
    if (self) {
        queue=[DatabaseQueue fn_sharedInstance];
    }
    return self;
}
-(BOOL)fn_save_data:(NSMutableArray*)alist_icon{
    __block BOOL ib_updated=NO;
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            for (RespIcon *lmap_icon in alist_icon) {
                NSMutableDictionary *ldict_row = [[NSDictionary dictionaryWithPropertiesOfObject:lmap_icon] mutableCopy];
                ib_updated =[db executeUpdate:@"delete from icon where ic_name = :ic_name and ic_content = :ic_content and upd_date = :upd_date" withParameterDictionary:ldict_row];
                
                ib_updated =[db executeUpdate:@"insert into icon (ic_name, ic_content, upd_date) values (:ic_name, :ic_content, :upd_date)" withParameterDictionary:ldict_row];
            }
            [db close];
        }
    }];
    return ib_updated;
}
-(BOOL)fn_save_update_data:(RespIcon*)lmap_icon{
    __block BOOL ib_updated=NO;
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            
            NSMutableDictionary *ldict_row = [[NSDictionary dictionaryWithPropertiesOfObject:lmap_icon] mutableCopy];
            
            ib_updated =[db executeUpdate:@"update icon set ic_name =? , ic_content =? ,upd_date =? where ic_name=?",[ldict_row valueForKey:@"ic_name"],[ldict_row valueForKey:@"ic_content"],[ldict_row valueForKey:@"upd_date"],[ldict_row valueForKey:@"ic_name"]];
            [db close];
        }
    }];
    return ib_updated;
}
-(NSMutableArray*)fn_get_all_iconData{
    __block  NSMutableArray *llist_results = [NSMutableArray array];
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            FMResultSet *lfmdb_result = [db executeQuery:@"SELECT * FROM icon"];
            while ([lfmdb_result next]) {
                [llist_results addObject:[lfmdb_result resultDictionary]];
            }
            [db close];
        }
        
    }];
    return llist_results;
}
-(NSDictionary*)fn_get_recent_update{
    __block  NSDictionary *llist_results = [NSDictionary dictionary];
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            FMResultSet *lfmdb_result = [db executeQuery:@"SELECT max(upd_date) FROM icon  order by upd_date desc"];
            while ([lfmdb_result next]) {
                llist_results=[lfmdb_result resultDictionary];
            }
            [db close];
        }
    }];
    return llist_results;
}
-(BOOL)fn_isExist_icon:(NSString*)icon_name{
    __block NSMutableArray *arr_result=[NSMutableArray array];
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            FMResultSet *lfmdb_result=[db executeQuery:@"Select * from icon where ic_name=?",icon_name];
            while ([lfmdb_result next]) {
                [arr_result addObject:[lfmdb_result resultDictionary]];
            }
            [db close];
        }
    }];
    if ([arr_result count]!=0) {
        return YES;
    }else{
        return NO;
    }
}
@end
