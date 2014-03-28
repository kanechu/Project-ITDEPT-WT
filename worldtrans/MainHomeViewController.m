//
//  MainHomeViewController.m
//  worldtrans
//
//  Created by itdept on 14-3-28.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import "MainHomeViewController.h"
#import "LoginViewController.h"
#import "MZFormSheetController.h"
#import "DB_login.h"
#import "Web_get_alert.h"
#import "DB_alert.h"
#import "CustomBadge.h"
@interface MainHomeViewController ()

@end

@implementation MainHomeViewController

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
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self gettingNotification];
        dispatch_async( dispatch_get_main_queue(), ^{
            
            [NSTimer scheduledTimerWithTimeInterval: 11.0 target: self
                                           selector: @selector(gettingNotification) userInfo: nil repeats: YES];
            // Add code here to update the UI/send notifications based on the
            // results of the background processing
            
        });
    });
    
	// Do any additional setup after loading the view.
}
//这是在viewDidLoad执行后才执行的方法，避免因为autoLayer,导致滚动视图不能滑动
-(void)viewDidAppear:(BOOL)animated{
    _theScrollerView.contentSize=CGSizeMake(self.view.bounds.size.width*2, 205);
    DB_login *dbLogin=[[DB_login alloc]init];
    if ([dbLogin isLoginSuccess]) {
        self.navigationItem.rightBarButtonItem.title=[[[dbLogin fn_get_all_msg] objectAtIndex:0] valueForKey:@"user_code"];
        self.navigationItem.rightBarButtonItem.action=@selector(LogOut);
        _alertButton.enabled=YES;
         _imageView.image=[UIImage imageNamed:@"abco"];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)gettingNotification {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //background task here
        Web_get_alert *web_get_alert = [[Web_get_alert alloc] init];
        web_get_alert.iobj_target = self;
        web_get_alert.isel_action = @selector(fn_save_alert_list:);
        [web_get_alert fn_get_data];
        
        dispatch_async( dispatch_get_main_queue(), ^{
            // update UI here
            
            DB_alert * ldb_alert = [[DB_alert alloc] init];
            NSInteger li_alert_count = [ldb_alert fn_get_unread_msg_count];
            CustomBadge *customBadge=[CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%d",li_alert_count] withStringColor:[UIColor whiteColor] withInsetColor:[UIColor redColor] withBadgeFrame:YES withBadgeFrameColor:[UIColor whiteColor] withScale:0.7 withShining:YES];
            [customBadge setFrame:CGRectMake(self.view.frame.size.width/2-customBadge.frame.size.width/2+_alertButton.frame.size.width/2-20,_alertButton.frame.origin.y, customBadge.frame.size.width, customBadge.frame.size.height)];
            [_theScrollerView addSubview:customBadge];
            
            
        });
    });
}

- (void) fn_save_alert_list: (NSMutableArray *) alist_alert {
    DB_alert * ldb_alert = [[DB_alert alloc] init];
    [ldb_alert fn_save_data:alist_alert];
}


- (IBAction)UserLogin:(id)sender {
    LoginViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"nav"];
    MZFormSheetController *formSheet=[[MZFormSheetController alloc]initWithViewController:VC];
    VC.iobj_target =self;
    VC.isel_action = @selector(changeRightItem:);
    //弹出视图的大小
    formSheet.presentedFormSheetSize=CGSizeMake(284, 250);
    formSheet.shadowRadius = 2.0;
    //阴影的不透明度
    formSheet.shadowOpacity = 0.3;
    //Yes是点击背景任何地方，弹出视图都消失,反之为No.默认为NO
    formSheet.shouldDismissOnBackgroundViewTap = NO;
    //中心垂直，默认为NO
    formSheet.shouldCenterVertically =YES;
    formSheet.movementWhenKeyboardAppears = MZFormSheetWhenKeyboardAppearsCenterVertically;
    [self mz_presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController){}];
    
}
//登录成功后，导航的按钮项显示为用户的名称
-(void)changeRightItem:(NSString*)userName{
    
    self.navigationItem.rightBarButtonItem.title=userName;
    self.navigationItem.rightBarButtonItem.action=@selector(LogOut);
    _alertButton.enabled=YES;
    if ([userName isEqualToString:@"sa"]) {
        _imageView.image=[UIImage imageNamed:@"abco"];
    }else if([userName isEqualToString:@"cole"]){
        _imageView.image=[UIImage imageNamed:@"cole"];
    }else if ([userName isEqualToString:@"wwil"]){
        _imageView.image=[UIImage imageNamed:@"wwil"];
    }else{
        _imageView.image=nil;
    }
}
//点击用户名称项，会调用这个方法，提示是否退出
-(void)LogOut{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否退出登录" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [alert show];
    
}
#pragma mark -UIAlertviewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //确定退出登录后，删除登录记录
    if (buttonIndex==0) {
        DB_login *dbLogin=[[DB_login alloc]init];
        [dbLogin fn_delete_record];
        self.navigationItem.rightBarButtonItem.title=@"Login";
        self.navigationItem.rightBarButtonItem.action=@selector(UserLogin:);
        
        _alertButton.enabled=NO;
        _imageView.image=nil;
    }
    
}


@end
