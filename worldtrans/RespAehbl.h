//
//  RespAehbl.h
//  worldtrans
//
//  Created by itdept on 14-3-14.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RespAehbl : NSObject
@property(nonatomic, copy) NSString *ct_type;
@property(nonatomic, copy) NSString *so_uid;
@property(nonatomic, copy) NSString *hbl_uid;
@property(nonatomic, copy) NSString *so_no;
@property(nonatomic, copy) NSString *hbl_no;
@property(nonatomic, copy) NSString *cbl_no;
@property(nonatomic, copy) NSString *shpr_name;
@property(nonatomic, copy) NSString *cnee_name;
@property(nonatomic, copy) NSString *agent_name;
@property(nonatomic, copy) NSString *load_port;
@property(nonatomic, copy) NSString *dest_name;
@property(nonatomic, copy) NSString *dish_port;
@property(nonatomic,copy)NSString *flight_no;
@property(nonatomic,copy)NSString *prt_flight_date;

@property(nonatomic,copy)NSString *eta;

@property(nonatomic,assign)double hbl_pkg;
@property(nonatomic,assign)double hbl_chrg_cbm;
@property(nonatomic,assign)double hbl_act_cbm;
@property(nonatomic,assign)double hbl_kgs;

@property(nonatomic,copy)NSString *hbl_unit;
@property(nonatomic,copy)NSString *cntrloff_list;
@property(nonatomic,copy)NSString *delivery_name;
@property(nonatomic,copy)NSString *status_desc;
@property(nonatomic,copy)NSString *act_status_date;
@end
