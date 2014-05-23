//
//  DB_icon.m
//  worldtrans
//
//  Created by itdept on 14-5-22.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "DB_icon.h"
#import "DBManager.h"
#import "RespIcon.h"
#import "NSDictionary.h"
#import "FMDatabaseAdditions.h"
@implementation DB_icon
@synthesize idb;
-(id)init{
    idb =[DBManager getSharedInstance];
    return self;
}
-(BOOL)fn_save_data:(NSMutableArray*)alist_icon{
    if ([[idb fn_get_db] open]) {
        for (RespIcon *lmap_icon in alist_icon) {
            NSMutableDictionary *ldict_row = [[NSDictionary dictionaryWithPropertiesOfObject:lmap_icon] mutableCopy];
            BOOL ib_delete =[[idb fn_get_db] executeUpdate:@"delete from icon where ic_name = :ic_name and ic_content = :ic_content and upd_date = :upd_date" withParameterDictionary:ldict_row];
            if (! ib_delete)
                return NO;
            
            BOOL ib_updated =[[idb fn_get_db] executeUpdate:@"insert into icon (ic_name, ic_content, upd_date) values (:ic_name, :ic_content, :upd_date)" withParameterDictionary:ldict_row];
            if (! ib_updated)
                return NO;
        }
        [[idb fn_get_db] close];
        return  YES;
    }
    return NO;
    
}
-(BOOL)fn_save_update_data:(RespIcon*)lmap_icon{
    if ([[idb fn_get_db] open]) {
       
            NSMutableDictionary *ldict_row = [[NSDictionary dictionaryWithPropertiesOfObject:lmap_icon] mutableCopy];
       
            BOOL ib_updated =[[idb fn_get_db] executeUpdate:@"update icon set ic_name =? , ic_content =? ,upd_date =? where ic_name=?",[ldict_row valueForKey:@"ic_name"],[ldict_row valueForKey:@"ic_content"],[ldict_row valueForKey:@"upd_date"],[ldict_row valueForKey:@"ic_name"]];
            if (! ib_updated)
                return NO;
        
        [[idb fn_get_db] close];
        return  YES;
    }
    return NO;

}
-(NSMutableArray*)fn_get_all_iconData{
    NSMutableArray *llist_results = [NSMutableArray array];
    if ([[idb fn_get_db] open]) {
        
        FMResultSet *lfmdb_result = [[idb fn_get_db] executeQuery:@"SELECT * FROM icon"];
        while ([lfmdb_result next]) {
            [llist_results addObject:[lfmdb_result resultDictionary]];
        }
    }
    [[idb fn_get_db] close];
    
    return llist_results;
}
-(NSDictionary*)fn_get_recent_update{
    NSDictionary *llist_results = [NSDictionary dictionary];
    if ([[idb fn_get_db] open]) {
        FMResultSet *lfmdb_result = [[idb fn_get_db] executeQuery:@"SELECT max(upd_date) FROM icon  order by upd_date desc"];
        while ([lfmdb_result next]) {
            llist_results=[lfmdb_result resultDictionary];
        }
    }
    [[idb fn_get_db] close];
    return llist_results;
}
-(BOOL)fn_isExist_icon:(NSString*)icon_name{
    if ([[idb fn_get_db]open]) {
        FMResultSet *lfmdb_result=[[idb fn_get_db]executeQuery:@"Select * from icon where ic_name=?",icon_name];
        while ([lfmdb_result next]) {
            return YES;
        }
    }
    [[idb fn_get_db]close];
    return NO;
}
@end
