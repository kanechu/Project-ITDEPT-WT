//
//  LoginViewController.h
//  worldtrans
//
//  Created by itdept on 14-3-18.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TrackHomeController;
@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *user_Password;
@property (weak, nonatomic) IBOutlet UITextField *user_ID;
@property(nonatomic,strong)NSDictionary *loginData;
@property (strong,nonatomic) id iobj_target;
@property (nonatomic, assign) SEL isel_action;

- (IBAction)UserLogin:(id)sender;
- (IBAction)closeLoginUI:(id)sender;


@end
