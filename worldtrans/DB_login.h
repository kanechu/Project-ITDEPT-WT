//
//  DB_login.h
//  worldtrans
//
//  Created by itdept on 14-3-20.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
#import "AuthContract.h"
@interface DB_login : NSObject
{
    DBManager *idb;
}
@property(nonatomic,strong) DBManager *idb;

- (BOOL) fn_save_data:(NSString*)user_ID password:(NSString*)user_pass logo:(NSString*)user_logo;

- (NSMutableArray *) fn_get_all_msg;

-(BOOL)fn_delete_record;
-(BOOL)isLoginSuccess;
-(AuthContract*)WayOfAuthorization;
@end
