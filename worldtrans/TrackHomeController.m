//
//  FirstViewController.m
//  worldtrans
//
//  Created by itdept on 2/11/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "TrackHomeController.h"
#import <RestKit/RestKit.h>
#import "AuthContract.h"
#import "RequestContract.h"
#import "SearchFormContract.h"
#import "RespExhbl.h"
#import "MZFormSheetController.h"
#import "DB_login.h"
@interface TrackHomeController ()


@end

@implementation TrackHomeController
-(void)initBackgroundColor{
    [self.view setBackgroundColor:[UIColor blackColor]];
}
//给按钮添加边框的方法
-(void)addBound:(UIButton*)_sender{
   

    [_sender.layer setMasksToBounds:YES];
    
    [_sender.layer setContentsScale:22];
    [_sender.layer setCornerRadius:2.0];
    [_sender.layer setBorderWidth:1.0];
    
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
   
    //前三位是RGB 0,0,255
    CGColorRef colorRef=CGColorCreate(colorSpace, (CGFloat[]){0,0,255,2});
    
    [_sender.layer setBorderColor:colorRef];

}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self addBound:_lbtn_exhbl_search];
    [self addBound:_lbtn_exhbl_AirSearch];
    [self initBackgroundColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showDetailSegue"]){
        ExhblListController *controller = (ExhblListController *)segue.destinationViewController;
    }
    
    if([segue.identifier isEqualToString:@"segue_exhbl"]){
        ExhblListController *controller = (ExhblListController *)segue.destinationViewController;
        controller.is_search_no = @"999";
    }
   
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
    DB_login *dbLogin=[[DB_login alloc]init];
    [dbLogin fn_delete_record];
    NSLog(@"%@",[dbLogin fn_get_all_msg]);

}
//登录成功后，导航的按钮项显示为用户的名称
-(void)changeRightItem:(NSString*)userName{
    UIBarButtonItem *btnItem=[[UIBarButtonItem alloc]initWithTitle:userName style:UIBarButtonItemStyleBordered target:self action:@selector(LogOut)];
    self.navigationItem.rightBarButtonItem=btnItem;
    
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
        UIBarButtonItem *btnItem=[[UIBarButtonItem alloc]initWithTitle:@"Login" style:UIBarButtonItemStyleBordered target:self action:@selector(UserLogin:)];
        self.navigationItem.rightBarButtonItem=btnItem;
        
    }
    
}
@end
