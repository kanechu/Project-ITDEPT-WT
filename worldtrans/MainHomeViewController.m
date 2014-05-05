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
#import "RequestContract.h"
#import "AppConstants.h"
#import "SearchFormContract.h"
#import "Web_base.h"
#import "DB_login.h"
#import "Web_get_alert.h"
#import "DB_alert.h"
#import "DB_searchCriteria.h"
#import "CustomBadge.h"
#import "Menu_home.h"
#import "Cell_menu_item.h"
#import "LogoutViewController.h"
#import "TrackHomeController.h"
#import "AlertController.h"
#import "DB_portName.h"
#import "SearchCriteriaViewController.h"
#import "RespSearchCriteria.h"
#import "NSArray.h"
@interface MainHomeViewController ()

@end
#define LOGINSHEETSIZE CGSizeMake(280, 220)
#define SHEETSIZE1 CGSizeMake(280, 250)
#define SHEETSIZE2 CGSizeMake(280, 180)
static NSInteger flag=0;
@implementation MainHomeViewController
@synthesize ilist_menu;
@synthesize iui_collectionview;
@synthesize badge_Num;
@synthesize menu_item;
CustomBadge *iobj_customBadge;

//初始化Item
- (void) fn_refresh_menu;
{
    ilist_menu = [[NSMutableArray alloc] init];
    [ilist_menu addObject:[Menu_home fn_create_item:@"Tracking" image:@"ic_ct" segue:@"segue_trackHome"]];
    [ilist_menu addObject:[Menu_home fn_create_item:@"Schedule" image:@"schedule_icon" segue:@"segue_checkSchedule"]];
    if (flag==1) {
        [ilist_menu addObject:[Menu_home fn_create_item:@"Alert" image:@"alert" segue:@"segue_alert"]];
    }
    [ilist_menu addObject:[Menu_home fn_create_item:@"Search" image:@"search" segue:@"SearchCriteria"]];
    
    self.iui_collectionview.delegate = self;
    
    self.iui_collectionview.dataSource = self;
    
    [self.iui_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell_menu"];
    
    [iobj_customBadge removeFromSuperview];
    iobj_customBadge = nil;

    [self.iui_collectionview reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_loginBtn addTarget:self action:@selector(fn_pre_login_or_logout:) forControlEvents:UIControlEventTouchUpInside];
    
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
//登陆后显示logo图片
-(void)fn_show_user_logo{
    DB_login *dbLogin=[[DB_login alloc]init];
    NSString *logo=[[[dbLogin fn_get_all_msg] objectAtIndex:0] valueForKey:@"user_logo"];
    //如果logo为空的话，是不能进行Base64编码的，需进行容错处理
    if (logo==NULL || logo==nil || logo.length==0) {
        _imageView.image=nil;
    }else{
        NSData *data=[[NSData alloc]initWithBase64EncodedString:logo options:0];
        _imageView.image=[UIImage imageWithData:data];
    }
   
}
//这是在viewDidLoad执行后才执行的方法，避免因为autoLayer,导致视图不能滑动
-(void)viewDidAppear:(BOOL)animated{
    
    DB_login *dbLogin=[[DB_login alloc]init];
    if ([dbLogin isLoginSuccess]) {
        [self BtnGraphicMixed];
        NSString *str=[[[dbLogin fn_get_all_msg] objectAtIndex:0] valueForKey:@"user_code"];
        [_loginBtn setTitle:str forState:UIControlStateNormal];
        [self fn_show_user_logo];
        //如果已经登录，设置flag=1，显示alert项
        flag=1;
        //如果已经登陆，请求搜索标准的数据
        [self fn_get_data];
        
    }else{
        [_loginBtn setTitle:@"LOGIN" forState:UIControlStateNormal];
    }
     [self fn_refresh_menu];
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
            [iobj_customBadge removeFromSuperview];
            iobj_customBadge = nil;
            badge_Num=li_alert_count;
            [iui_collectionview reloadData];
        });
    });
}

- (void) fn_save_alert_list: (NSMutableArray *) alist_alert {
    DB_alert * ldb_alert = [[DB_alert alloc] init];
    [ldb_alert fn_save_data:alist_alert];
}

- (IBAction)fn_menu_btn_clicked:(id)sender {
    UIButton *button=(UIButton*)sender;
    //button.tag用来区分点击那个Item
    menu_item=[ilist_menu objectAtIndex:button.tag];
    [self performSegueWithIdentifier:menu_item.is_segue sender:self];
    
}

