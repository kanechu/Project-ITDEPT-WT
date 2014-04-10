//
//  LogoutViewController.m
//  worldtrans
//
//  Created by itdept on 14-3-29.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import "LogoutViewController.h"
#import "MZFormSheetController.h"
#import "DB_login.h"
#import "AppConstants.h"
@interface LogoutViewController ()

@end

@implementation LogoutViewController
@synthesize iobj_target;
@synthesize isel_action;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)showUserCodeAndLoginTime{
    
    DB_login *dbLogin=[[DB_login alloc]init];
    NSString *str=[[[dbLogin fn_get_all_msg] objectAtIndex:0] valueForKey:@"user_code"];
    NSString *str1=[[[dbLogin fn_get_all_msg] objectAtIndex:0] valueForKey:@"login_time"];
    NSString *logo=[[[dbLogin fn_get_all_msg] objectAtIndex:0] valueForKey:@"user_logo"];
    NSData *data=[[NSData alloc]initWithBase64EncodedString:logo options:0];
    _userImage.image=[UIImage imageWithData:data];
    _userCode.text=str;
    _userLoginTime.text=str1;
    
}
- (void)viewDidLoad
{
    [self showUserCodeAndLoginTime];
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickLogout:(id)sender {
     [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController* formSheet){}];
    SuppressPerformSelectorLeakWarning([iobj_target performSelector:isel_action withObject:nil];);
}

- (IBAction)closeLogoutUI:(id)sender {
     [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController* formSheet){}];
}
@end
