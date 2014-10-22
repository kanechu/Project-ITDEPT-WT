//
//  DB_sypara.m
//  ittracking
//
//  Created by itdept on 14-10-9.
//  Copyright (c) 2014年 ittracking Logistics Services Ltd. . All rights reserved.
//

#import "DB_sypara.h"
#import "FMDatabaseAdditions.h"
#import "FMResultSet.h"
#import "DatabaseQueue.h"
#import "NSDictionary.h"
#import "Resp_Sypara.h"

@implementation DB_sypara
@synthesize queue;

-(id)init{
    queue=[DatabaseQueue fn_sharedInstance];
    return self;
    
}
- (BOOL)fn_save_sypara_data:(NSMutableArray*)arr_sypara{
    __block BOOL ib_updated=NO;
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            for (Resp_Sypara *sypara in arr_sypara) {
                NSMutableDictionary *dic_sypara=[[NSDictionary dictionaryWithPropertiesOfObject:sypara]mutableCopy];
                ib_updated=[db executeUpdate:@"insert into sypara(unique_id,para_code,company_code,data1,data2,data3,data4,data5,para_desc,rec_crt_user,rec_upd_user,rec_crt_date,rec_upd_date,db_id,is_ct,crt_user,req_user,rmk)values(:unique_id,:para_code,:company_code,:data1,:data2,:data3,:data4,:data5,:para_desc,:rec_crt_user,:rec_upd_user,:rec_crt_date,:rec_upd_date,:db_id,:is_ct,:crt_user,:req_user,:rmk)" withParameterDictionary:dic_sypara];
                
            }
            [db close];
        }
    }];
    return ib_updated;
}

- (NSMutableArray*)fn_get_sypara_data{
    __block  NSMutableArray *arr_result=[NSMutableArray array];
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            FMResultSet *lfmdb_result=[db executeQuery:@"select * from sypara"];
            while ([lfmdb_result next]) {
                [arr_result addObject:[lfmdb_result resultDictionary]];
            }
            [db close];
        }
    }];
    return arr_result;
}


- (BOOL)fn_delete_all_sypara_data{
    __block BOOL ib_deleted=NO;
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            ib_deleted=[db executeUpdate:@"delete from sypara"];
            [db close];
        }
    }];
    return ib_deleted;
}

@end
