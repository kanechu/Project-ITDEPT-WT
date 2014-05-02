//
//  DB_portName.h
//  worldtrans
//
//  Created by itdept on 14-5-2.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <Foundation/Foundation.h>
@class DBManager;
@interface DB_portName : NSObject

@property (strong,nonatomic)DBManager *idb;

-(BOOL)fn_save_data:(NSMutableArray*)alist_portname;

-(NSMutableArray*)fn_get_data:(NSString*)is_search;

-(BOOL)fn_delete_all_data;

@end
