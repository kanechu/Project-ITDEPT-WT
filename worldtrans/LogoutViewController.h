//
//  LogoutViewController.h
//  worldtrans
//
//  Created by itdept on 14-3-29.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogoutViewController : UIViewController

@property (strong,nonatomic) id iobj_target;
@property (nonatomic, assign) SEL isel_action;

@property (weak, nonatomic) IBOutlet UILabel *userLoginTime;
@property (weak, nonatomic) IBOutlet UILabel *userCode;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet UILabel *userID;
@property (weak, nonatomic) IBOutlet UILabel *loginTime;

@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

- (IBAction)closeLogoutUI:(id)sender;

@end
