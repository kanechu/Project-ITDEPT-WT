//
//  Cell_alert_list.h
//  worldtrans
//
//  Created by itdept on 2/26/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell_alert_list : UITableViewCell

@property (nonatomic) IBOutlet UILabel* ilb_ct_nos;

@property (nonatomic) IBOutlet UILabel* ilb_status_desc;

@property (nonatomic) IBOutlet UILabel* ilb_act_status_date;

@property (nonatomic) IBOutlet UILabel* ilb_alert_date;

@property (nonatomic) IBOutlet UIImageView *ilb_warningBlue;

@end
