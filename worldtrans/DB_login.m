//
//  DB_login.m
//  worldtrans
//
//  Created by itdept on 14-3-20.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import "DB_login.h"
#import "DBManager.h"
#import "NSDictionary.h"
#import "FMDatabaseAdditions.h"
@implementation DB_login

@synthesize idb;

-(id) init {
    idb = [DBManager getSharedInstance];
    return self;
}

- (BOOL) fn_save_data:(NSString*)user_ID password:(NSString*)user_pass
{
    // get current date/time
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *ls_currentTime = [dateFormatter stringFromDate:today];
    
    if ([[idb fn_get_db] open]) {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into loginInfo (user_code, password) values (\"%@\", \"%@\")", user_ID, user_pass];
        BOOL ib_updated =[[idb fn_get_db] executeUpdate:insertSQL];
        
        if (! ib_updated)
            return NO;
        [[idb fn_get_db] close];
    }
    
    return  YES;
   
}

-(BOOL)fn_delete_record{
    if ([[idb fn_get_db] open]) {
        NSString *delete = [NSString stringWithFormat:@"delete from loginInfo"];
        BOOL ib_updated =[[idb fn_get_db] executeUpdate:delete];
        
        if (! ib_updated)
            return NO;
        [[idb fn_get_db] close];
    }
    return YES;
}
- (NSMutableArray *) fn_get_all_msg
{
    NSMutableArray *llist_results = [NSMutableArray array];
    if ([[idb fn_get_db] open]) {
        
        FMResultSet *lfmdb_result = [[idb fn_get_db] executeQuery:@"SELECT * FROM loginInfo"];
        while ([lfmdb_result next]) {
            [llist_results addObject:[lfmdb_result resultDictionary]];
        }
    }
    [[idb fn_get_db] close];
    
    return llist_results;
}
-(BOOL)isLoginSuccess{
    if ([[idb fn_get_db] open]) {
        NSInteger li_count = [[idb fn_get_db] intForQuery:@"SELECT COUNT(*) FROM loginInfo"];
        
        if (li_count==0) {
            return NO;
        }else{
            return YES;
        }
        [[idb fn_get_db] close];
    }
    return NO;
}
-(AuthContract*)WayOfAuthorization{
    AuthContract *auth=[[AuthContract alloc]init];
    if ([self isLoginSuccess]) {
        NSMutableArray *userInfo=[self fn_get_all_msg];
        auth.user_code =[[userInfo objectAtIndex:0] valueForKey:@"user_code"];
        auth.password = [[userInfo objectAtIndex:0] valueForKey:@"password"];;
        auth.system = @"ITNEW";
    }else{
        auth.user_code = @"SA";
        auth.password = @"SA1";
        auth.system = @"ITNEW";
    }
    return auth;
}
@end
