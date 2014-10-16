//
//  DB_searchCriteria.h
//  worldtrans
//
//  Created by itdept on 14-5-5.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <Foundation/Foundation.h>
@class DatabaseQueue;
@interface DB_searchCriteria : NSObject

@property (nonatomic,strong)DatabaseQueue *queue;

-(BOOL)fn_save_data:(NSMutableArray*)alist_searchCriteria;
-(NSMutableArray*)fn_get_all_data;
-(NSMutableArray*)fn_get_groupNameAndNum;
-(BOOL)fn_delete_all_data;

@end
