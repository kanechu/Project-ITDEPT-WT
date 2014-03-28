//
//  MainHomeViewController.h
//  worldtrans
//
//  Created by itdept on 14-3-28.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainHomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *theScrollerView;
@property (weak, nonatomic) IBOutlet UIButton *alertButton;

- (IBAction)UserLogin:(id)sender;
- (void) fn_save_alert_list: (NSMutableArray *) alist_alert;
@end
