//
//  LoginViewController.m
//  worldtrans
//
//  Created by itdept on 14-3-18.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import "LoginViewController.h"
#import "MZFormSheetController.h"
#import "RespLogin.h"
#import "DB_login.h"
#import "Web_base.h"
#import "Web_get_sypara.h"
#import "MBProgressHUD.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

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

#pragma mark NewWork Request method
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
    RespLogin *login_mapObj=nil;
    if ([alist_result count]!=0) {
        login_mapObj=[alist_result objectAtIndex:0];
    }
    if ([login_mapObj.pass isEqualToString:@"true"]) {
        DB_login *dbLogin=[[DB_login alloc]init];
        NSString *userlogo=login_mapObj.user_logo;
        NSString *usercode=login_mapObj.user_code;
        [dbLogin fn_save_data:usercode password:_user_Password.text logo:userlogo];
        [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController* formSheet){}];
        SuppressPerformSelectorLeakWarning([iobj_target performSelector:isel_action withObject:_user_ID.text];);
        Web_get_sypara *sypara_obj=[[Web_get_sypara alloc]init];
        [sypara_obj fn_get_sypara_data:usercode pass:_user_Password.text];
        
    }else{
        NSString *str=@"User ID and Password do not match!";
        [self fn_Pop_up_alert:str];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
#pragma mark -function
-(void)fn_hide_HUDView{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)fn_Pop_up_alert:(NSString*)str_alert{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:str_alert delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark -userLogin method
- (IBAction)UserLogin:(id)sender {
    CheckNetWork *check_obj=[[CheckNetWork alloc]init];
    if ([check_obj fn_isPopUp_alert]==NO) {
        NSString *str=@"";
        if (_user_ID.text.length==0) {
            str=@"User ID can not be empty!";
        }else if(_user_Password.text.length==0){
            str=@"User Password can not be empty!";
        }else{
            [self fn_get_data:_user_ID.text :_user_Password.text];
            return;
        }
        [self fn_Pop_up_alert:str];
    }
    
}

- (IBAction)closeLoginUI:(id)sender {
     [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController* formSheet){}];
}
@end
