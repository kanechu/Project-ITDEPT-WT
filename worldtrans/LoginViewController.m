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
#import "MBProgressHUD.h"
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
    _loginBtn.layer.cornerRadius=5;
    _loginBtn.layer.borderWidth=1;
    _loginBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    //设置文本框的代理
    _user_ID.delegate=self;
    _user_Password.delegate=self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (_user_ID.editing) {
        _user_ID.layer.borderColor=[UIColor orangeColor].CGColor;
    }else if(_user_Password.editing){
        _user_Password.layer.borderColor=[UIColor orangeColor].CGColor;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    _user_ID.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _user_Password.layer.borderColor=[UIColor lightGrayColor].CGColor;
}
-(void)fn_hide_HUDView{
   
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
#pragma mark getData method
- (void) fn_get_data: (NSString*)user_code :(NSString*)user_pass
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NSTimer scheduledTimerWithTimeInterval: 11.0 target: self
                                   selector: @selector(fn_hide_HUDView) userInfo: nil repeats: NO];
    
    RequestContract *req_form = [[RequestContract alloc] init];
    AuthContract *auth=[[AuthContract alloc]init];
    auth.user_code=user_code;
    auth.password=user_pass;
    auth.system = DEFAULT_SYSTEM;
    req_form.Auth =auth;
    Web_base *web_base=[[Web_base alloc]init];
    web_base.il_url=STR_LOGIN_URL;
    web_base.iresp_class=[RespLogin class];
    web_base.ilist_resp_mapping =@[@"user_code",@"pass",@"user_logo"];
    web_base.iobj_target = self;
    web_base.isel_action = @selector(fn_save_login_list:);
    [web_base fn_get_data:req_form];
    
}
- (void) fn_save_login_list: (NSMutableArray *) alist_result {
    
    loginData=[NSDictionary dictionaryWithPropertiesOfObject:[alist_result objectAtIndex:0]];
    if ([[loginData valueForKey:@"pass"] isEqualToString:@"true"]) {
        DB_login *dbLogin=[[DB_login alloc]init];
        NSString *userlogo=[loginData valueForKey:@"user_logo"];
        NSString *usercode=[loginData valueForKey:@"user_code"];
        [dbLogin fn_save_data:usercode password:_user_Password.text logo:userlogo];
        [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController* formSheet){}];
        SuppressPerformSelectorLeakWarning([iobj_target performSelector:isel_action withObject:_user_ID.text];);
        
    }else{
        NSString *str=nil;
        if (_user_ID.text.length==0) {
            str=@"User ID can not be empty!";
        }else if(_user_Password.text.length==0){
            str=@"User Password can not be empty!";
        }else{
            str=@"User ID and Password do not match!";
        }
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}


#pragma mark -userLogin method
- (IBAction)UserLogin:(id)sender {
    
    [self fn_get_data:_user_ID.text :_user_Password.text];
   
   
}

- (IBAction)closeLoginUI:(id)sender {
     [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController* formSheet){}];
}
@end
