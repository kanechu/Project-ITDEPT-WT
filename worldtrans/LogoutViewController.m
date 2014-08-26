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

#define HEIGHT1 100 

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

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [_logoutBtn addTarget:self action:@selector(clickLogout:) forControlEvents:UIControlEventTouchUpInside];
    _logoutBtn.layer.cornerRadius=5;
    _logoutBtn.layer.borderWidth=1;
    _logoutBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self showUserCodeAndLoginTime];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark adjust UI
//没有logo的时候，label整体往上移动
-(void)changeLabelFrame:(UILabel*)label{
    label.frame=CGRectMake(label.frame.origin.x, label.frame.origin.y-HEIGHT1, label.frame.size.width, label.frame.size.height);
}
//没有logo的时候，Button往上移动
-(void)changeButtonFrame:(UIButton*)btn{
    btn.frame=CGRectMake(btn.frame.origin.x, btn.frame.origin.y-HEIGHT1, btn.frame.size.width, btn.frame.size.height);
}
-(void)showUserCodeAndLoginTime{
    
    DB_login *dbLogin=[[DB_login alloc]init];
    NSString *user_code=@"";
    NSString *login_time=@"";
    NSString *logo=@"";
    NSMutableArray *arr_result=[dbLogin fn_get_all_msg];
    if ([arr_result count]!=0) {
        user_code=[[arr_result objectAtIndex:0]valueForKey:@"user_code"];
        login_time=[[arr_result objectAtIndex:0]valueForKey:@"login_time"];
        logo=[[arr_result objectAtIndex:0]valueForKey:@"user_logo"];
    }
    //图片不存在，整体往上移动
    if ([logo length]==0) {
        _userImage.image=nil;
        [self changeLabelFrame:_userCode];
        [self changeLabelFrame:_userLoginTime];
        [self changeLabelFrame:_userID];
        [self changeLabelFrame:_loginTime];
        [self changeButtonFrame:_logoutBtn];
    }else{
        NSData *data=[[NSData alloc]initWithBase64EncodedString:logo options:0];
        _userImage.image=[UIImage imageWithData:data];
    }
    _userCode.text=user_code;
    _userLoginTime.text=login_time;
    
}

- (void)clickLogout:(id)sender {
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController* formSheet){}];
    SuppressPerformSelectorLeakWarning([iobj_target performSelector:isel_action withObject:nil];);
}
- (IBAction)closeLogoutUI:(id)sender {
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController* formSheet){}];
}
@end
