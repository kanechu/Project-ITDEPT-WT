//
//  DB_searchCriteria.m
//  worldtrans
//
//  Created by itdept on 14-5-5.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "DB_searchCriteria.h"
#import "DBManager.h"
#import "RespSearchCriteria.h"
#import "NSDictionary.h"
@implementation DB_searchCriteria
@synthesize idb;
-(id)init{
    idb =[DBManager getSharedInstance];
    return self;
}

-(BOOL)fn_save_data:(NSMutableArray*)alist_searchCriteria{
    if ([[idb fn_get_db] open]) {
        for (RespSearchCriteria *lmap_searchCriteria in alist_searchCriteria) {
            NSMutableDictionary *ldict_row = [[NSDictionary dictionaryWithPropertiesOfObject:lmap_searchCriteria] mutableCopy];
            
            BOOL ib_delete =[[idb fn_get_db] executeUpdate:@"delete from searchCriteria where seq = :seq and col_code = :col_code and col_label = :col_label and col_type =:col_type and col_option=:col_option and col_def=:col_def and group_name=:group_name and is_mandatory=:is_mandatory" withParameterDictionary:ldict_row];
            if (! ib_delete)
                return NO;
            
            BOOL ib_updated =[[idb fn_get_db] executeUpdate:@"insert into searchCriteria (seq, col_code, col_label, col_type, col_option, col_def, group_name, is_mandatory) values (:seq, :col_code, :col_label, :col_type, :col_option, :col_def, :group_name, :is_mandatory)" withParameterDictionary:ldict_row];
            if (! ib_updated)
                return NO;
        }
        [[idb fn_get_db] close];
        return  YES;
    }
    return NO;
    
}
-(NSMutableArray*)fn_get_all_data{
    NSMutableArray *llist_results = [NSMutableArray array];
    if ([[idb fn_get_db] open]) {
        
        FMResultSet *lfmdb_result = [[idb fn_get_db] executeQuery:@"SELECT * FROM searchCriteria"];
        while ([lfmdb_result next]) {
            [llist_results addObject:[lfmdb_result resultDictionary]];
        }
    }
    [[idb fn_get_db] close];
    
    return llist_results;
}
-(BOOL)fn_delete_all_data{
    if ([[idb fn_get_db] open]) {
        BOOL ib_updated =[[idb fn_get_db] executeUpdate:@"delete from searchCriteria"];
        if (! ib_updated)
            return NO;
        [[idb fn_get_db] close];
        
    }
    return YES;
    
}



@end
