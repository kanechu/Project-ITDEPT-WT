//
//  RespAlert.h
//  worldtrans
//
//  Created by itdept on 2/26/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RespAlert : NSObject

@property(nonatomic, copy) NSString *ct_type;
@property(nonatomic, copy) NSString *so_uid;
@property(nonatomic, copy) NSString *hbl_uid;
@property(nonatomic, copy) NSString *so_no;
@property(nonatomic, copy) NSString *hbl_no;
@property(nonatomic, copy) NSString *status_desc;
@property(nonatomic, copy) NSString *act_status_date;

@end
