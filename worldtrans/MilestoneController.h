//
//  MilestoneController.h
//  worldtrans
//
//  Created by itdept on 2/25/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MilestoneController : UITableViewController

@property(nonatomic) NSString *is_docu_type;
@property(nonatomic) NSString *is_docu_uid;

@property(nonatomic) NSInteger ii_max_row;
@property(nonatomic) NSInteger ii_last_status_row;

@property (strong,nonatomic) NSMutableArray *ilist_milestone;


@end
