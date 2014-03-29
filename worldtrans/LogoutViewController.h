//
//  LogoutViewController.h
//  worldtrans
//
//  Created by itdept on 14-3-29.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogoutViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *userLoginTime;
@property (weak, nonatomic) IBOutlet UILabel *userCode;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (strong,nonatomic) id iobj_target;
@property (nonatomic, assign) SEL isel_action;
- (IBAction)clickLogout:(id)sender;
- (IBAction)closeLogoutUI:(id)sender;

@end
