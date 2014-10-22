//
//  Cell_milestone.h
//  worldtrans
//
//  Created by itdept on 2/25/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell_milestone : UITableViewCell

@property (nonatomic,assign)NSInteger flag_milestone_type;
@property (nonatomic,assign)NSInteger flag_milestone_finished;

@property (nonatomic) IBOutlet UILabel* ilb_row_num;
@property (nonatomic) IBOutlet UIImageView* ipic_row_status;

@property (weak, nonatomic) IBOutlet UIImageView *ipic_desc_status;

@property (nonatomic) IBOutlet UILabel* ilb_status_desc;

@property (nonatomic) IBOutlet UILabel* ilb_status_remark;

@end
