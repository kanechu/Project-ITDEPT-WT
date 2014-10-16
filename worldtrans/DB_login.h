//
//  DB_login.h
//  worldtrans
//
//  Created by itdept on 14-3-20.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseQueue.h"
#import "AuthContract.h"
@interface DB_login : NSObject
{
    DatabaseQueue *queue;
}
@property(nonatomic,strong) DatabaseQueue *queue;

- (BOOL) fn_save_data:(NSString*)user_ID password:(NSString*)user_pass logo:(NSString*)user_logo;

- (NSMutableArray *) fn_get_all_msg;

-(BOOL)fn_delete_record;
-(BOOL)isLoginSuccess;
-(AuthContract*)WayOfAuthorization;
@end
