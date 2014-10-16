//
//  DB_portName.m
//  worldtrans
//
//  Created by itdept on 14-5-2.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "DB_portName.h"
#import "DatabaseQueue.h"
#import "RespPortName.h"
#import "NSDictionary.h"
#import "FMDatabaseAdditions.h"

@implementation DB_portName
@synthesize queue;

-(id)init{
    self=[super init];
    if (self) {
        queue=[DatabaseQueue fn_sharedInstance];
    }
    return self;
}
-(BOOL)fn_save_data:(NSMutableArray*)alist_portname{
    __block BOOL ib_updated=NO;
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            for (RespPortName *lmap_portName in alist_portname) {
                NSMutableDictionary *ldict_row = [[NSDictionary dictionaryWithPropertiesOfObject:lmap_portName] mutableCopy];
                
                ib_updated =[db executeUpdate:@"delete from portName where display = :display and data = :data and desc = :desc and image =:image" withParameterDictionary:ldict_row];
                
                ib_updated =[db executeUpdate:@"insert into portName (display, data, desc, image) values (:display, :data, :desc, :image)" withParameterDictionary:ldict_row];
                
            }
            [db close];
        }
    }];
    return ib_updated;
}

-(NSMutableArray*)fn_get_data:(NSString*)is_search{
    __block NSMutableArray *llist_results = [NSMutableArray array];
    [queue inDataBase:^(FMDatabase *db){
        if ([db open]) {
            FMResultSet *lfmdb_result = [db executeQuery:@"SELECT * FROM portName  where display LIKE ?",[NSString stringWithFormat:@"%@%%",is_search]];
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
            
            ib_deleted =[db executeUpdate:@"delete from portName"];
            [db close];
        }
    }];
    return ib_deleted;
}



@end
