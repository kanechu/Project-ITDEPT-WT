//
//  LoginViewController.m
//  worldtrans
//
//  Created by itdept on 14-3-18.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import "LoginViewController.h"
#import "TrackHomeController.h"
#import "MZFormSheetController.h"
#import <RestKit/RestKit.h>
#import "AuthContract.h"
#import "AppConstants.h"
#import "RequestContract.h"
#import "SearchFormContract.h"
#import "RespLogin.h"
#import "NSDictionary.h"
#import "DB_login.h"
#import "Web_base.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize loginData;
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
  
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark getData method
- (void) fn_get_data: (NSString*)user_code :(NSString*)user_pass
{
    RequestContract *req_form = [[RequestContract alloc] init];
    req_form.Auth = [[AuthContract alloc] init];
    
    req_form.Auth.user_code = user_code;
    req_form.Auth.password = user_pass;
    req_form.Auth.system = @"ITNEW";
    Web_base *web_base=[[Web_base alloc]init];
    web_base.il_url=STR_LOGIN_URL;
    web_base.iresp_class=[RespLogin class];
    web_base.ilist_resp_mapping =@[@"user_code",@"pass"];
    web_base.iobj_target = self;
    web_base.isel_action = @selector(fn_save_login_list:);
    [web_base fn_get_data:req_form];
    
}
- (void) fn_save_login_list: (NSMutableArray *) alist_result {
    
    loginData=[NSDictionary dictionaryWithPropertiesOfObject:[alist_result objectAtIndex:0]];
    
    if ([[loginData valueForKey:@"pass"] isEqualToString:@"true"]) {
        DB_login *dbLogin=[[DB_login alloc]init];
        [dbLogin fn_save_data:_user_ID.text password:_user_Password.text];
        
        
        [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController* formSheet){}];
        [iobj_target performSelector:isel_action withObject:_user_ID.text];
        
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您输入的用户名或密码不匹配" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"cancle", nil];
        [alert show];
    }
    
}


#pragma mark -userLogin method
- (IBAction)UserLogin:(id)sender {
    
    [self fn_get_data:_user_ID.text :_user_Password.text];


   
}

- (IBAction)closeLoginUI:(id)sender {
     [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController* formSheet){}];
}
@end
