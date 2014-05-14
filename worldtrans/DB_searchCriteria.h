//
//  DB_searchCriteria.h
//  worldtrans
//
//  Created by itdept on 14-5-5.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <Foundation/Foundation.h>
@class DBManager;
@interface DB_searchCriteria : NSObject

@property (nonatomic,strong)DBManager *idb;

-(BOOL)fn_save_data:(NSMutableArray*)alist_searchCriteria;
-(NSMutableArray*)fn_get_all_data;
-(BOOL)fn_delete_all_data;
-(NSInteger)fn_get_Groupnumber;

@end
