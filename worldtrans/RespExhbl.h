//
//  RespExhbl.h
//  worldtrans
//
//  Created by itdept on 2/20/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RespExhbl : NSObject


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
@property(nonatomic, copy) NSString *vsl_voy;
@property(nonatomic, copy) NSString *etd;
@property(nonatomic, copy) NSString *eta;
@property(nonatomic, copy) NSString *eta_dest;
@property(nonatomic, copy) NSString *prt_onboard_date;
@property(nonatomic, copy) NSString *ship_pkg;
@property(nonatomic, copy) NSString *ship_kgs;
@property(nonatomic, copy) NSString *ship_cbm;
@property(nonatomic, copy) NSString *ship_unit;
@property(nonatomic, copy) NSString *prt_tran_inter_port;
@property(nonatomic, copy) NSString *feeder_vsl_voy;
@property(nonatomic, copy) NSString *feeder_etd;
@property(nonatomic, copy) NSString *no_of_cntr_1;
@property(nonatomic, copy) NSString *no_of_cntr_2;
@property(nonatomic, copy) NSString *no_of_cntr_3;
@property(nonatomic, copy) NSString *no_of_cntr_4;
@property(nonatomic, copy) NSString *place_of_receipt;
@property(nonatomic, copy) NSString *delivery_name;
@property(nonatomic, copy) NSString *status_desc;
@property(nonatomic, copy) NSString *act_status_date;
@property(nonatomic, copy) NSString *po_no_list;
@property(nonatomic, copy) NSString *cntr_no_list;

@end
