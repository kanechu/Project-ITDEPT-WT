//
//  Cell_detail_schedule.h
//  worldtrans
//
//  Created by itdept on 14-4-21.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell_detail_schedule : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ilb_vessel_voyage;
@property (weak, nonatomic) IBOutlet UILabel *ilb_wh_address;
@property (weak, nonatomic) IBOutlet UILabel *ilb_cyCut;

@property (weak, nonatomic) IBOutlet UILabel *ilb_cfsCut;
@property (weak, nonatomic) IBOutlet UILabel *ilb_etd;
@property (weak, nonatomic) IBOutlet UILabel *ilb_eta;
@property (weak, nonatomic) IBOutlet UILabel *ilb_tt;
@property (weak, nonatomic) IBOutlet UILabel *ilb_load_port;
@property (weak, nonatomic) IBOutlet UILabel *ilb_dish_port;

@end
