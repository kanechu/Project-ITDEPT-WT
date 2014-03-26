//
//  AlertController.h
//  worldtrans
//
//  Created by itdept on 2/26/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertController : UITableViewController

@property (strong,nonatomic) NSMutableArray *ilist_alert;

- (IBAction)deleteRow:(id)sender;

@end


