//
//  Web_get_alert.h
//  worldtrans
//
//  Created by itdept on 2/27/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Web_get_alert : NSObject

@property (strong,nonatomic) NSMutableArray *ilist_alert;
@property (strong,nonatomic) id iobj_target;

@property (nonatomic, assign) SEL isel_action;

- (void) fn_get_data:(NSString*)as_user_code withPwd: (NSString *)as_password;

@end
