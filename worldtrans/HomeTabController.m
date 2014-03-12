//
//  ViewController.m
//  worldtrans
//
//  Created by itdept on 2/26/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "HomeTabController.h"
#import "Web_get_alert.h"
#import "DB_alert.h"

@interface HomeTabController ()

@end

@implementation HomeTabController

-(void)CustomizeTabBar{
    UITabBar *tabBar=self.tabBar;
    UITabBarItem *tabBarItem=[tabBar.items objectAtIndex:1];
    tabBarItem.title=@"Alert";
    [tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_message"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_message"] ];
    
    //Change the tab bar background
    
    //颜色创建image
    CGSize imageSize=CGSizeMake(80, 45);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [[UIColor colorWithWhite:0.6 alpha:0.8]set];
    
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pColor=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    [[UITabBar appearance]setSelectionIndicatorImage:pColor];
    
    //set tabBar backgroundColor
    [[UITabBar appearance]setBackgroundColor:[UIColor orangeColor]];
    
    
    
    //Change the title color of tab Bar items
    //Normal
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor],UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    //after click
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateHighlighted];
}

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
    
    [self CustomizeTabBar];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self gettingNotification];
        dispatch_async( dispatch_get_main_queue(), ^{
            
          NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval: 11.0 target: self
                                                   selector: @selector(gettingNotification) userInfo: nil repeats: YES];
            // Add code here to update the UI/send notifications based on the
            // results of the background processing
            
        });
    });
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
        [web_get_alert fn_get_data:@"SA" withPwd:@"SA1"];
        dispatch_async( dispatch_get_main_queue(), ^{
            // update UI here
            DB_alert * ldb_alert = [[DB_alert alloc] init];
            NSInteger li_alert_count = [ldb_alert fn_get_unread_msg_count];
            UITabBarItem *lui_tab_bar = (UITabBarItem*)[[[self tabBar] items] objectAtIndex:1];

            [lui_tab_bar setBadgeValue:[@(li_alert_count) stringValue]];
            
        });
    });
}

- (void) fn_save_alert_list: (NSMutableArray *) alist_alert {
    DB_alert * ldb_alert = [[DB_alert alloc] init];
    [ldb_alert fn_save_data:alist_alert];
}
@end
