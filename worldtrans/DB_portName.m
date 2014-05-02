//
//  DB_portName.m
//  worldtrans
//
//  Created by itdept on 14-5-2.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "DB_portName.h"
#import "DBManager.h"
#import "RespPortName.h"
#import "NSDictionary.h"
#import "FMDatabaseAdditions.h"

@implementation DB_portName
@synthesize idb;

-(id)init{
    idb=[DBManager getSharedInstance];
    return self;
}
-(BOOL)fn_save_data:(NSMutableArray*)alist_portname{
    if ([[idb fn_get_db] open]) {
        for (RespPortName *lmap_portName in alist_portname) {
            NSMutableDictionary *ldict_row = [[NSDictionary dictionaryWithPropertiesOfObject:lmap_portName] mutableCopy];
            
            BOOL ib_delete =[[idb fn_get_db] executeUpdate:@"delete from portName where display = :display and data = :data and desc = :desc and image =:image" withParameterDictionary:ldict_row];
            if (! ib_delete)
                return NO;
            
            BOOL ib_updated =[[idb fn_get_db] executeUpdate:@"insert into portName (display, data, desc, image) values (:display, :data, :desc, :image)" withParameterDictionary:ldict_row];
            if (! ib_updated)
                return NO;
        }
        [[idb fn_get_db] close];
        return  YES;
    }
    return NO;
}

-(NSMutableArray*)fn_get_data:(NSString*)is_search{
    NSMutableArray *llist_results = [NSMutableArray array];
    if ([[idb fn_get_db] open]) {
        
        FMResultSet *lfmdb_result = [[idb fn_get_db] executeQuery:@"SELECT * FROM portName  where display LIKE ?",[NSString stringWithFormat:@"%%%@%%",is_search]];
        while ([lfmdb_result next]) {
            [llist_results addObject:[lfmdb_result resultDictionary]];
        }
    }
    [[idb fn_get_db] close];
    
    return llist_results;
}

-(BOOL)fn_delete_all_data{
    if ([[idb fn_get_db] open]) {
        BOOL ib_updated =[[idb fn_get_db] executeUpdate:@"delete from portName"];
        if (! ib_updated)
            return NO;
        [[idb fn_get_db] close];
        
    }
    return YES;

}


@end
