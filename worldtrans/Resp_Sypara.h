//
//  Resp_Sypara.h
//  ittracking
//
//  Created by itdept on 14-10-9.
//  Copyright (c) 2014年 ittracking Logistics Services Ltd. . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Resp_Sypara : NSObject

@property(nonatomic, copy) NSString *unique_id;
@property(nonatomic, copy) NSString *para_code;
@property(nonatomic, copy) NSString *company_code;
@property(nonatomic, copy) NSString *data1;//用于控制CarrierMilestone是否显示 1（显示） 0或者空（不显示）
@property(nonatomic, copy) NSString *data2;
@property(nonatomic, copy) NSString *data3;
@property(nonatomic, copy) NSString *data4;
@property(nonatomic, copy) NSString *data5;
@property(nonatomic, copy) NSString *para_desc;
@property(nonatomic, copy) NSString *rec_crt_user;
@property(nonatomic, copy) NSString *rec_upd_user;
@property(nonatomic, copy) NSString *rec_crt_date;
@property(nonatomic, copy) NSString *rec_upd_date;
@property(nonatomic, copy) NSString *db_id;
@property(nonatomic, copy) NSString *is_ct;
@property(nonatomic, copy) NSString *crt_user;
@property(nonatomic, copy) NSString *req_user;
@property(nonatomic, copy) NSString *rmk;

@end
