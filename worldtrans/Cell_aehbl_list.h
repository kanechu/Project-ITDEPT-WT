//
//  Cell_aehbl_list.h
//  worldtrans
//
//  Created by itdept on 14-3-13.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell_aehbl_list : UITableViewCell
@property (nonatomic) IBOutlet UILabel *ilb_so_no;

@property ( nonatomic) IBOutlet UILabel *ilb_hbl_no;
@property ( nonatomic) IBOutlet UILabel *ilb_load_port;
@property ( nonatomic) IBOutlet UILabel *ilb_dest_port;

@property ( nonatomic) IBOutlet UILabel *ilb_flight_noAnddate;
@property ( nonatomic) IBOutlet UILabel *ilb_status_latest;


@end
