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
enum HEIGHT {
    HEIGHT1 = 100
};

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
    NSString *str=[[[dbLogin fn_get_all_msg] objectAtIndex:0] valueForKey:@"user_code"];
    NSString *str1=[[[dbLogin fn_get_all_msg] objectAtIndex:0] valueForKey:@"login_time"];
    NSString *logo=[[[dbLogin fn_get_all_msg] objectAtIndex:0] valueForKey:@"user_logo"];
   //图片不存在，整体往上移动
    if (logo==NULL || logo==nil || [logo length]==0) {
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
    _userCode.text=str;
    _userLoginTime.text=str1;
    
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [_logoutBtn addTarget:self action:@selector(clickLogout:) forControlEvents:UIControlEventTouchUpInside];
    _logoutBtn.layer.cornerRadius=7;
    [self showUserCodeAndLoginTime];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickLogout:(id)sender {
     [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController* formSheet){}];
    SuppressPerformSelectorLeakWarning([iobj_target performSelector:isel_action withObject:nil];);
}

- (IBAction)closeLogoutUI:(id)sender {
     [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController* formSheet){}];
}
@end
