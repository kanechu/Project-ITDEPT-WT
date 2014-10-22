//
//  DB_sypara.h
//  ittracking
//
//  Created by itdept on 14-10-9.
//  Copyright (c) 2014年 ittracking Logistics Services Ltd. . All rights reserved.
//

#import <Foundation/Foundation.h>
@class DatabaseQueue;
@interface DB_sypara : NSObject

@property(nonatomic,strong)DatabaseQueue *queue;

- (BOOL)fn_save_sypara_data:(NSMutableArray*)arr_sypara;

- (NSMutableArray*)fn_get_sypara_data;

- (BOOL)fn_delete_all_sypara_data;


@end
