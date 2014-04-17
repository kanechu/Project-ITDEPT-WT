//
//  LoginViewController.h
//  worldtrans
//
//  Created by itdept on 14-3-18.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Custom_TextField.h"
@class TrackHomeController;
@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,strong)NSDictionary *loginData;
@property (strong,nonatomic) id iobj_target;
@property (nonatomic, assign) SEL isel_action;
@property (weak, nonatomic) IBOutlet Custom_TextField *user_ID;
@property (weak, nonatomic) IBOutlet Custom_TextField *user_Password;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)UserLogin:(id)sender;
- (IBAction)closeLoginUI:(id)sender;


@end
