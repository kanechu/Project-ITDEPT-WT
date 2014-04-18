//
//  Cell_schedule_section1.h
//  worldtrans
//
//  Created by itdept on 14-4-18.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Custom_TextField.h"
@interface Cell_schedule_section1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *ibt_navigate_btn;

@property (weak, nonatomic) IBOutlet UILabel *ilb_port;
@property (weak, nonatomic) IBOutlet Custom_TextField *ilb_show_portName;

@end
