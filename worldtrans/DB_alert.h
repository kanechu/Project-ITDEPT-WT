//
//  DB_alert.h
//  worldtrans
//
//  Created by itdept on 3/6/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"

@interface DB_alert : NSObject

@property (strong,nonatomic) DBManager *idb;

- (BOOL) fn_save_data:(NSMutableArray*) alist_alert;
- (NSInteger) fn_get_unread_msg_count;
- (NSMutableArray *) fn_get_all_msg;
- (NSMutableArray *) fn_get_today_msg;
- (NSMutableArray *) fn_get_previous_msg;
- (BOOL)fn_update_isRead:(NSString*)as_indexRow;
- (BOOL)fn_delete:(NSString*)as_indexRow;
@end

