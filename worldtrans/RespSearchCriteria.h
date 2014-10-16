//
//  RespSearchCriteria.h
//  worldtrans
//
//  Created by itdept on 14-5-5.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RespSearchCriteria : NSObject

@property (copy,nonatomic) NSString *srch_type;
@property (copy,nonatomic) NSString *seq;
@property (copy,nonatomic) NSString *col_code;
@property (copy,nonatomic) NSString *col_label;
@property (copy,nonatomic) NSString *col_type;
@property (copy,nonatomic) NSString *col_option;
@property (copy,nonatomic) NSString *col_def;
@property (copy,nonatomic) NSString *group_name;
@property (copy,nonatomic) NSString *is_mandatory;
@property (copy,nonatomic) NSString *icon_name;
@end