-(void)PopupView:(UIViewController*)VC Size:(CGSize) sheetSize{
    MZFormSheetController *formSheet=[[MZFormSheetController alloc]initWithViewController:VC];
    //弹出视图的大小
    formSheet.presentedFormSheetSize=sheetSize;
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
//实现按钮的图文混排
-(void)BtnGraphicMixed{
    DB_login *dbLogin=[[DB_login alloc]init];
    if ([dbLogin isLoginSuccess]==NO) {
        
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setImage:nil forState:UIControlStateNormal];
        [_loginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
    }else{
        
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setImage:[UIImage imageNamed:@"userImage"] forState:UIControlStateNormal];
        NSString *str=[[[dbLogin fn_get_all_msg] objectAtIndex:0] valueForKey:@"user_code"];
        if ([str length]<=2) {
            [_loginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -50, 0, 0)];        }
        else if([str length]<16){
            NSLog(@"%d",(45+(str.length-2)/2*10));
            NSInteger left=-(45+(str.length-2)/2*10+30);
            [_loginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,left , 0, 0)];
        }else{
            [_loginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -150, 0, 0)];
        }
        [_loginBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _loginBtn.frame.size.width-35, 0, 0)];
    }
}
- (void)fn_pre_login_or_logout:(id)sender {
    DB_login *dbLogin=[[DB_login alloc]init];
    if ([dbLogin isLoginSuccess]==NO) {
        LoginViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
        VC.iobj_target =self;
        VC.isel_action = @selector(fn_after_login:);
        [self PopupView:VC Size:LOGINSHEETSIZE];
    }else{
        //点击用户名称项，执行下面的语句
        LogoutViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"Logout"];
        VC.iobj_target =self;
        VC.isel_action = @selector(fn_user_logout);
        NSString *logo=[[[dbLogin fn_get_all_msg] objectAtIndex:0] valueForKey:@"user_logo"];
        //如果logo为空的话，弹出的视图size变小
        if (logo==NULL || logo==nil || logo.length==0) {
            [self PopupView:VC Size:SHEETSIZE2];
        }else{
            [self PopupView:VC Size:SHEETSIZE1];
        }

    }
    
}
//登录成功后，导航的按钮项显示为用户的名称
-(void)fn_after_login:(NSString*)userName{
    
    [self BtnGraphicMixed];
    [_loginBtn setTitle:userName forState:UIControlStateNormal];
    //登陆后显示logo图片
    [self fn_show_user_logo];
    //登陆成功后，设置flag=1,显示alert项
     flag=1;
    [self fn_refresh_menu];
    //登陆成功后，请求搜索标准的数据
    [self fn_get_data];

}
-(void)fn_get_data{
   
    RequestContract *req_form=[[RequestContract alloc]init];
    DB_login *dbLogin=[[DB_login alloc]init];
    req_form.Auth=[dbLogin WayOfAuthorization];
    
    SearchFormContract *search=[[SearchFormContract alloc]init];
    search.os_column=@"form";
    search.os_value=@"ctschedule";
    
    req_form.SearchForm=[NSSet setWithObjects:search,nil];
    Web_base *web_base=[[Web_base alloc]init];
    web_base.il_url =STR_SEARCHCRITERIA_URL;
    web_base.iresp_class =[RespSearchCriteria class];
    
    web_base.ilist_resp_mapping =[NSArray arrayWithPropertiesOfObject:[RespSearchCriteria class]];
    web_base.iobj_target = self;
    web_base.isel_action = @selector(fn_save_searchCriteria_list:);
    [web_base fn_get_data:req_form];
    
}
//搜索标准的数据存入数据库中
-(void)fn_save_searchCriteria_list:(NSMutableArray*)ilist_result{
    DB_searchCriteria *db=[[DB_searchCriteria alloc]init];
    [db fn_save_data:ilist_result];
}

#pragma mark -UserLogOut menthod
- (void)fn_user_logout{
    
    DB_login *dbLogin=[[DB_login alloc]init];
    [dbLogin fn_delete_record];
    _imageView.image=nil;
    [self BtnGraphicMixed];
    [_loginBtn setTitle:@"LOGIN" forState:UIControlStateNormal];
    //退出登陆后，设置flag=0,隐藏alert项
    flag=0;
    [self fn_refresh_menu];
    //清除portName的缓存
    DB_portName *db=[[DB_portName alloc]init];
    [db fn_delete_all_data];
    //清除搜索标准的数据
    DB_searchCriteria *dbSearch=[[DB_searchCriteria alloc]init];
    [dbSearch fn_delete_all_data];
}

#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    // NSString *searchTerm = self.searches[section];
    return [self.ilist_menu count];
}
// 一个collectionView中的分区数
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Cell_menu_item *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell_menu_item" forIndexPath:indexPath];
    //生成圆角图片，值越大，越圆
    cell.itemButton.layer.cornerRadius=7;
    int li_item = [indexPath item];
    
    
    menu_item =  [ilist_menu objectAtIndex:li_item];
    cell.ilb_label.text = menu_item.is_label;
    [cell.itemButton setImage:[UIImage imageNamed:menu_item.is_image] forState:UIControlStateNormal];
    cell.itemButton.tag=indexPath.item;
    
    if (li_item == 1) {
        
        iobj_customBadge=[CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%d",badge_Num] withStringColor:[UIColor whiteColor] withInsetColor:[UIColor redColor] withBadgeFrame:YES withBadgeFrameColor:[UIColor whiteColor] withScale:0.7 withShining:YES];
        [iobj_customBadge setFrame:CGRectMake(cell.itemButton.frame.size.width-iobj_customBadge.frame.size.width-2,cell.itemButton.frame.origin.y-7, iobj_customBadge.frame.size.width, iobj_customBadge.frame.size.height)];
        DB_login *dbLogin=[[DB_login alloc]init];
        //登陆后和有新通知的时候，才显示badge
        if ([dbLogin isLoginSuccess]) {
            if (badge_Num>0) {
                [cell.itemButton addSubview:iobj_customBadge];
            }
            else
            {
                [iobj_customBadge removeFromSuperview];
                iobj_customBadge = nil;
            }
        }
        
    }
    return cell;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark – UICollectionViewDelegateFlowLayout


// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
        
    return UIEdgeInsetsMake(0, 5, 0, 13);
   
}

@end
