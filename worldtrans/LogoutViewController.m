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
    _userCode.text=str;
    _userLoginTime.text=str1;
    if ([str isEqualToString:@"sa"]) {
        _userImage.image=[UIImage imageNamed:@"abco"];
    }else if([str isEqualToString:@"cole"]){
        _userImage.image=[UIImage imageNamed:@"cole"];
    }else if ([str isEqualToString:@"wwil"]){
        _userImage.image=[UIImage imageNamed:@"wwil"];
    }else{
        _userImage.image=nil;
    }
    
    
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
     [iobj_target performSelector:isel_action withObject:nil];
}

- (IBAction)closeLogoutUI:(id)sender {
     [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController* formSheet){}];
}
@end
