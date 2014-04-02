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
#import "Menu_home.h"
#import "Cell_menu_item.h"
#import "LogoutViewController.h"
#import "TrackHomeController.h"
#import "AlertController.h"
@interface MainHomeViewController ()

@end

@implementation MainHomeViewController
@synthesize ilist_menu;
@synthesize iui_collectionview;
@synthesize badge_Num;
CustomBadge *iobj_customBadge;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
  
    }
    return self;
}
- (void) fn_init_menu;
{
    ilist_menu = [[NSMutableArray alloc] init];
    ilist_menu = [NSMutableArray arrayWithObjects:
                  [Menu_home fn_create_item:@"Tracking" image:@"ic_ct" segue:@"segue_trackHome"],
                  [Menu_home fn_create_item:@"Alert" image:@"alert" segue:@"segue_alert"], Nil
                  ];
    self.iui_collectionview.delegate = self;
    
    self.iui_collectionview.dataSource = self;
    
    [self.iui_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell_menu"];
    [self.iui_collectionview reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_loginBtn addTarget:self action:@selector(UserLoginOrLogout:) forControlEvents:UIControlEventTouchUpInside];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self gettingNotification];
        dispatch_async( dispatch_get_main_queue(), ^{
            
            [NSTimer scheduledTimerWithTimeInterval: 11.0 target: self
                                           selector: @selector(gettingNotification) userInfo: nil repeats: YES];
            // Add code here to update the UI/send notifications based on the
            // results of the background processing
            
        });
    });
    
    [self fn_init_menu];
	// Do any additional setup after loading the view.
}
//这是在viewDidLoad执行后才执行的方法，避免因为autoLayer,导致滚动视图不能滑动
-(void)viewDidAppear:(BOOL)animated{
    
    DB_login *dbLogin=[[DB_login alloc]init];
    if ([dbLogin isLoginSuccess]) {
        [self BtnGraphicMixed];
        NSString *str=[[[dbLogin fn_get_all_msg] objectAtIndex:0] valueForKey:@"user_code"];
        [_loginBtn setTitle:str forState:UIControlStateNormal];
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
-(void)PopupView:(UIViewController*)VC{
    MZFormSheetController *formSheet=[[MZFormSheetController alloc]initWithViewController:VC];
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
//实现按钮的图文混排
-(void)BtnGraphicMixed{
    DB_login *dbLogin=[[DB_login alloc]init];
    if ([dbLogin isLoginSuccess]==NO) {
        
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setImage:nil forState:UIControlStateNormal];
        [_loginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
    }else{
        //[_loginBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setImage:[UIImage imageNamed:@"userImage"] forState:UIControlStateNormal];
        NSString *str=[[[dbLogin fn_get_all_msg] objectAtIndex:0] valueForKey:@"user_code"];
        if ([str length]<=2) {
            [_loginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -50, 0, 0)];        }
        else if([str length]<16){
            [_loginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(45+(str.length-2)/2*10), 0, 0)];
        }else{
             [_loginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -150, 0, 0)];
        }
        [_loginBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _loginBtn.frame.size.width-35, 0, 0)];
    }
}
- (void)UserLoginOrLogout:(id)sender {
    
    DB_login *dbLogin=[[DB_login alloc]init];
    if ([dbLogin isLoginSuccess]==NO) {
        LoginViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
        VC.iobj_target =self;
        VC.isel_action = @selector(changeRightItem:);
        [self PopupView:VC];
    }else{
        //点击用户名称项，执行下面的语句
        LogoutViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"Logout"];
        VC.iobj_target =self;
        VC.isel_action = @selector(UserLogOut);
        [self PopupView:VC];
    }
   
    
}
//登录成功后，导航的按钮项显示为用户的名称
-(void)changeRightItem:(NSString*)userName{
   
    [self BtnGraphicMixed];
    [_loginBtn setTitle:userName forState:UIControlStateNormal];
    if ([userName isEqualToString:@"sa"]) {
        _imageView.image=[UIImage imageNamed:@"abco"];
    }else if([userName isEqualToString:@"cole"]){
        _imageView.image=[UIImage imageNamed:@"cole"];
    }else if ([userName isEqualToString:@"wwil"]){
        _imageView.image=[UIImage imageNamed:@"wwil"];
    }else{
        _imageView.image=nil;
    }
    //登陆成功后，UICollectionview重新加载数据，显示badge
    [iui_collectionview reloadData];
    
}


#pragma mark -UserLogOut menthod
- (void)UserLogOut{
     DB_login *dbLogin=[[DB_login alloc]init];
    [dbLogin fn_delete_record];
    _imageView.image=nil;
    [self BtnGraphicMixed];
    [_loginBtn setTitle:@"LOGIN" forState:UIControlStateNormal];
    //退出登陆后，从父视图中移除badge
    [iobj_customBadge removeFromSuperview];
}

#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
   // NSString *searchTerm = self.searches[section];
    return [self.ilist_menu count];
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Cell_menu_item *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell_menu_item" forIndexPath:indexPath];
    Menu_home * menu_item =  [ilist_menu objectAtIndex:indexPath.row];
    cell.ilb_label.text = menu_item.is_label;
    cell.itemImage.image=[UIImage imageNamed:menu_item.is_image];
    
    iobj_customBadge=[CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%d",badge_Num] withStringColor:[UIColor whiteColor] withInsetColor:[UIColor redColor] withBadgeFrame:YES withBadgeFrameColor:[UIColor whiteColor] withScale:0.7 withShining:YES];
    [iobj_customBadge setFrame:CGRectMake(cell.itemImage.frame.size.width-iobj_customBadge.frame.size.width-2,cell.itemImage.frame.origin.y-7, iobj_customBadge.frame.size.width, iobj_customBadge.frame.size.height)];
   
    if ([indexPath item]==1) {
        DB_login *dbLogin=[[DB_login alloc]init];
        //登陆后和有新通知的时候，才显示badge
        if ([dbLogin isLoginSuccess] && badge_Num>0 ) {
            [cell.itemImage addSubview:iobj_customBadge];
            
        }
    }
    
    [cell.itemImage setContentMode:UIViewContentModeScaleAspectFit];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor darkGrayColor];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     Menu_home * menu_item =  [ilist_menu objectAtIndex:indexPath.row];
    DB_login *dbLogin=[[DB_login alloc]init];
    
    if ([menu_item.is_segue isEqualToString:@"segue_trackHome"]) {
        [self performSegueWithIdentifier:@"segue_trackHome" sender:self];
    }else if ([menu_item.is_segue isEqualToString:@"segue_alert"] && [dbLogin isLoginSuccess]){
        [self performSegueWithIdentifier:@"segue_alert" sender:self];
    }
        
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark – UICollectionViewDelegateFlowLayout


// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
        
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


@end
