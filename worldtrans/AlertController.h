//
//  AlertController.h
//  worldtrans
//
//  Created by itdept on 2/26/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertController : UITableViewController<UISearchBarDelegate>

@property (strong,nonatomic) NSMutableArray *ilist_alert;
@property (strong,nonatomic) NSMutableArray *today_alert;
@property (strong,nonatomic) NSMutableArray *previous_alert;
@property (strong,nonatomic) NSMutableDictionary *deleteDic;
@property ( nonatomic) UIButton *cancleButton;
- (IBAction)EditRow:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarWithScopeBar;

@end


