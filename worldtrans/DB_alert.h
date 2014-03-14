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

@end
