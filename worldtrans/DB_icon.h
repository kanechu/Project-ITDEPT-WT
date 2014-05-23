//
//  DB_icon.h
//  worldtrans
//
//  Created by itdept on 14-5-22.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <Foundation/Foundation.h>
@class DBManager;

@interface DB_icon : NSObject

@property(nonatomic,strong)DBManager *idb;
-(BOOL)fn_save_data:(NSMutableArray*)alist_icon;
-(BOOL)fn_save_update_data:(NSMutableDictionary*)alist_icon;
-(BOOL)fn_isExist_icon:(NSString*)icon_name;
-(NSMutableArray*)fn_get_all_iconData;
-(NSDictionary*)fn_get_recent_update;
@end
