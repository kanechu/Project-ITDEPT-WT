//
//  RespSchedule.h
//  worldtrans
//
//  Created by itdept on 14-4-19.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RespSchedule : NSObject

@property(nonatomic, copy) NSString *port_name;
@property(nonatomic, copy) NSString *vessel_voyage;
@property(nonatomic, copy) NSString *carrier_name;
@property(nonatomic, copy) NSString *wh_addr;
@property(nonatomic, copy) NSString *si_cut;

@property(nonatomic, copy) NSString *si_time;
@property(nonatomic, copy) NSString *cfs_cut;
@property(nonatomic, copy) NSString *cfs_time;
@property(nonatomic, copy) NSString *cy_cut;
@property(nonatomic, copy) NSString *cy_time;

@property(nonatomic, copy) NSString *etd;
@property(nonatomic, copy) NSString *eta;
@property(nonatomic, copy) NSString *etd_sorting;
@property(nonatomic, copy) NSString *isf_cut;
@property(nonatomic, copy) NSString *isf_time;

@property(nonatomic, copy) NSString *load_port;
@property(nonatomic, copy) NSString *port_tt;

@end
