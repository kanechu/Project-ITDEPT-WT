//
//  RespMilestone.h
//  worldtrans
//
//  Created by itdept on 2/25/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RespMilestone : NSObject

@property(nonatomic, copy) NSString *print_seq;
@property(nonatomic, copy) NSString *status_code;
@property(nonatomic, copy) NSString *status_desc;
@property(nonatomic, copy) NSString *act_status_date;
@property(nonatomic, copy) NSString *remark;
@property(nonatomic, copy) NSString *status_pic;
@property(nonatomic, copy) NSString *status_pic_url;
@property(nonatomic, copy) NSString *is_finished;

@end
